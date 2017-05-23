//
//  QJWebImageManager.h
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommentHeader.h"

@interface QJWebImageManager : NSObject

+(void)startDownloadImageWithURL:(NSURL *)imageURL downloadProgressing:(QJDownloadProgressing)downloadProgressing downloadFinished:(QJDownloadFinished)downloadFinished;

+(void)startDownloadImageWithUrlStr:(NSString *)imageUrlStr downloadProgressing:(QJDownloadProgressing)downloadProgressing downloadFinished:(QJDownloadFinished)downloadFinished;

@end
