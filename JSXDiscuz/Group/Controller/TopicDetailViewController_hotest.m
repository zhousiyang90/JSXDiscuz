//
//  TopicDetailViewController_hotest.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "TopicDetailViewController_hotest.h"
#import "CommunityTableViewCell_Newest.h"
#import "CommunityNewestData.h"

@interface TopicDetailViewController_hotest ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL hasNewData;
}
@property(nonatomic,assign) int currentPage;
@property(nonatomic,strong) CommunityNewestData * currentPagedata;

@end

@implementation TopicDetailViewController_hotest

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
            //个人中心
            CommunityPostsData * celldata=self.dataList[indexPath.row];
            [self pushToOtherPersonalCenter:celldata.uid];
        }
    };
    return cell;
}


-(void)configCell:(CommunityTableViewCell_Newest*)cell andIndexPath:(NSIndexPath*)indexpath
{
    cell.postdata=self.dataList[indexpath.row];
    [cell.collectionView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityPostsData * postData=self.dataList[indexPath.row];
    [self pushToPostsDetail:postData.tid andFid:postData.fid];
}

#pragma mark - LazyLoad

-(void)setDataList:(NSMutableArray *)dataList
{
    _dataList=dataList;
    [self.tableview reloadData];
}

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"CommunityTableViewCell_Newest" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"communityTableViewCell_Newest"];
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

-(void)getInitData
{
    if(self.dataList==nil&&self.fid.length>0)
    {
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        if([UserDataTools getUserInfo].uid.length==0)
    {
        [self showLoginView];
        return;
    }else
    {
        params[@"uid"]=[UserDataTools getUserInfo].uid;
    }
        params[@"fid"]=self.fid;
        [JSXHttpTool Get:Interface_GroupMainPageDetail params:params success:^(id json) {
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
}

-(void)nonetstatusGetData
{
    [self getInitData];
}

@end

