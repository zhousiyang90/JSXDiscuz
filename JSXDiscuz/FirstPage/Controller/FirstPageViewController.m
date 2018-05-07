//
//  FirstPageViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "FirstPageViewController.h"
#import "WritingLogViewController.h"
#import "NearByPersonViewController.h"
#import "NearByThingViewController.h"
#import "FindFriendsViewController.h"
#import "TopicDetailViewController.h"
#import "OtherCenterViewController.h"
#import "CommunityDetailViewController.h"
#import "VideoLogViewController.h"
#import "HeadLineNewsViewController.h"

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

@property(nonatomic, strong) PostBaseData *quickScanData;
@property(nonatomic, strong) PostBaseData *popularData;
@property(nonatomic, strong) PostBaseData *rankingData;
@property(nonatomic, strong) GroupMainData *groupData;
@property(nonatomic, strong) GroupMainData *themeData;

@property(nonatomic, assign) int currentPage;
@property(nonatomic, strong) PostBaseData *currentMainData;
@property(nonatomic, strong) NSMutableArray *mainDataList;

@property(nonatomic, strong) NSArray *bannelImgsData;

@end

@implementation FirstPageViewController


#pragma mark -UITableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layoutData.count+self.mainDataList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellName;
    if(indexPath.row<self.layoutData.count)
    {
        cellName = self.layoutData[indexPath.row];
    }
    if([cellName isEqualToString:@"bannel"])
    {
        bannelcell= [tableView dequeueReusableCellWithIdentifier:@"discuzBannelTableViewCell"];
        bannelcell.selectionStyle=UITableViewCellSelectionStyleNone;
        bannelcell.bannelImgs=self.bannelImgsData;
        [[bannelcell rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)]subscribeNext:^(id x) {
            HeadLineNewsViewController * vc=[[HeadLineNewsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
//            NSIndexPath * indexPath = x[1];
//            NSLog(@"item:%ld",indexPath.item);
//            BaseWKViewController * basewkvc = [[BaseWKViewController alloc]init];
//            basewkvc.url=@"http://www.baidu.com";
//            [self.navigationController pushViewController:basewkvc animated:YES];
        }];
        return bannelcell;
        
    }else if([cellName isEqualToString:@"category"])
    {
        MainCategoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainCategoryTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.block = ^(int type) {
            if(type==0)
            {
                //兴趣小组
                [self.tabBarController setSelectedIndex:2];
            }else if(type==1)
            {
                //广场
                [self.tabBarController setSelectedIndex:1];
            }else if(type==2)
            {
                //发布
                WritingLogViewController * vc = [[WritingLogViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
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
        
        cell.block = ^(int type) {
            if(type==0)
            {
                //找朋友
                FindFriendsViewController * vc = [[FindFriendsViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else if(type==1)
            {
                //写日志
                WritingLogViewController * vc = [[WritingLogViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else if(type==2)
            {
                //附近的人
                [[JSXLocalTool shareLocationTool]getLocationOnce:^(CLLocation *loc) {
                    SDLog(@"loc:(%f-%f)",loc.coordinate.latitude,loc.coordinate.longitude);
                }];
                NearByPersonViewController * vc=[[NearByPersonViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else if(type==3)
            {
                //附近的事
                NearByThingViewController * vc=[[NearByThingViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        return cell;
    }else if([cellName isEqualToString:@"quickscan"])
    {
        MainQuickScanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainQuickScanTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.baseData=self.quickScanData;
        cell.block = ^(int x, NSIndexPath *indexPath) {
            //快速浏览
            if(x==0)
            {
                //点击用户头像
                PostBaseData_summary * cellData = self.quickScanData.list[indexPath.row];
                [self pushToOtherPersonalCenter:cellData.uid];
            }else
            {
                //点击帖子详情
                PostBaseData_summary * data=self.quickScanData.list[indexPath.row];
                [self pushToPostsDetail:data.tid andFid:data.fid];
            }
        };
        return cell;
    }else if([cellName isEqualToString:@"theme"])
    {
        MainThemeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainThemeTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.baseData=self.groupData;
        cell.block = ^(NSIndexPath * indexPath) {
            GroupMainData_summary * cellData=self.groupData.catlist[indexPath.row];
            //小组详情
            [self pushToGroupDetail:cellData.fid];
        };
        return cell;
    }else if([cellName isEqualToString:@"popular"])
    {
        MainPopularTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainPopularTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.baseData=self.popularData;
        cell.block = ^() {
            //点击用户头像
            PostBaseData_summary * cellData = self.popularData.list[0];
            [self pushToOtherPersonalCenter:cellData.uid];
        };
        return cell;
    }else if([cellName isEqualToString:@"ranking"])
    {
        MainRankingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainRankingTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.baseData=self.rankingData;
        //社区详情
        cell.clickblock = ^(int index) {
            if(index==0&&self.rankingData.list.count>0)
            {
                PostBaseData_summary *data=self.rankingData.list[index];
                [self pushToCommunityDetail:data.fid];
            }else if(index==1&&self.rankingData.list.count>1)
            {
                PostBaseData_summary *data=self.rankingData.list[index];
                [self pushToCommunityDetail:data.fid];
            }else if(index==2&&self.rankingData.list.count>2)
            {
                PostBaseData_summary *data=self.rankingData.list[index];
                [self pushToCommunityDetail:data.fid];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"主题数据为空"];
            }
        };
        
        //点击帖子详情
        cell.block = ^(int type) {
            if(type==0&&self.rankingData.list.count>0)
            {
                PostBaseData_summary *cellData=self.rankingData.list[type];
                [self pushToPostsDetail:cellData.tid andFid:cellData.fid];
            }else if(type==1&&self.rankingData.list.count>1)
            {
                PostBaseData_summary *cellData=self.rankingData.list[type];
                [self pushToPostsDetail:cellData.tid andFid:cellData.fid];
            }else if(type==2&&self.rankingData.list.count>2)
            {
                PostBaseData_summary *cellData=self.rankingData.list[type];
                [self pushToPostsDetail:cellData.tid andFid:cellData.fid];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"帖子数据为空"];
            }
        };
        return cell;
    }else if([cellName isEqualToString:@"theme2"])
    {
        MainThemeTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"mainThemeTableViewCell2"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.baseData=self.themeData;
        cell.block = ^(NSIndexPath * indexPath) {
            GroupMainData_summary * cellData=self.themeData.catlist[indexPath.row];
            //社区详情
            [self pushToCommunityDetail:cellData.fid];
        };
        return cell;
    }else
    {
        PostBaseData_summary * celldata=self.mainDataList[indexPath.row-self.layoutData.count];
        if(celldata.pics.count>1)
        {
            DiscuzMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"discuzMainTableViewCell"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.baseData=celldata;
            cell.block = ^{
                //社区详情
                [self pushToCommunityDetail:celldata.fid];
            };
            return cell;
        }else
        {
            DiscuzMainTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"discuzMainTableViewCell2"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.baseData=celldata;
            cell.block = ^{
                //社区详情
                [self pushToCommunityDetail:celldata.fid];
            };
            return cell;
        }
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row<self.layoutData.count)
    {
        NSString * cellName = self.layoutData[indexPath.row];
        if([cellName isEqualToString:@"popular"])
        {
            //点击帖子详情
            if(self.popularData.list>0)
            {
                PostBaseData_summary * data=self.popularData.list[0];
                [self pushToPostsDetail:data.tid andFid:data.fid];
            }
        }
    }else
    {
        //点击帖子详情
        PostBaseData_summary * celldata=self.mainDataList[indexPath.row-self.layoutData.count];
        [self pushToPostsDetail:celldata.tid andFid:celldata.fid];
    }
    
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView==self.maindiscuzTableview)
    {
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentYoffset = scrollView.contentOffset.y;
        CGFloat distance = scrollView.contentSize.height-height-contentYoffset;
        if (distance<=0&&hasNewData) {
            self.currentPage++;
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
    }
    return _layoutData;
}


-(NSArray *)bannelImgsData
{
    if(_bannelImgsData==nil)
    {
        _bannelImgsData=[NSArray arrayWithObjects:@"timg",@"timg1",@"timg2",@"timg3",nil];
    }
    return _bannelImgsData;
}

-(NSMutableArray *)mainDataList
{
    if(_mainDataList==nil)
    {
        _mainDataList=[NSMutableArray array];
    }
    return _mainDataList;
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
        [self getInitData];
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
    self.currentPage=1;
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.maindiscuzTableview;
    
}

-(void)getInitData
{
    if(self.currentPage==1)
    {
        [self getGroupModeData];
        [self getCommunityModeData];
        [self getQuickScanModeData];
        [self getPopularModeData];
        [self getRankingModeData];
        [self getMainModeData];
    }else
    {
        [self getMainModeData];
    }
    
}

-(void)nonetstatusGetData
{
    [self getInitData];
}

#pragma mark - 网络访问

-(void)getGroupModeData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"gcid="]=@"3";
    params[@"ac"]=@"group";
    [JSXHttpTool Post:Interface_FirstPageGroupMode params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        if([returnCode intValue]==0)
        {
             self.groupData=[GroupMainData mj_objectWithKeyValues:json];
            [self.maindiscuzTableview reloadData];
        }
    } failure:^(NSError *error) {
    }];
}

-(void)getCommunityModeData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"fcid="]=@"1";
    params[@"ac"]=@"forum";
    [JSXHttpTool Post:Interface_FirstPageCommunityMode params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        if([returnCode intValue]==0)
        {
            self.themeData=[GroupMainData mj_objectWithKeyValues:json];
            [self.maindiscuzTableview reloadData];
        }
    } failure:^(NSError *error) {
    }];
}

-(void)getQuickScanModeData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"mod"]=@"index_forumlist";
    params[@"fcid"]=@"1";
    params[@"page"]=@"1";
    params[@"mould"]=@"2";
    [JSXHttpTool Post:Interface_FirstPagePostsMode params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        if([returnCode intValue]==0)
        {
            self.quickScanData=[PostBaseData mj_objectWithKeyValues:json];
            [self.maindiscuzTableview reloadData];
        }

    } failure:^(NSError *error) {
    }];
}

-(void)getPopularModeData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"mod"]=@"index_forumlist";
    params[@"fcid"]=@"1";
    params[@"page"]=@"1";
    params[@"mould"]=@"3";
    [JSXHttpTool Post:Interface_FirstPagePostsMode params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        if([returnCode intValue]==0)
        {
            self.popularData=[PostBaseData mj_objectWithKeyValues:json];
            [self.maindiscuzTableview reloadData];
        }
        
    } failure:^(NSError *error) {
    }];
}

-(void)getRankingModeData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"mod"]=@"index_forumlist";
    params[@"fcid"]=@"1";
    params[@"page"]=@"1";
    params[@"mould"]=@"4";
    [JSXHttpTool Post:Interface_FirstPagePostsMode params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        if([returnCode intValue]==0)
        {
            self.rankingData=[PostBaseData mj_objectWithKeyValues:json];
            [self.maindiscuzTableview reloadData];
        }
        
    } failure:^(NSError *error) {
    }];
}

