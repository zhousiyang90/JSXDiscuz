//
//  CommunityViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityViewController_Rec.h"
#import "CommunityViewController_Mode.h"
#import "CommunityViewController_Album.h"
#import "CommunityViewController_Newest.h"

@interface CommunityViewController ()<UIScrollViewDelegate>
{
    NSInteger currentPage;
    
    UIView * lineView;
}
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CommunityViewController_Mode * modevc =[[CommunityViewController_Mode alloc]init];
    [self addChildViewController:modevc];
    
    CommunityViewController_Newest * newvc =[[CommunityViewController_Newest alloc]init];
    [self addChildViewController:newvc];
    
    CommunityViewController_Rec * recvc =[[CommunityViewController_Rec alloc]init];
    [self addChildViewController:recvc];
    
    CommunityViewController_Album * albumvc =[[CommunityViewController_Album alloc]init];
    [self addChildViewController:albumvc];
    
    self.contentScrollView.delegate=self;
    self.contentScrollView.pagingEnabled=YES;
    self.contentScrollView.contentSize=CGSizeMake(SDScreenWidth*4,self.contentScrollView.height);
    
    //默认选中第一个标签页
    lineView = [[UIView alloc]initWithFrame:CGRectMake(SDScreenWidth/8-30, 49, 60, 1)];
    lineView.backgroundColor=SDColor(46, 196, 252);
    [self.barView addSubview:lineView];
    
    currentPage=0;
    modevc.view.frame=CGRectMake(0, 0, SDScreenWidth, self.contentScrollView.height);
    [self.contentScrollView addSubview:modevc.view];
    self.contentScrollView.contentOffset=CGPointMake(0, 0);
    
    [self refreshNavBar];
}


- (IBAction)clickBtn1:(id)sender {
    currentPage=0;
    [self refreshNavBar];
    [self.contentScrollView setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
}
- (IBAction)clickBtn2:(id)sender {
    currentPage=1;
    [self refreshNavBar];
    [self.contentScrollView setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
}
- (IBAction)clickBtn3:(id)sender {
    currentPage=2;
    [self refreshNavBar];
    [self.contentScrollView setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
}
- (IBAction)clickBtn4:(id)sender {
    currentPage=3;
    [self refreshNavBar];
    [self.contentScrollView setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    currentPage = scrollView.contentOffset.x/SDScreenWidth;    
    UIViewController * vc = self.childViewControllers[currentPage];
    if(![vc isViewLoaded])
    {
        vc.view.frame=CGRectMake(self.contentScrollView.width*currentPage, 0, self.contentScrollView.width, self.contentScrollView.height);
        [self.contentScrollView addSubview:vc.view];
    }
    
    [self refreshNavBar];
}

-(void)refreshNavBar
{
    switch (currentPage) {
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
