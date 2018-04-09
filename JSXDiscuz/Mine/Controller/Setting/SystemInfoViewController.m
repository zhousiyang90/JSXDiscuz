//
//  SystemInfoViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "SystemInfoViewController.h"
#import "FeedBackViewController.h"

@interface SystemInfoViewController ()

@end

@implementation SystemInfoViewController

-(void)addSubViews
{
    UITapGestureRecognizer * tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview1)];
    [self.bgview1 setUserInteractionEnabled:YES];
    [self.bgview1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview2)];
    [self.bgview2 setUserInteractionEnabled:YES];
    [self.bgview2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview4)];
    [self.bgview4 setUserInteractionEnabled:YES];
    [self.bgview4 addGestureRecognizer:tap4];
    
    UITapGestureRecognizer * tap5=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview5)];
    [self.bgview5 setUserInteractionEnabled:YES];
    [self.bgview5 addGestureRecognizer:tap5];
    
    self.lab2.text=[NSString stringWithFormat:@"%.2fM",[self readCacheSize]];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.lab3.text=app_Version;
    
}

-(void)setNavigationBar
{
    self.title=@"系统信息";
}

-(void)clickbgview1
{
    
}

-(void)clickbgview2
{
    [self clearFile];
}

-(void)clickbgview4
{
    FeedBackViewController * vc=[[FeedBackViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickbgview5
{
    
}

-(float)readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [self folderSizeAtPath :cachePath];
}


// 遍历文件夹获得文件夹大小，返回多少M
- (float)folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0);
}



// 计算单个文件的大小
- (long) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}



- (void)clearFile
{
    [SVProgressHUD show];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }

    self.lab2.text = @"0.0M";
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"清除成功"];
}
@end