-(void)getMainModeData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"mod"]=@"index_forumlist";
    params[@"fcid"]=@"1";
    params[@"page"]=@(self.currentPage);
    params[@"mould"]=@"";
    [JSXHttpTool Post:Interface_FirstPagePostsMode params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        if([returnCode intValue]==0)
        {
            if(self.currentPage==1)
            {
                if(self.mainDataList.count>0)
                {
                    [self.mainDataList removeAllObjects];
                }
                self.currentMainData=[PostBaseData mj_objectWithKeyValues:json];
                if(self.currentMainData.list.count==0)
                {
                    hasNewData=NO;
                    [self setMainTableViewFooterView];
                }else
                {
                    hasNewData=YES;
                    [self setMainTableViewFooterView];
                }
                self.mainDataList=self.currentMainData.list;
                [self.maindiscuzTableview reloadData];
            }else
            {
                self.currentMainData=[PostBaseData mj_objectWithKeyValues:json];
                if(self.currentMainData.list.count==0)
                {
                    hasNewData=NO;
                    [self setMainTableViewFooterView];
                }else
                {
                    hasNewData=YES;
                    [self setMainTableViewFooterView];
                }
                [self.mainDataList addObjectsFromArray:self.currentMainData.list];
                [self.maindiscuzTableview reloadData];
            }
        }else
        {
            if(self.currentPage>1)
            {
                self.currentPage--;
            }
        }
    } failure:^(NSError *error) {
        if(self.currentPage>1)
        {
            self.currentPage--;
        }
    }];
}

@end
