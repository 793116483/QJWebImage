//
//  CommentHeader.h
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#ifndef CommentHeader_h
#define CommentHeader_h

typedef void(^DownloadProgressing)(CGFloat curDownloadSize , CGFloat didDownloadSize , CGFloat needDownloadSize);
typedef void(^DownloadFinished)(UIImage * image , NSString * filePath);

#define QJWeakSelf __weak typeof(self) weakSelf = self

#endif /* CommentHeader_h */
