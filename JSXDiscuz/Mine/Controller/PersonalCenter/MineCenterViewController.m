//
//  MineCenterViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterViewController.h"
#import "MineCenterViewController_circle.h"
#import "MineCenterViewController_focus.h"
#import "MineCenterViewController_mine.h"
#import "MineCenterViewController_info.h"
#import "WaveBannelBackGroundView.h"

@interface MineCenterViewController ()<UIScrollViewDelegate>
{
    NSInteger currentPage;
    
    WaveBannelBackGroundView * wavev1;
    WaveBannelBackGroundView * wavev2;
    UIView * lineView;
    UIButton * settingBtn;
    UIImageView * headImageView;
}

@end

@implementation MineCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"个人空间";
    
    wavev1=[[WaveBannelBackGroundView alloc]init];
    wavev1.frame=CGRectMake(0, 0, SDScreenWidth, self.waveView.bounds.size.height);
    wavev1.backgroundColor=[UIColor clearColor];
    wavev1.speed=0.2;
    [self.waveView addSubview:wavev1];
    [wavev1 startwave];
    
    wavev2=[[WaveBannelBackGroundView alloc]init];
    wavev2.frame=CGRectMake(0, 0, SDScreenWidth, self.waveView.bounds.size.height);
    wavev2.backgroundColor=[UIColor clearColor];
    wavev2.translateValue=SDScreenWidth/8;
    wavev2.waveAlpha=0.5;
    wavev2.speed=0.2;
    [self.waveView addSubview:wavev2];
    [wavev2 startwave];
    
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 140, 60, 60)];
    headImageView.layer.cornerRadius=30;
    headImageView.layer.borderWidth=1;
    headImageView.layer.masksToBounds=YES;
    headImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[UserDataTools getUserInfo].avatar] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Head]];
    [self.bgView addSubview:headImageView];
    
    settingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame=CGRectMake(SDScreenWidth-80, 200, 60, 25);
    settingBtn.backgroundColor=BGThemeColor;
    settingBtn.layer.borderWidth=1;
    settingBtn.layer.cornerRadius=5;
    settingBtn.layer.borderColor=SDColor(200, 200, 200).CGColor;
    [settingBtn setTitleColor:SDColor(93, 93, 93) forState:UIControlStateNormal];
    settingBtn.titleLabel.font=SDFontOf13;
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [[settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
    }];
    [self.bgView addSubview:settingBtn];
    
    self.statusLab.layer.cornerRadius=5;
    self.statusLab.layer.borderWidth=1;
    self.statusLab.layer.borderColor=ThemeColor.CGColor;
    
    MineCenterViewController_circle * modevc =[[MineCenterViewController_circle alloc]init];
    [self addChildViewController:modevc];
    
    MineCenterViewController_focus * newvc =[[MineCenterViewController_focus alloc]init];
    [self addChildViewController:newvc];
    
    MineCenterViewController_mine * recvc =[[MineCenterViewController_mine alloc]init];
    [self addChildViewController:recvc];
    
    MineCenterViewController_info * albumvc =[[MineCenterViewController_info alloc]init];
    [self addChildViewController:albumvc];
    
    self.scrollview.delegate=self;
    self.scrollview.pagingEnabled=YES;
    self.scrollview.contentSize=CGSizeMake(SDScreenWidth*4,self.scrollview.height);
    
    //默认选中第一个标签页
    lineView = [[UIView alloc]initWithFrame:CGRectMake(SDScreenWidth/8-30, 39, 60, 1)];
    lineView.backgroundColor=SDColor(46, 196, 252);
    [self.navBarView addSubview:lineView];
    
    currentPage=0;
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
            self.navBtn1.selected=YES;
            self.navBtn2.selected=NO;
            self.navBtn3.selected=NO;
            self.navBtn4.selected=NO;
            lineView.x=SDScreenWidth/8-30;
            break;
        case 1:
            self.navBtn1.selected=NO;
            self.navBtn2.selected=YES;
            self.navBtn3.selected=NO;
            self.navBtn4.selected=NO;
            lineView.x=SDScreenWidth/8*3-30;
            break;
        case 2:
            self.navBtn1.selected=NO;
            self.navBtn2.selected=NO;
            self.navBtn3.selected=YES;
            self.navBtn4.selected=NO;
            lineView.x=SDScreenWidth/8*5-30;
            break;
        case 3:
            self.navBtn1.selected=NO;
            self.navBtn2.selected=NO;
            self.navBtn3.selected=NO;
            self.navBtn4.selected=YES;
            lineView.x=SDScreenWidth/8*7-30;
            break;
            
        default:
            break;
    }
}

- (IBAction)clickNavBtn1:(id)sender {
    currentPage=0;
    [self refreshNavBar];
    [self.scrollview setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
}
- (IBAction)clickNavBtn2:(id)sender {
    currentPage=1;
    [self refreshNavBar];
    [self.scrollview setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
}
- (IBAction)clickNavBtn3:(id)sender {
    currentPage=2;
    [self refreshNavBar];
    [self.scrollview setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
}
- (IBAction)clickNavBtn4:(id)sender {
    currentPage=3;
    [self refreshNavBar];
    [self.scrollview setContentOffset:CGPointMake(SDScreenWidth*currentPage, 0) animated:YES];
}


@end
