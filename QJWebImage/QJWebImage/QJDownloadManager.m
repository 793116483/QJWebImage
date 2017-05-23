//
//  QJDownloadManager.m
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "QJDownloadManager.h"
#import "QJImagePathHandle.h"
#import "QJFileManeger.h"

@interface QJDownloadManager ()<NSURLSessionDownloadDelegate>

@property (nonatomic , copy)NSString * imagePath ;
@property (nonatomic , strong)NSURL * imageURL ;

@property (nonatomic , strong)NSURLSession * session ;

@property (nonatomic , copy)QJDownloadProgressing progressingBlock ;
@property (nonatomic , copy)QJDownloadFinished finishedBlock ;

@end

@implementation QJDownloadManager

+(instancetype)downloadManeger
{
    return [[self alloc] init];
}

-(void)setDownloadProgressing:(QJDownloadProgressing)downloadProgressing
{
    self.progressingBlock = downloadProgressing ;
}
-(void)setDownloadFinished:(QJDownloadFinished)downloadFinished
{
    self.finishedBlock = downloadFinished ;
}

-(void)startDownloadImageWithPath:(NSString *)imagePath
{
    self.imagePath = imagePath ;
    NSURL * imageURL = [NSURL URLWithString:imagePath];
    [self startDownloadImageWithURL:imageURL];
}

-(void)startDownloadImageWithURL:(NSURL *)imageURL
{
    self.imageURL = imageURL ;
    
    // 读缓存
    NSString * imageName = [QJImagePathHandle imageNameForBase64Handle:self.imageURL.absoluteString];
    
    if ([[QJFileManeger defaultManeger] fileIsExist:imageName]) {
        
        QJFileManeger * fileManeger = [QJFileManeger defaultManeger];
        UIImage * cachImage = [fileManeger getImageWithImageName:imageName] ;
        NSInteger fileSize = [fileManeger imageFileSizeWithImageName:imageName];
        
        if (self.progressingBlock) {
            self.progressingBlock((NSInteger)(fileSize / 1000.0 + 0.5), (NSInteger)(fileSize / 1000.0 + 0.5), (NSInteger)(fileSize / 1000.0 + 0.5));
        }
        if (self.finishedBlock) {
            self.finishedBlock(cachImage, [fileManeger getImagePathWithImageName:imageName]);
        }
        
        return ;
    }
    
    // 下载图片
    if (!self.session) {
        NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue new]];

        self.session =  session;
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:imageURL cachePolicy:5 timeoutInterval:60.0f];
    NSURLSessionDownloadTask * downloadTask =  [self.session downloadTaskWithRequest:request];
    
    // 开始请求
    [downloadTask resume];
}

#pragma mark - NSURLSessionDownloadDelegate
// 下载进度
-(void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (self.progressingBlock) { // 下载进度
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressingBlock((NSInteger)(bytesWritten / 1000.0 + 0.5), (NSInteger)(totalBytesWritten / 1000.0 + 0.5), (NSInteger)(totalBytesExpectedToWrite / 1000.0 + 0.5));
        });
    }
    
}

// 下载完成
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
    NSString * imageName = [QJImagePathHandle imageNameForBase64Handle:self.imageURL.absoluteString];
    
    QJFileManeger * fileManeger = [QJFileManeger defaultManeger];
    NSString * imagePath = [fileManeger getImagePathWithImageName:imageName];
    
    // 把下载好的 图片从 location 移动到 imagePath 位置里
    BOOL moveSucceed = [fileManeger moveItemAtPath:location.path toPath:imagePath];
    
    NSLog(@">>>>>> 下载的文件移动 %@",moveSucceed ? @"成功":@"失败");
    
    // 通过 imageName 获取图片
    UIImage * image = [fileManeger getImageWithImageName:imageName];

    if (self.finishedBlock) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.finishedBlock(image, imagePath) ;
            
            [self.session finishTasksAndInvalidate];
            [self.session invalidateAndCancel];
            self.session = nil ;
        });
    }

}


@end
