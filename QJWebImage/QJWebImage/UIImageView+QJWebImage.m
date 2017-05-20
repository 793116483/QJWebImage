//
//  UIImageView+QJWebImage.m
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "UIImageView+QJWebImage.h"

#import "QJWebImageManager.h"
#import <objc/runtime.h>

@implementation UIImageView (QJWebImage)

-(void)qj_setImageWithURL:(NSURL *)imageURL
{
    [self qj_setImageWithURL:imageURL downloadProgressing:nil downloadFinished:nil];
}

-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr
{
    [self qj_setImageWithUrlStr:imageUrlStr downloadProgressing:nil downloadFinished:nil];
}

-(void)qj_setImageWithURL:(NSURL *)imageURL downloadProgressing:(DownloadProgressing)downloadProgressing downloadFinished:(DownloadFinished)downloadFinished
{
    QJWeakSelf ;

    DownloadFinished finished = ^(UIImage * image , NSString * filePath){
        
        weakSelf.image = image ;

        if (downloadFinished) {
            downloadFinished(image,filePath);
        }
    };
    
    [QJWebImageManager startDownloadImageWithURL:imageURL downloadProgressing:downloadProgressing downloadFinished:finished];
}

-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr downloadProgressing:(DownloadProgressing)downloadProgressing downloadFinished:(DownloadFinished)downloadFinished
{
    QJWeakSelf ;
    
    DownloadFinished finished = ^(UIImage * image , NSString * filePath){
        
        weakSelf.image = image ;
        
        if (downloadFinished) {
            downloadFinished(image,filePath);
        }
    };
    
    [QJWebImageManager startDownloadImageWithUrlStr:imageUrlStr downloadProgressing:downloadProgressing downloadFinished:finished];
}

@end
