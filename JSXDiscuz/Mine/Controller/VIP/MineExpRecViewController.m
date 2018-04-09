//
//  MineExpRecViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineExpRecViewController.h"
#import "MineExpRecTableViewCell.h"

@interface MineExpRecViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL hasNewData;
}
@end

@implementation MineExpRecViewController

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    MineExpRecTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mineExpRecTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
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

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"MineExpRecTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineExpRecTableViewCell"];
    
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.tableview addPullToRefreshWithActionHandler:^{
        [self.tableview.pullToRefreshView stopAnimating];
    }];
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.tableview;
}

-(void)setNavigationBar
{
    self.title=@"经验记录";
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
