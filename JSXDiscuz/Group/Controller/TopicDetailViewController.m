//
//  TopicDetailViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "TopicDetailViewController_newset.h"
#import "TopicDetailViewController_hotest.h"

@interface TopicDetailViewController ()<UIScrollViewDelegate>
{
    NSInteger currentPage;
    
    UIView * lineView;
}

@end

@implementation TopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"小组名称";
    self.topicImgV.layer.cornerRadius=5;
    self.topicImgV.layer.masksToBounds=YES;
    self.joinBtn.layer.cornerRadius=5;
    self.joinBtn.layer.borderWidth=1;
    self.joinBtn.layer.borderColor=SDColor(200,200,200).CGColor;
    
    TopicDetailViewController_newset * modevc =[[TopicDetailViewController_newset alloc]init];
    [self addChildViewController:modevc];
    
    TopicDetailViewController_hotest * newvc =[[TopicDetailViewController_hotest alloc]init];
    [self addChildViewController:newvc];
    
    self.scrollview.delegate=self;
    self.scrollview.pagingEnabled=YES;
    self.scrollview.contentSize=CGSizeMake(SDScreenWidth*2,self.scrollview.height);
    
    [[self.newestBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        currentPage=0;
        [self refreshNavBar];
        [self.scrollview setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
    }];
    
    [[self.hotestBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        currentPage=1;
        [self refreshNavBar];
        [self.scrollview setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
    }];
    
    //默认选中第一个标签页
    currentPage=0;
    lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 139, 40, 1)];
    lineView.backgroundColor=SDColor(46, 196, 252);
    [self.bgview addSubview:lineView];
    
    modevc.view.frame=CGRectMake(0, 0, self.scrollview.width, self.scrollview.height);
    [self.scrollview addSubview:modevc.view];
    self.scrollview.contentOffset=CGPointMake(0, 0);
    
    [self refreshNavBar];
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
        vc.view.frame=CGRectMake(self.scrollview.width*currentPage, 0, self.scrollview.width, self.scrollview.height);
        [self.scrollview addSubview:vc.view];
    }
    
    [self refreshNavBar];
}

-(void)refreshNavBar
{
    switch (currentPage) {
        case 0:
            self.newestBtn.selected=YES;
            self.hotestBtn.selected=NO;
            lineView.x=10;
            break;
        case 1:
            self.newestBtn.selected=NO;
            self.hotestBtn.selected=YES;
            lineView.x=60;
            break;
        default:
            break;
    }
}


@end
