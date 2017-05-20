//
//  QJWebImageManager.m
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "QJWebImageManager.h"
#import "QJDownloadManager.h"

@implementation QJWebImageManager

+(QJDownloadManager *)downloadManagerSetProgressing:(DownloadProgressing)downloadProgressing downloadFinished:(DownloadFinished)downloadFinished
{
    QJDownloadManager * downloadManager = [QJDownloadManager downloadManager];
    
    [downloadManager setDownloadProgressing:downloadProgressing];
    [downloadManager setDownloadFinished:downloadFinished];
    
    return downloadManager ;
}

+(void)startDownloadImageWithUrlStr:(NSString *)imageUrlStr downloadProgressing:(DownloadProgressing)downloadProgressing downloadFinished:(DownloadFinished)downloadFinished
{
    QJDownloadManager * downloadManager = [self downloadManagerSetProgressing:downloadProgressing downloadFinished:downloadFinished];
    
    [downloadManager startDownloadImageWithPath:imageUrlStr];
}

+(void)startDownloadImageWithURL:(NSURL *)imageURL downloadProgressing:(DownloadProgressing)downloadProgressing downloadFinished:(DownloadFinished)downloadFinished
{
    QJDownloadManager * downloadManager = [self downloadManagerSetProgressing:downloadProgressing downloadFinished:downloadFinished];
    
    [downloadManager startDownloadImageWithURL:imageURL];
}

@end
