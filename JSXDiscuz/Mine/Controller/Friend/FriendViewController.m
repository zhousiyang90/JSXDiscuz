//
//  FriendViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/5/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "FriendViewController.h"

@interface FriendViewController ()<UIScrollViewDelegate>
{
    NSInteger currentPage;
    
    UIView * lineView;
}
@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"联系人";
    
    FriendViewController_friend * modevc =[[FriendViewController_friend alloc]init];
    [self addChildViewController:modevc];
    
    FriendViewController_focus * newvc =[[FriendViewController_focus alloc]init];
    [self addChildViewController:newvc];
    
    self.contentScrollView.delegate=self;
    self.contentScrollView.pagingEnabled=YES;
    self.contentScrollView.contentSize=CGSizeMake(SDScreenWidth*2,self.contentScrollView.height-self.tabBarController.tabBar.height);
    
    //默认选中第一个标签页
    lineView = [[UIView alloc]initWithFrame:CGRectMake(SDScreenWidth/4-30, 39, 60, 1)];
    lineView.backgroundColor=SDColor(46, 196, 252);
    [self.barView addSubview:lineView];
    
    currentPage=0;
    modevc.view.frame=CGRectMake(0, 0, self.contentScrollView.width, self.contentScrollView.height);
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
            lineView.x=SDScreenWidth/4-30;
            break;
        case 1:
            self.btn1.selected=NO;
            self.btn2.selected=YES;
            lineView.x=SDScreenWidth/4*3-30;
            break;
        default:
            break;
    }
}

@end
