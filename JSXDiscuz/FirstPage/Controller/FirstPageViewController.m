//
//  FirstPageViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "FirstPageViewController.h"
#import "WritingLogViewController.h"


#import "DiscuzMainTableViewCell.h"
#import "DiscuzMainTableViewCell2.h"
#import "WaveBannelBackGroundView.h"
#import "DiscuzBannelTableViewCell.h"
#import "MainCategoryTableViewCell.h"
#import "TableViewOfRefreshFooterView.h"
#import "TableViewOfRefreshFooterView2.h"
#import "FirstPageNavigationBarView.h"
#import "MainPublicTableViewCell.h"
#import "MainFunctionTableViewCell.h"
#import "MainQuickScanTableViewCell.h"
#import "MainThemeTableViewCell.h"
#import "MainPopularTableViewCell.h"
#import "MainThemeTableViewCell2.h"
#import "MainRankingTableViewCell.h"

@interface FirstPageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    WaveBannelBackGroundView * wavev;
    
    DiscuzBannelTableViewCell * bannelcell;
    
    FirstPageNavigationBarView * navbarView;
    
    BOOL hasNewData;
}

@property(nonatomic, strong) NSMutableArray *layoutData;

@property(nonatomic, strong) NSMutableArray *tableData;

@property(nonatomic, strong) NSArray *bannelImgsData;

@end

@implementation FirstPageViewController


