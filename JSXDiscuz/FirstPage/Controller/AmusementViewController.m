//
//  AmusementViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "AmusementViewController.h"
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
#import "MainQuickScanTableViewCell.h"
#import "AmusementTableViewCell.h"
#import "TableViewTitleCellView.h"

@interface AmusementViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    WaveBannelBackGroundView * wavev;
    
    DiscuzBannelTableViewCell * bannelcell;
    
    BOOL hasNewData;
}
@property(nonatomic, strong) NSMutableArray *layoutData;

@property(nonatomic, strong) NSArray *bannelImgsData;
@end

@implementation AmusementViewController

#pragma mark -UITableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layoutData.count;
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
            
        }];
        return bannelcell;
        
    }else if([cellName isEqualToString:@"title"])
    {
        TableViewTitleCellView * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewTitleCellView"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.titleLab.text=@"影视资讯";
        return cell;
        
    }else if([cellName isEqualToString:@"amuse"])
    {
        AmusementTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"amusementTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.block = ^{
            //主题详情
            TopicDetailViewController * vc=[[TopicDetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
        
    }else if([cellName isEqualToString:@"quickscan"])
    {
        MainQuickScanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mainQuickScanTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.block = ^(int x, NSIndexPath *indexPath) {
            //快速浏览
            if(x==0)
            {
                //点击用户头像
                OtherCenterViewController *vc=[[OtherCenterViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else
            {
                //点击collectionCell
            }
        };
        return cell;
    }else if([cellName isEqualToString:@"main"])
    {
        DiscuzMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"discuzMainTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.imgV3.hidden=NO;
        cell.block = ^{
            //主题详情
            TopicDetailViewController * vc=[[TopicDetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.titleLab.text=@"大萨达撒多所大";
        return cell;
    }else if([cellName isEqualToString:@"main2"])
    {
        DiscuzMainTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"discuzMainTableViewCell2"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.block = ^{
            //主题详情
            TopicDetailViewController * vc=[[TopicDetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.titleLab.text=@"大叔大婶多";
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView==self.tableview)
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
        self.tableview.tableFooterView=footer;
    }else
    {
        TableViewOfRefreshFooterView2 * footer2 = [TableViewOfRefreshFooterView2 shareView];
        footer2.frame=CGRectMake(0, 0, SDScreenWidth, 60);
        self.tableview.tableFooterView=footer2;
    }
}


#pragma mark - 成员变量懒加载

-(NSMutableArray *)layoutData
{
    if(_layoutData==nil)
    {
        _layoutData=[NSMutableArray array];
        [_layoutData addObject:@"bannel"];
        [_layoutData addObject:@"title"];
        [_layoutData addObject:@"amuse"];
        [_layoutData addObject:@"amuse"];
        [_layoutData addObject:@"amuse"];
        [_layoutData addObject:@"quickscan"];
        [_layoutData addObject:@"main"];
        [_layoutData addObject:@"main2"];
        [_layoutData addObject:@"main"];
        [_layoutData addObject:@"main2"];
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

#pragma mark - VC生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

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
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self.tableview registerNib:[UINib nibWithNibName:@"DiscuzMainTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discuzMainTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"DiscuzMainTableViewCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discuzMainTableViewCell2"];
    [self.tableview registerNib:[UINib nibWithNibName:@"DiscuzBannelTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discuzBannelTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"TableViewTitleCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tableViewTitleCellView"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MainQuickScanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainQuickScanTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"AmusementTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"amusementTableViewCell"];
    
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight = 200;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableview addPullToRefreshWithActionHandler:^{
        [self.tableview.pullToRefreshView stopAnimating];
    }];
    
    //全局配置信息
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.tableview;
    
}

-(void)getInitData
{
    hasNewData=NO;
    [self.tableview reloadData];
    [self setMainTableViewFooterView];
}

-(void)nonetstatusGetData
{
    [super nonetstatusGetData];
}


@end
