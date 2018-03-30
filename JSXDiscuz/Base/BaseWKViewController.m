//
//  BaseWKViewController.m
//  KcalOfDriver
//
//  Created by 周思扬 on 2017/11/6.
//  Copyright © 2017年 liang. All rights reserved.
//

#import "BaseWKViewController.h"
#import <WebKit/WebKit.h>

#define SendDataList @""ShiDeInterface"driverController.do?api/readAd"

@interface BaseWKViewController ()

@property(nonatomic,weak) WKWebView * webView;

@property(nonatomic,weak) CALayer * progresslayer;

@property(nonatomic,weak) UIView * progress;

@end

@implementation BaseWKViewController

-(void)setNavigationBar
{
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.title=self.navTitle;
}

-(void)addSubViews
{
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SDScreenWidth, SDScreenHeight-self.navigationController.navigationBar.bounds.size.height-[UIApplication sharedApplication].statusBarFrame.size.height)];
    NSURLRequest * req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:20.0];
    [webView loadRequest:req];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:webView];
    self.webView = webView;
    
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    self.progress=progress;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor =SDColor(255,105,105).CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}

#pragma mark - 生命周期方法

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


#pragma mark - 监听进度条

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



@end
