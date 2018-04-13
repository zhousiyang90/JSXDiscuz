//
//  CommunityDetailViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/11.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityDetailViewController.h"
#import "CommunityDetailViewController_dynamic.h"

@interface CommunityDetailViewController ()<UIScrollViewDelegate>
{
    NSInteger currentPage;
    
    UIView * lineView;
}
@property(nonatomic,strong) NSMutableArray * indexArr;

@end

@implementation CommunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"社区名称";
    self.topicImgV.layer.cornerRadius=5;
    self.topicImgV.layer.masksToBounds=YES;
    self.collectBtn.layer.cornerRadius=5;
    self.collectBtn.layer.borderWidth=1;
    self.collectBtn.layer.borderColor=SDColor(200,200,200).CGColor;
    self.indexscrollview.contentSize=CGSizeMake(self.indexArr.count*60, 40);
    self.scrollview.delegate=self;
    self.scrollview.pagingEnabled=YES;
    self.scrollview.contentSize=CGSizeMake(SDScreenWidth*self.indexArr.count,self.scrollview.height);
    
    for (int i=0; i<self.indexArr.count; i++) {
        NSString * indexName = self.indexArr[i];
        UIButton * indexBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        indexBtn.backgroundColor=[UIColor whiteColor];
        indexBtn.titleLabel.font=SDFontOf14;
        indexBtn.tag=i+100;
        indexBtn.frame=CGRectMake(10+60*i, 0, 40, 39);
        [indexBtn addTarget:self action:@selector(clickIndexBtn:) forControlEvents:UIControlEventTouchUpInside];
        [indexBtn setTitle:indexName forState:UIControlStateNormal];
        [indexBtn setTitle:indexName forState:UIControlStateSelected];
        [indexBtn setTitleColor:TextColor forState:UIControlStateNormal];
        [indexBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
        [self.indexscrollview addSubview:indexBtn];
        CommunityDetailViewController_dynamic * modevc =[[CommunityDetailViewController_dynamic alloc]init];
        [self addChildViewController:modevc];
        
        if(i==0)
        {
            //默认选中第一个标签页
            currentPage=0;
            lineView = [[UIView alloc]initWithFrame:CGRectMake(10+60*currentPage, 39, 40, 1)];
            lineView.backgroundColor=SDColor(46, 196, 252);
            [self.indexscrollview addSubview:lineView];
            modevc.view.frame=CGRectMake(0, 0, self.scrollview.width, self.scrollview.height);
            [self.scrollview addSubview:modevc.view];
            self.scrollview.contentOffset=CGPointMake(0, 0);
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
    lineView.x=10+60*currentPage;
    //调整indexScrollview范围
    int hangNum=SDScreenWidth/60;
    if(currentPage>hangNum)
    {
        [self.indexscrollview setContentOffset:CGPointMake((currentPage-hangNum)*60, 0) animated:YES];
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
        _indexArr=[NSMutableArray arrayWithObjects:@"最新",@"最热",@"推荐",@"给力",@"哈哈",@"呵呵",@"嘿嘿",@"呲呲",@"科科",nil];
    }
    return _indexArr;
}

@end
