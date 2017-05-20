//
//  UIImageView+QJWebImage.h
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentHeader.h"

@interface UIImageView (QJWebImage)

-(void)qj_setImageWithURL:(NSURL *)imageURL ;

-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr ;

-(void)qj_setImageWithURL:(NSURL *)imageURL downloadProgressing:(DownloadProgressing)downloadProgressing downloadFinished:(DownloadFinished)downloadFinished;

-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr downloadProgressing:(DownloadProgressing)downloadProgressing downloadFinished:(DownloadFinished)downloadFinished;

@end
