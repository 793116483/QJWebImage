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
    
    [imageView qj_setImageWithUrlStr:@"http://www.bz55.com/uploads/allimg/150417/139-15041G02614.jpg" downloadProgressing:^(CGFloat curDownloadSize, CGFloat didDownloadSize, CGFloat needDownloadSize) {
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
