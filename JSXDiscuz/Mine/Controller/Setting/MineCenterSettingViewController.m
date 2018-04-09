//
//  MineCenterSettingViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterSettingViewController.h"
#import "MineCenterSettingViewController_info.h"
#import "MineCenterSettingViewController_pwd.h"
#import "MineCenterSettingViewController_private.h"
#import "MineCenterSettingViewController_bondPhone.h"

@interface MineCenterSettingViewController ()<UIScrollViewDelegate>
{
    UIView * lineView;
}
@end

@implementation MineCenterSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"个人设置";
    
    MineCenterSettingViewController_info * modevc =[[MineCenterSettingViewController_info alloc]init];
    [self addChildViewController:modevc];
    
    MineCenterSettingViewController_pwd * newvc =[[MineCenterSettingViewController_pwd alloc]init];
    [self addChildViewController:newvc];
    
    MineCenterSettingViewController_bondPhone * recvc =[[MineCenterSettingViewController_bondPhone alloc]init];
    [self addChildViewController:recvc];
    
    MineCenterSettingViewController_private * albumvc =[[MineCenterSettingViewController_private alloc]init];
    [self addChildViewController:albumvc];
    
    self.contentScrollView.delegate=self;
    self.contentScrollView.pagingEnabled=YES;
    self.contentScrollView.contentSize=CGSizeMake(SDScreenWidth*4,self.contentScrollView.height);
    
    //默认选中第一个标签页
    self.currentPage=0;
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(SDScreenWidth/8-30, 49, 60, 1)];
    lineView.backgroundColor=ThemeColor;
    [self.barView addSubview:lineView];
    
    modevc.view.frame=CGRectMake(0, 0, self.contentScrollView.width, self.contentScrollView.height);
    [self.contentScrollView addSubview:modevc.view];
    self.contentScrollView.contentOffset=CGPointMake(0, 0);
    
    [self refreshNavBar];
}


- (IBAction)clickBtn1:(id)sender {
    self.currentPage=0;
    [self refreshNavBar];
    [self.contentScrollView setContentOffset:CGPointMake(SDScreenWidth*self.currentPage, 0) animated:YES];
}
- (IBAction)clickBtn2:(id)sender {
    self.currentPage=1;
    [self refreshNavBar];
    [self.contentScrollView setContentOffset:CGPointMake(SDScreenWidth*self.currentPage, 0) animated:YES];
}
- (IBAction)clickBtn3:(id)sender {
    self.currentPage=2;
    [self refreshNavBar];
    [self.contentScrollView setContentOffset:CGPointMake(SDScreenWidth*self.currentPage, 0) animated:YES];
}
- (IBAction)clickBtn4:(id)sender {
    self.currentPage=3;
    [self refreshNavBar];
    [self.contentScrollView setContentOffset:CGPointMake(SDScreenWidth*self.currentPage, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.currentPage = scrollView.contentOffset.x/SDScreenWidth;
    UIViewController * vc = self.childViewControllers[self.currentPage];
    if(![vc isViewLoaded])
    {
        vc.view.frame=CGRectMake(self.contentScrollView.width*self.currentPage, 0, self.contentScrollView.width, self.contentScrollView.height);
        [self.contentScrollView addSubview:vc.view];
    }
    
    [self refreshNavBar];
}

-(void)refreshNavBar
{
    switch (self.currentPage) {
        case 0:
            self.btn1.selected=YES;
            self.btn2.selected=NO;
            self.btn3.selected=NO;
            self.btn4.selected=NO;
            lineView.x=SDScreenWidth/8-30;
            break;
        case 1:
            self.btn1.selected=NO;
            self.btn2.selected=YES;
            self.btn3.selected=NO;
            self.btn4.selected=NO;
            lineView.x=SDScreenWidth/8*3-30;
            break;
        case 2:
            self.btn1.selected=NO;
            self.btn2.selected=NO;
            self.btn3.selected=YES;
            self.btn4.selected=NO;
            lineView.x=SDScreenWidth/8*5-30;
            break;
        case 3:
            self.btn1.selected=NO;
            self.btn2.selected=NO;
            self.btn3.selected=NO;
            self.btn4.selected=YES;
            lineView.x=SDScreenWidth/8*7-30;
            break;
            
        default:
            break;
    }
}

@end
