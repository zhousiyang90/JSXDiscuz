//
//  BaseViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"
#import "NoNetView.h"

@interface BaseViewController ()<NoNetViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation BaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    BaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController addSubViews];
        [viewController getInitData];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController setNavigationBar];
    }];
    
    return viewController;
}

#pragma mark - 设置导航条样式

-(void)setNavigationBar
{
    
}

#pragma mark - 添加子页面

-(void)addSubViews
{
    
}

#pragma mark - 注册通知

-(void)registerNotification
{
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:Notification_Logout object:nil]subscribeNext:^(id x) {
        LoginViewController * vc=[LoginViewController shareLoginViewController];
        [self presentViewController:vc animated:vc completion:nil];
    }];
}

#pragma mark - 获取初始化数据

-(void)getInitData
{
    
}

#pragma mark - 生命周期方法

- (void)dealloc {
    SDLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}


#pragma mark - SET方法

-(void)setNeedNoNetTips:(BOOL)needNoNetTips
{
    _needNoNetTips=needNoNetTips;
    if(needNoNetTips)
    {
        [self checkNoNetStatus];
    }
}

-(void)setBaseTableview:(UITableView *)baseTableview
{
    _baseTableview=baseTableview;
    
    if (@available(iOS 11.0, *)) {
        _baseTableview.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    if(self.needNoTableViewDataTips)
    {
        _baseTableview.emptyDataSetSource=self;
        _baseTableview.emptyDataSetDelegate=self;
    }
}

#pragma mark - 无网络连接相关方法(私有)

-(BOOL)isMayUseInternet
{
    Reachability * r =[Reachability reachabilityWithHostname:@"www.baidu.com"];
    return r.isReachable;
}

-(void)checkNoNetStatus
{
    if(![self isMayUseInternet])
    {
        [self addNoNetView];
    }else
    {
        [self hideNoNetView];
    }
}

-(void)addNoNetView
{
    NSInteger tag = 0;
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[NoNetView class]]) {
            tag++;
        }
    }
    if(tag>0)
    return;
    
    NoNetView * view = [NoNetView getView];
    view.frame=self.view.bounds;
    view.delegate=self;
    [self.view addSubview:view];
}

-(void)hideNoNetView
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[NoNetView class]]) {
            [view removeFromSuperview];
        }
    }
    
}


-(void)nonetstatusGetData
{
    if([self isMayUseInternet])
    {
        [self hideNoNetView];
    }
}

#pragma mark - TableView空数据相关方法(私有)

#pragma mark DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (_noDataString.length == 0) {
        text = @"暂无数据";
    } else {
        text = _noDataString;
        
    }
    font = SDFontOf16;
    textColor =SDColor(155, 155, 155);
    [attributes setObject:@(0.45) forKey:NSKernAttributeName];
    if (!text) {
        return nil;
    }
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    font = SDBoldFontOf18;
    textColor = SDColor(155, 155, 155);
    
    if (!text) {
        return nil;
    }
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *imageName;
    if (_noDataImage.length == 0) {
        imageName = [NSString stringWithFormat:@"no_information"];
    } else {
        imageName = _noDataImage;
    }
    return [UIImage imageNamed:imageName];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return nil;
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return nil;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    
    return nil;
    
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -50;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    
    return 20;
    
}

#pragma mark DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return NO;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}

@end
