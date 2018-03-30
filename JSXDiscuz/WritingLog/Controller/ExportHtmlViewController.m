//
//  ExportHtmlViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/29.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "ExportHtmlViewController.h"
#import <WebKit/WebKit.h>

@interface ExportHtmlViewController ()
{
    UIWebView * web;
}
@end

@implementation ExportHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"HTML";
    web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [web loadHTMLString:self.htmlStr baseURL:nil];
    [self.view addSubview:web];
}

@end
