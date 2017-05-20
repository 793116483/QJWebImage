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



@property (nonatomic , copy)DownloadProgressing progressingBlock ;
@property (nonatomic , copy)DownloadFinished finishedBlock ;

@end

@implementation QJDownloadManager

static QJDownloadManager * _currentManager ;

+(instancetype)downloadManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _currentManager = [[self alloc] init];
    });
    
    return _currentManager;
}

-(void)setDownloadProgressing:(DownloadProgressing)downloadProgressing
{
    self.progressingBlock = downloadProgressing ;
}
-(void)setDownloadFinished:(DownloadFinished)downloadFinished
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
    QJFileManeger * fileManeger = [QJFileManeger defaultManeger];
    UIImage * cachImage = [fileManeger getImageWithImageName:imageName] ;
    if (cachImage) {
        if (self.progressingBlock) {
            self.progressingBlock(1.0, 1.0, 1.0);
        }
        if (self.finishedBlock) {
            self.finishedBlock(cachImage, [fileManeger getImagePathWithImageName:imageName]);
        }
        
        return ;
    }
    
    // 下载图片
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue new]];
    NSURLRequest * request = [NSURLRequest requestWithURL:imageURL cachePolicy:5 timeoutInterval:60.0f];
    NSURLSessionDownloadTask * downloadTask =  [session downloadTaskWithRequest:request];
    
    // 开始请求
    [downloadTask resume];
}

#pragma mark - NSURLSessionDownloadDelegate
// 下载进度
-(void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (self.progressingBlock) { // 下载进度
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressingBlock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        });
    }
    
}

// 下载完成
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString * imageName = [QJImagePathHandle imageNameForBase64Handle:self.imageURL.absoluteString];
    
    QJFileManeger * fileManeger = [QJFileManeger defaultManeger];
    
    // 移动位置
    BOOL moveSucceed = [fileManeger moveItemAtPath:location.path toPath:imageName];
    
    NSLog(@">>>>>> 下载的文件移动 %@",moveSucceed ? @"成功":@"失败");
//    if (!moveSucceed) {
//        imageName = location.absoluteString ;
//    }
    
    UIImage * image = [fileManeger getImageWithImageName:imageName];

    if (self.finishedBlock) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.finishedBlock(image, [fileManeger getImagePathWithImageName:imageName]) ;
        });
    }

}


@end
