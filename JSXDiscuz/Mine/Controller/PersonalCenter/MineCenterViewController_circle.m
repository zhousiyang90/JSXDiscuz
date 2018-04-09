//
//  MineCenterViewController_circle.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterViewController_circle.h"
#import "CommunityTableViewCell_Newest.h"
#import "CommunityNewestData.h"

@interface MineCenterViewController_circle ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL hasNewData;
}
@property(nonatomic,strong) NSMutableArray * testList;

@end

@implementation MineCenterViewController_circle

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
    CGFloat autoHeight = [tableView fd_heightForCellWithIdentifier:@"communityTableViewCell_Newest" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configCell:cell andIndexPath:indexPath];
    }];

    return autoHeight;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityTableViewCell_Newest * cell = [tableView dequeueReusableCellWithIdentifier:@"communityTableViewCell_Newest"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [self configCell:cell andIndexPath:indexPath];
    return cell;
}


-(void)configCell:(CommunityTableViewCell_Newest*)cell andIndexPath:(NSIndexPath*)indexpath
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
    [self.tableview registerNib:[UINib nibWithNibName:@"CommunityTableViewCell_Newest" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"communityTableViewCell_Newest"];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight=250;
    self.tableview.rowHeight=UITableViewAutomaticDimension;
    
//    [RACObserve(self.tableview, contentSize)subscribeNext:^(id x) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"cs" object:x];
//    }];
    
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
    
}

@end
