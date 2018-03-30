//
//  BaseNavigationViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "UIBarButtonItem+BackButtun.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
    if (self.viewControllers.count > 0) {
        //自动显示和隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"fh" highImage:@"fh" title:@""];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
