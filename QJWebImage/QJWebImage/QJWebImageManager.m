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

+(QJDownloadManager *)downloadManagerSetProgressing:(QJDownloadProgressing)downloadProgressing downloadFinished:(QJDownloadFinished)downloadFinished
{
    QJDownloadManager * downloadManager = [QJDownloadManager downloadManeger];
    
    [downloadManager setDownloadProgressing:downloadProgressing];
    [downloadManager setDownloadFinished:downloadFinished];
    
    return downloadManager ;
}

+(void)startDownloadImageWithUrlStr:(NSString *)imageUrlStr downloadProgressing:(QJDownloadProgressing)downloadProgressing downloadFinished:(QJDownloadFinished)downloadFinished
{
    QJDownloadManager * downloadManager = [self downloadManagerSetProgressing:downloadProgressing downloadFinished:downloadFinished];
    
    [downloadManager startDownloadImageWithPath:imageUrlStr];
}

+(void)startDownloadImageWithURL:(NSURL *)imageURL downloadProgressing:(QJDownloadProgressing)downloadProgressing downloadFinished:(QJDownloadFinished)downloadFinished
{
    QJDownloadManager * downloadManager = [self downloadManagerSetProgressing:downloadProgressing downloadFinished:downloadFinished];
    
    [downloadManager startDownloadImageWithURL:imageURL];
}

@end
