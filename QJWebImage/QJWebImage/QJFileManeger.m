//
//  QJFileManeger.m
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "QJFileManeger.h"

@interface QJFileManeger ()

@property (nonatomic , strong)NSFileManager * fileManager;

@end

@implementation QJFileManeger

static QJFileManeger * _currentFileManager ;

+(instancetype)defaultManeger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _currentFileManager = [[self alloc] init];
        _currentFileManager.fileManager = [NSFileManager defaultManager];
        _currentFileManager.rootFolderName = @"QJWebImageFile" ;
    });

    return _currentFileManager;
}

+(NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

-(BOOL)moveItemAtPath:(NSString *)atPath toPath:(NSString *)toPath
{
    NSString * path = [[QJFileManeger documentPath] stringByAppendingFormat:@"/%@/%@",self.rootFolderName,toPath];

    return [self.fileManager moveItemAtPath:atPath toPath:path error:nil] ;
}
-(BOOL)moveItemAtURL:(NSURL *)atURL toURL:(NSURL *)toURL
{
    return [self.fileManager moveItemAtURL:atURL toURL:toURL error:nil];
}

-(BOOL)removeImageWithImageName:(NSString *)imageName
{
    NSString * path = [[QJFileManeger documentPath] stringByAppendingFormat:@"/%@/%@",self.rootFolderName,imageName];
   return [self.fileManager removeItemAtPath:path error:nil];
}

-(BOOL)folderPathIsExist:(NSString *)folderPath
{
    return [self.fileManager fileExistsAtPath:folderPath];
}

-(BOOL)fileIsExist:(NSString *)fileName
{
    NSString * path = [[QJFileManeger documentPath] stringByAppendingFormat:@"/%@/%@",self.rootFolderName,fileName];

    return [self.fileManager fileExistsAtPath:path];
}

-(NSString *)getImagePathWithImageName:(NSString *)imageName
{
    if (![self fileIsExist:imageName]) {
        return nil ;
    }
    
    NSString * path = [[QJFileManeger documentPath] stringByAppendingFormat:@"/%@/%@",self.rootFolderName,imageName];

    return path ;
}

-(UIImage *)getImageWithImageName:(NSString *)imageName
{
    NSString * path = [self getImagePathWithImageName:imageName];
    if (!path) {
        return nil ;
    }
    
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    
    return image ;
}

@end
