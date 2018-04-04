//
//  BaseTabBarViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "FirstPageViewController.h"
#import "BaseNavigationViewController.h"
#import "DiscoveryViewController.h"
#import "GroupViewController.h"
#import "CommunityViewController.h"
#import "MineViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

#pragma mark - 保证TabBarVC单例
// 创建静态对象 防止外部访问
static BaseTabBarViewController *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}
// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+(instancetype)shareBaseTabBarViewController
{
    //return _instance;
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
}
// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

#pragma mark - 初始化TabBarVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        FirstPageViewController *vc1 = [[FirstPageViewController alloc] init];
        [self setupChild:vc1 Navtitle:@"首页" TabTitle:@"首页" icon:@"SY01" iconHight:@"SY02"];
        
        CommunityViewController *vc2 = [[CommunityViewController alloc] init];
        [self setupChild:vc2 Navtitle:@"社区" TabTitle:@"社区" icon:@"SQ01" iconHight:@"SQ02"];
        
        GroupViewController *vc3 = [[GroupViewController alloc] init];
        [self setupChild:vc3 Navtitle:@"小组" TabTitle:@"小组" icon:@"XZ01" iconHight:@"XZ02"];
        
        DiscoveryViewController *vc4 = [[DiscoveryViewController alloc] init];
        [self setupChild:vc4 Navtitle:@"发现" TabTitle:@"发现" icon:@"FX01" iconHight:@"FX02"];
        
        MineViewController *vc5 = [[MineViewController alloc] init];
        [self setupChild:vc5 Navtitle:@"我的" TabTitle:@"我的" icon:@"WD01" iconHight:@"WD02"];
    }
    return self;
}


- (BaseNavigationViewController *)setupChild:(UIViewController *)vc Navtitle:(NSString *)NavTitle TabTitle:(NSString *)TabTitle icon:(NSString *)icon iconHight:(NSString *)iconHighlt{
    
    // 1.添加
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];

    // 2.设置导航条属性
    nav.navigationBar.barTintColor = ThemeColor;
    nav.tabBarItem.title = TabTitle;
    nav.navigationBar.translucent=NO;
    [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [nav.navigationBar setShadowImage:[[UIImage alloc] init]];
    vc.title = NavTitle;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    [nav.navigationBar setTitleTextAttributes:dict];
    
    // 3.设置TabBar属性
    NSMutableDictionary *selDict = [NSMutableDictionary dictionary];
    selDict[NSForegroundColorAttributeName] = SDColor(171, 206, 224);
    selDict[NSFontAttributeName] = SDFontOf12;
    [nav.tabBarItem setTitleTextAttributes:selDict forState:UIControlStateNormal];
    NSMutableDictionary *selDict2 = [NSMutableDictionary dictionary];
    selDict2[NSForegroundColorAttributeName] = ThemeColor;
    selDict2[NSFontAttributeName] = SDFontOf12;
    [nav.tabBarItem setTitleTextAttributes:selDict2 forState:UIControlStateSelected];
    nav.tabBarController.tabBar.backgroundColor=[UIColor whiteColor];
    nav.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    [UITabBar appearance].translucent = NO;
    [nav.tabBarItem setImage:[[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setSelectedImage:[[UIImage imageNamed:iconHighlt] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self addChildViewController:nav];
    
    return nav;
}

@end
