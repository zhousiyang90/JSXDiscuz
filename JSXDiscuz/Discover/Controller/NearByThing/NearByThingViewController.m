//
//  NearByThingViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "NearByThingViewController.h"
#import "NearByThingTableViewCell.h"

@interface NearByThingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL hasNewData;
}
@property(nonatomic,strong) NSMutableArray * testList;

@end

@implementation NearByThingViewController

#pragma mark - UITableViewDelegate

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"nearByThingTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configCell:cell andIndexPath:indexPath];
    }];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByThingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nearByThingTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [self configCell:cell andIndexPath:indexPath];
    return cell;
}


-(void)configCell:(NearByThingTableViewCell*)cell andIndexPath:(NSIndexPath*)indexpath
{
    cell.data=self.testList[indexpath.row];
    [cell.collectionView reloadData];
}


#pragma mark - LazyLoad

-(NSMutableArray *)testList
{
    if(_testList==nil)
    {
        _testList=[NSMutableArray array];
        CommunityNewestData * data = [[CommunityNewestData alloc]init];
        data.title=@"sad撒大所大所大所大所大所大所大所多撒大所多sad撒大所大所大所大所大所大所大所多撒大所多sad撒大所大所大所大所大所大所大所多s大所多s大所多s大所多s大所多s大所多s大所多撒大所多";
        data.imgCount=5;
        [_testList addObject:data];
        
        CommunityNewestData * data2 = [[CommunityNewestData alloc]init];
        data2.title=@"s大所多";
        data2.imgCount=9;
        [_testList addObject:data2];
        
        CommunityNewestData * data3 = [[CommunityNewestData alloc]init];
        data3.title=@"s大所多s大所多ss大所多大所s大所多多";
        data3.imgCount=0;
        [_testList addObject:data3];
        
        CommunityNewestData * data4 = [[CommunityNewestData alloc]init];
        data4.title=@"ss大所多s大所多s大所多大所多";
        data4.imgCount=2;
        [_testList addObject:data4];
    }
    return _testList;
}


#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"NearByThingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nearByThingTableViewCell"];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight=250;
    self.tableview.rowHeight=UITableViewAutomaticDimension;
    
    [self.tableview addPullToRefreshWithActionHandler:^{
        [self.tableview.pullToRefreshView stopAnimating];
    }];
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.tableview;
}

-(void)setNavigationBar
{
    self.title=@"附近的事";
}

-(void)getInitData
{
    hasNewData=NO;
    [self.tableview reloadData];
    [self setMainTableViewFooterView];
}

-(void)nonetstatusGetData
{
    
}


@end
