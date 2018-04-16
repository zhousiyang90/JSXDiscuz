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

@interface TabbarLayoutData: NSObject

@property(nonatomic) Class viewcontrollerclass;
@property(nonatomic) NSString * titleName;
@property(nonatomic) NSString * icon;
@property(nonatomic) NSString * icon_highlight;

@end

@implementation TabbarLayoutData
@end

@interface BaseTabBarViewController ()<UITabBarControllerDelegate>

@property(nonatomic,strong) NSMutableArray * layoutList;

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
        self.delegate=self;
        for (int i=0; i<self.layoutList.count; i++) {
            TabbarLayoutData * data=self.layoutList[i];
            [self setupChild:data andIndex:i];
        }
    }
    return self;
}

- (BaseNavigationViewController *)setupChild:(TabbarLayoutData *)data andIndex:(NSInteger)index{
    
    UIViewController *vc=[[data.viewcontrollerclass alloc]init];
    // 1.添加
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
    
    // 2.设置导航条属性
    nav.navigationBar.barTintColor = ThemeColor;
    nav.tabBarItem.title = data.titleName;
    nav.navigationBar.translucent=NO;
    [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [nav.navigationBar setShadowImage:[[UIImage alloc] init]];
    vc.title = data.titleName;
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
    [nav.tabBarItem setImage:[[UIImage imageNamed:data.icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setSelectedImage:[[UIImage imageNamed:data.icon_highlight] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    nav.tabBarItem.tag=index;
    [self addChildViewController:nav];
    
    return nav;
}

-(NSMutableArray *)layoutList
{
    if(_layoutList==nil)
    {
        _layoutList=[NSMutableArray array];
        TabbarLayoutData *data1=[[TabbarLayoutData alloc]init];
        data1.viewcontrollerclass=FirstPageViewController.class;
        data1.titleName=@"首页";
        data1.icon=@"SY01";
        data1.icon_highlight=@"SY02";
        TabbarLayoutData *data2=[[TabbarLayoutData alloc]init];
        data2.viewcontrollerclass=CommunityViewController.class;
        data2.titleName=@"社区";
        data2.icon=@"SQ01";
        data2.icon_highlight=@"SQ02";
        TabbarLayoutData *data3=[[TabbarLayoutData alloc]init];
        data3.viewcontrollerclass=GroupViewController.class;
        data3.titleName=@"小组";
        data3.icon=@"XZ01";
        data3.icon_highlight=@"XZ02";
        TabbarLayoutData *data4=[[TabbarLayoutData alloc]init];
        data4.viewcontrollerclass=DiscoveryViewController.class;
        data4.titleName=@"发现";
        data4.icon=@"FX01";
        data4.icon_highlight=@"FX02";
        TabbarLayoutData *data5=[[TabbarLayoutData alloc]init];
        data5.viewcontrollerclass=MineViewController.class;
        data5.titleName=@"我的";
        data5.icon=@"WD01";
        data5.icon_highlight=@"WD02";
        [_layoutList addObject:data1];
        [_layoutList addObject:data2];
        [_layoutList addObject:data3];
        [_layoutList addObject:data4];
        [_layoutList addObject:data5];
        
    }
    return _layoutList;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if(viewController.childViewControllers.count>0)
    {
        UIViewController * vc=viewController.childViewControllers.firstObject;
        if(vc.class==MineViewController.class)
        {
            if([UserDataTools getUserInfo].userPhone.length==0)
            {
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"登录"message:@"登录后才能查看"
                                                                                   preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    LoginViewController * vc=[LoginViewController shareLoginViewController];
                    [self presentViewController:vc animated:vc completion:nil];
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertController addAction:sureAction];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
                return NO;
            }
            
        }
    }
    return YES;
}

@end
