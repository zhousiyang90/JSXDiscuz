//
//  SearchResultViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "SearchResultViewController.h"
#import "CommunityTableViewCell_Newest.h"
#import "CommunityNewestData.h"

@interface SearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL hasNewData;
}
@property(nonatomic,assign) int currentPage;
@property(nonatomic,strong) CommunityNewestData * currentPagedata;
@property(nonatomic,strong) NSMutableArray * dataList;

@end

@implementation SearchResultViewController

#pragma mark - UITableViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView==self.tableview)
    {
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentYoffset = scrollView.contentOffset.y;
        CGFloat distance = scrollView.contentSize.height-height-contentYoffset;
        if (distance<=0) {
            //[self getInitData];
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
    return self.dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"communityTableViewCell_Newest" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configCell:cell andIndexPath:indexPath];
    }];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityTableViewCell_Newest * cell = [tableView dequeueReusableCellWithIdentifier:@"communityTableViewCell_Newest"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [self configCell:cell andIndexPath:indexPath];
    cell.block = ^(int type) {
        if(type==0)
        {
            //点击头像和名称
            CommunityPostsData * cellData = self.dataList[indexPath.row];
            [self pushToOtherPersonalCenter:cellData.uid];
        }else if(type==1)
        {
            //社区详情
            CommunityPostsData * celldata=self.dataList[indexPath.row];
            [self pushToCommunityDetail:celldata.fid];
        }
    };
    return cell;
}


-(void)configCell:(CommunityTableViewCell_Newest*)cell andIndexPath:(NSIndexPath*)indexpath
{
    cell.postdata=self.dataList[indexpath.row];
    [cell.collectionView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击帖子详情
    CommunityPostsData * celldata=self.dataList[indexPath.row];
    [self pushToPostsDetail:celldata.tid andFid:celldata.fid];
}

#pragma mark - LazyLoad


#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"CommunityTableViewCell_Newest" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"communityTableViewCell_Newest"];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight=250;
    self.tableview.rowHeight=UITableViewAutomaticDimension;
    
    [self.tableview addPullToRefreshWithActionHandler:^{
        [self getInitData];
    }];
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.tableview;
}

-(void)setNavigationBar
{
    self.title=@"搜索";
}

-(void)getInitData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"subject"]=self.searchText;
    
    [SVProgressHUD showWithStatus:@"加载中"];
    [JSXHttpTool Get:Interface_DiscoverySearch params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.currentPagedata = [CommunityNewestData mj_objectWithKeyValues:json];
            self.dataList=self.currentPagedata.list;
            
            [self.tableview reloadData];
            [SVProgressHUD dismiss];
            [self.tableview.pullToRefreshView stopAnimating];
        }else
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:message];
            [self.tableview.pullToRefreshView stopAnimating];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableview.pullToRefreshView stopAnimating];
    }];
}

-(void)nonetstatusGetData
{
    
}


@end
