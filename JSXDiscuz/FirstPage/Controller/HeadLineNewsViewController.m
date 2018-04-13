//
//  HeadLineNewsViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "HeadLineNewsViewController.h"
#import "VideoLogViewController.h"
#import "SeedingViewController.h"
#import "AmusementViewController.h"
#import "LocalNewsViewController.h"

#define indexEveWidth 80

@interface HeadLineNewsViewController ()<UIScrollViewDelegate>
{
    NSInteger currentPage;
    
    UIView * lineView;
}
@property(nonatomic,strong) NSMutableArray * indexArr;

@end

@implementation HeadLineNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"头条资讯";
    self.indexscrollview.contentSize=CGSizeMake(self.indexArr.count*indexEveWidth, 40);
    self.scrollview.delegate=self;
    self.scrollview.pagingEnabled=YES;
    self.scrollview.contentSize=CGSizeMake(SDScreenWidth*self.indexArr.count,self.scrollview.height);
    
    for (int i=0; i<self.indexArr.count; i++) {
        NSString * indexName = self.indexArr[i];
        UIButton * indexBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        indexBtn.backgroundColor=[UIColor whiteColor];
        indexBtn.titleLabel.font=SDFontOf14;
        indexBtn.tag=i+100;
        indexBtn.frame=CGRectMake(10+indexEveWidth*i, 0, indexEveWidth-20, 39);
        [indexBtn addTarget:self action:@selector(clickIndexBtn:) forControlEvents:UIControlEventTouchUpInside];
        [indexBtn setTitle:indexName forState:UIControlStateNormal];
        [indexBtn setTitle:indexName forState:UIControlStateSelected];
        [indexBtn setTitleColor:TextColor forState:UIControlStateNormal];
        [indexBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
        [self.indexscrollview addSubview:indexBtn];
        
        if([indexName isEqualToString:@"综合视频"])
        {
            VideoLogViewController * modevc =[[VideoLogViewController alloc]init];
            [self addChildViewController:modevc];
            //默认选中第一个标签页
            currentPage=0;
            lineView = [[UIView alloc]initWithFrame:CGRectMake(10+indexEveWidth*currentPage, 39, indexEveWidth-20, 1)];
            lineView.backgroundColor=SDColor(46, 196, 252);
            [self.indexscrollview addSubview:lineView];
            modevc.view.frame=CGRectMake(0, 0, self.scrollview.width, self.scrollview.height);
            [self.scrollview addSubview:modevc.view];
            self.scrollview.contentOffset=CGPointMake(0, 0);
        }else if([indexName isEqualToString:@"本地要闻"])
        {
            LocalNewsViewController * modevc =[[LocalNewsViewController alloc]init];
            [self addChildViewController:modevc];
        }else if([indexName isEqualToString:@"娱乐星闻"])
        {
            AmusementViewController * modevc =[[AmusementViewController alloc]init];
            [self addChildViewController:modevc];
        }else if([indexName isEqualToString:@"种草社区"])
        {
            SeedingViewController * modevc =[[SeedingViewController alloc]init];
            [self addChildViewController:modevc];
        }

    }
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


-(void)clickIndexBtn:(UIButton*)button
{
    currentPage=button.tag-100;
    [self refreshNavBar];
    [self.scrollview setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
}

-(void)refreshNavBar
{
    for (int i=0; i<self.indexscrollview.subviews.count; i++) {
        UIView * subview = self.indexscrollview.subviews[i];
        if(subview.class==UIButton.class)
        {
            UIButton *btn=(UIButton*)subview;
            if(currentPage==btn.tag-100)
            {
                btn.selected=YES;
            }else
            {
                btn.selected=NO;
            }
        }
        
    }
    lineView.x=10+indexEveWidth*currentPage;
    //调整indexScrollview范围
    int hangNum=SDScreenWidth/indexEveWidth;
    if(currentPage>hangNum)
    {
        [self.indexscrollview setContentOffset:CGPointMake((currentPage-hangNum)*indexEveWidth, 0) animated:YES];
    }else
    {
        [self.indexscrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}


#pragma mark - LazyLoad

-(NSMutableArray *)indexArr
{
    if(_indexArr==nil)
    {
        _indexArr=[NSMutableArray arrayWithObjects:@"综合视频",@"本地要闻",@"娱乐星闻",@"种草社区",nil];
    }
    return _indexArr;
}

@end
