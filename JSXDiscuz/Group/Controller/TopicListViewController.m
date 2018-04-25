//
//  TopicListViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "TopicListViewController.h"
#import "TopicListTableViewCell_index.h"
#import "TopicListTableViewCell_content.h"
#import "TopicDetailViewController.h"

@interface TopicListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL hasNewData;
}
@property(nonatomic,strong) GroupMainData * currentIndexData;
@property(nonatomic,strong) NSMutableArray * indexList;

@property(nonatomic,strong) GroupMainData * currentContentData;
@property(nonatomic,strong) NSMutableArray * contentList;

@end

@implementation TopicListViewController

#pragma mark - UITableViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView==self.contenttableview)
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
        self.contenttableview.tableFooterView=footer;
    }else
    {
        TableViewOfRefreshFooterView2 * footer2 = [TableViewOfRefreshFooterView2 shareView];
        footer2.frame=CGRectMake(0, 0, SDScreenWidth, 60);
        self.contenttableview.tableFooterView=footer2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.indextableview)
    {
        return self.indexList.count;
    }else
    {
        return self.contentList.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.indextableview)
    {
        return 50;
    }else
    {
        return 60;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.indextableview)
    {
        TopicListTableViewCell_index * cell = [tableView dequeueReusableCellWithIdentifier:@"topicListTableViewCell_index"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        GroupMainData_summary * topicType = self.indexList[indexPath.row];
        cell.topicLab.text=topicType.name;
        if(self.currentPage==indexPath.row)
        {
            cell.tintView.hidden=NO;
            cell.backgroundColor=[UIColor whiteColor];
        }else
        {
            cell.tintView.hidden=YES;
            cell.backgroundColor=BGThemeColor;
        }
        return cell;
    }else
    {
        TopicListTableViewCell_content * cell = [tableView dequeueReusableCellWithIdentifier:@"topicListTableViewCell_content"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        GroupMainData_summary * contentData = self.contentList[indexPath.row];
        cell.groupData=contentData;
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.indextableview)
    {
        self.currentPage=indexPath.row;
        [self.indextableview reloadData];
        
        GroupMainData_summary * indexdata = self.indexList[indexPath.row];
        [self getTypeListData:indexdata.fid];
    }else
    {
        //小组详情
        GroupMainData_summary * contentdata = self.contentList[indexPath.row];
        [self pushToGroupDetail:contentdata.fid];
    }
    
}

#pragma mark - LazyLoad

-(NSMutableArray *)indexList
{
    if(_indexList==nil)
    {
        _indexList=[NSMutableArray array];
    }
    return _indexList;
}

-(NSMutableArray *)contentList
{
    if(_contentList==nil)
    {
        _contentList=[NSMutableArray array];
    }
    return _contentList;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    self.currentPage=0;
    
    [self.indextableview registerNib:[UINib nibWithNibName:@"TopicListTableViewCell_index" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"topicListTableViewCell_index"];
    [self.contenttableview registerNib:[UINib nibWithNibName:@"TopicListTableViewCell_content" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"topicListTableViewCell_content"];
    
    self.indextableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.contenttableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.contenttableview addPullToRefreshWithActionHandler:^{
        [self.contenttableview.pullToRefreshView stopAnimating];
    }];
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.contenttableview;
}

-(void)setNavigationBar
{
    self.title=@"全部话题";
}

-(void)getInitData
{
    [self getTypeData];
}

-(void)nonetstatusGetData
{
    [self getInitData];
}

#pragma mark - 网络访问

-(void)getTypeData
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
    params[@"gcid"]=@"3";
    [JSXHttpTool Get:Interface_GroupAllList params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.currentIndexData = [GroupMainData mj_objectWithKeyValues:json];
            self.indexList=self.currentIndexData.alllist;
            //请求默认页数据
            if(self.currentIndexData.alllist.count>0)
            {
                GroupMainData_summary *detailData=self.currentIndexData.alllist[0];
                [self getTypeListData:detailData.fid];
            }
            [self.indextableview reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
    }];
}

-(void)getTypeListData:(NSString*)fid
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
    params[@"fid"]=fid;
    [SVProgressHUD showWithStatus:@"加载中..."];
    [JSXHttpTool Get:Interface_GroupAllTypeList params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.currentContentData = [GroupMainData mj_objectWithKeyValues:json];
            self.contentList=self.currentContentData.glist;
            [self.contenttableview reloadData];
            [SVProgressHUD dismiss];
        }else
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
