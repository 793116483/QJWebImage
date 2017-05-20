//
//  QJDownloadManager.h
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommentHeader.h"

@interface QJDownloadManager : NSObject

+(instancetype)downloadManager;

-(void)startDownloadImageWithURL:(NSURL *)imageURL ;
-(void)startDownloadImageWithPath:(NSString *)imagePath ;

// 设置回调的 block
// 1.下载进度
-(void)setDownloadProgressing:(DownloadProgressing)downloadProgressing ;
// 2.下载完成
-(void)setDownloadFinished:(DownloadFinished)downloadFinished ;

@end
