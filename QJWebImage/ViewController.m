//
//  ViewController.m
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+QJWebImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor blueColor];
    imageView.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:imageView];
    
    NSString * testImageURL1 = @"http://www.bz55.com/uploads/allimg/150417/139-15041G02614.jpg";
    
    NSString * testImageURL2 = @"http://a.hiphotos.baidu.com/zhidao/pic/item/faedab64034f78f0b7111ba67b310a55b3191c48.jpg";
    
    NSString * testImageURL3 = @"http://c.hiphotos.baidu.com/zhidao/pic/item/730e0cf3d7ca7bcb48f80cb9bc096b63f724a8a1.jpg";
    
    [imageView qj_setImageWithUrlStr:testImageURL2 downloadProgressing:^(CGFloat curDownloadSize, CGFloat didDownloadSize, CGFloat needDownloadSize) {
        NSLog(@"下载进度 当前下载了 = %lf , 已经下载了 %lf , 下载百分比 = %lf%%",curDownloadSize , didDownloadSize , didDownloadSize / needDownloadSize * 100);
    } downloadFinished:^(UIImage *image, NSString *filePath) {
        NSLog(@"下载完成 imagePath = %@",filePath);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
