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

@property(nonatomic,strong) NSMutableArray * indexList;

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
        return 15;
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
        NSString * topicType = self.indexList[indexPath.row];
        cell.topicLab.text=topicType;
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
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.indextableview)
    {
        self.currentPage=indexPath.row;
        [self.indextableview reloadData];
        [self.contenttableview reloadData];
    }else
    {
        //主题详情
        TopicDetailViewController * vc=[[TopicDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - LazyLoad

-(NSMutableArray *)indexList
{
    if(_indexList==nil)
    {
        _indexList=[NSMutableArray array];
        [_indexList addObject:@"科学技术"];
        [_indexList addObject:@"数码"];
        [_indexList addObject:@"情感"];
        [_indexList addObject:@"人文自然"];
        [_indexList addObject:@"地区"];
        [_indexList addObject:@"学校"];
        [_indexList addObject:@"兴趣"];
        [_indexList addObject:@"休闲"];
        [_indexList addObject:@"游戏"];
        [_indexList addObject:@"动漫"];
        [_indexList addObject:@"小说"];
    }
    return _indexList;
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
    hasNewData=NO;
    [self.contenttableview reloadData];
    [self setMainTableViewFooterView];
}

-(void)nonetstatusGetData
{
    
}

@end