#pragma mark -UITableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layoutData.count;
    return self.tableData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * cellName = self.layoutData[indexPath.row];
    if([cellName isEqualToString:@"bannel"])
    {
        bannelcell= [tableView dequeueReusableCellWithIdentifier:@"discuzBannelTableViewCell"];
        bannelcell.selectionStyle=UITableViewCellSelectionStyleNone;
        bannelcell.bannelImgs=self.bannelImgsData;
        [[bannelcell rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)]subscribeNext:^(id x) {
            NSIndexPath * indexPath = x[1];
            NSLog(@"item:%ld",indexPath.item);
            BaseWKViewController * basewkvc = [[BaseWKViewController alloc]init];
            basewkvc.url=@"http://www.baidu.com";
            [self.navigationController pushViewController:basewkvc animated:YES];
        }];
        return bannelcell;
        
    }else if([cellName isEqualToString:@"category"])
    {
        MainCategoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainCategoryTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if([cellName isEqualToString:@"public"])
    {
        MainPublicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainPublicTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if([cellName isEqualToString:@"function"])
    {
        MainFunctionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainFunctionTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [[cell rac_signalForSelector:@selector(clickView2)]subscribeNext:^(id x) {
           //写日志
            SDLog(@"写日志");
            WritingLogViewController * vc = [[WritingLogViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }else if([cellName isEqualToString:@"quickscan"])
    {
        MainQuickScanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainQuickScanTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if([cellName isEqualToString:@"theme"])
    {
        MainThemeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainThemeTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if([cellName isEqualToString:@"popular"])
    {
        MainPopularTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainPopularTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if([cellName isEqualToString:@"ranking"])
    {
        MainRankingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainRankingTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if([cellName isEqualToString:@"theme2"])
    {
        MainThemeTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"mainThemeTableViewCell2"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if([cellName isEqualToString:@"main"])
    {
        DiscuzMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"discuzMainTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.imgV3.hidden=NO;
        //cell.titleLab.text=self.tableData[indexPath.row];
        return cell;
    }
    
    
//    DiscuzMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"discuzMainTableViewCell"];
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.imgV3.hidden=YES;
//    cell.titleLab.text=self.tableData[indexPath.row];
//    return cell;
    
//    DiscuzMainTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"discuzMainTableViewCell2"];
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.contentLab.text=self.tableData[indexPath.row];
//    return cell;
    
    return nil;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView==self.maindiscuzTableview)
    {
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentYoffset = scrollView.contentOffset.y;
        CGFloat distance = scrollView.contentSize.height-height-contentYoffset;
        if (distance<=0) {
            [self getInitData];
        }
    }
}

-(void)setMainTableViewFooterView
{
    if(hasNewData)
    {
        TableViewOfRefreshFooterView * footer = [TableViewOfRefreshFooterView shareView];
        footer.frame=CGRectMake(0, 0, SDScreenWidth, 60);
        self.maindiscuzTableview.tableFooterView=footer;
    }else
    {
        TableViewOfRefreshFooterView2 * footer2 = [TableViewOfRefreshFooterView2 shareView];
        footer2.frame=CGRectMake(0, 0, SDScreenWidth, 60);
        self.maindiscuzTableview.tableFooterView=footer2;
    }
}


#pragma mark - 成员变量懒加载

-(NSMutableArray *)layoutData
{
    if(_layoutData==nil)
    {
        _layoutData=[NSMutableArray array];
        [_layoutData addObject:@"bannel"];
        [_layoutData addObject:@"category"];
        [_layoutData addObject:@"public"];
        [_layoutData addObject:@"function"];
        [_layoutData addObject:@"quickscan"];
        [_layoutData addObject:@"theme"];
        [_layoutData addObject:@"popular"];
        [_layoutData addObject:@"ranking"];
        [_layoutData addObject:@"theme2"];
        [_layoutData addObject:@"main"];
    }
    return _layoutData;
}

-(NSMutableArray*)tableData
{
    if(_tableData==nil)
    {
        _tableData=[NSMutableArray arrayWithArray:@[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3",@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"@"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"123456789012345678901234567890", @"1\n2\n3",@"1\n2\n3"]];
  
    }
    return _tableData;
}

-(NSArray *)bannelImgsData
{
    if(_bannelImgsData==nil)
    {
        _bannelImgsData=[NSArray arrayWithObjects:@"timg",@"timg1",@"timg2",@"timg3",nil];
    }
    return _bannelImgsData;
}

#pragma mark - VC生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(bannelcell)
    {
        [bannelcell adjustPosition];
    }
}

-(void)addSubViews
{
    self.maindiscuzTableview.delegate=self;
    self.maindiscuzTableview.dataSource=self;
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"DiscuzMainTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discuzMainTableViewCell"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"DiscuzMainTableViewCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discuzMainTableViewCell2"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"DiscuzBannelTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discuzBannelTableViewCell"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"MainCategoryTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainCategoryTableViewCell"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"MainPublicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainPublicTableViewCell"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"MainFunctionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainFunctionTableViewCell"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"MainQuickScanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainQuickScanTableViewCell"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"MainThemeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainThemeTableViewCell"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"MainPopularTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainPopularTableViewCell"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"MainThemeTableViewCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainThemeTableViewCell2"];
    [self.maindiscuzTableview registerNib:[UINib nibWithNibName:@"MainRankingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainRankingTableViewCell"];
    
    
    self.maindiscuzTableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.maindiscuzTableview.estimatedRowHeight = 200;
    self.maindiscuzTableview.rowHeight = UITableViewAutomaticDimension;
    self.maindiscuzTableview.contentInset=UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.bounds.size.height, 0);
    
    [self.maindiscuzTableview addPullToRefreshWithActionHandler:^{
        [self.maindiscuzTableview.pullToRefreshView stopAnimating];
    }];
    
    navbarView=[FirstPageNavigationBarView shareView];
    navbarView.frame=CGRectMake(0, 0, SDScreenWidth, self.navigationController.navigationBar.bounds.size.height+StatusBarHeight);
    [self.view addSubview:navbarView];
    
    @weakify(self);
    [RACObserve(self.maindiscuzTableview,contentOffset)subscribeNext:^(id x) {
        @strongify(self);
        CGPoint cp =[x CGPointValue];
        navbarView.frame=CGRectMake(0, 0, SDScreenWidth, self.navigationController.navigationBar.bounds.size.height+StatusBarHeight);
        CGFloat navbarheight = self.navigationController.navigationBar.bounds.size.height+StatusBarHeight;
        if(cp.y/navbarheight>=1)
        {
            navbarView.bgview.backgroundColor=ThemeColor;
        }else
        {
            double radio=0.0;
            if(cp.y>=0)
            {
                radio=cp.y/navbarheight;
            }
            navbarView.bgview.backgroundColor=[ThemeColor colorWithAlphaComponent:radio];
        }
    }];
    
    //全局配置信息
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.maindiscuzTableview;
    
}

-(void)getInitData
{
    int random =100+(arc4random()%101);
    if(random<150)
    {
        hasNewData=YES;
    }else
    {
        hasNewData=NO;
    }
    [self.maindiscuzTableview reloadData];
    [self setMainTableViewFooterView];
}

-(void)nonetstatusGetData
{
    [super nonetstatusGetData];
}


@end
