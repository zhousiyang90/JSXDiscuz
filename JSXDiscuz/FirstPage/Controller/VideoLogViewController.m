//
//  VideoLogViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/11.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "VideoLogViewController.h"
#import "VideoLogTableViewCell_rec.h"
#import "VideoLogTableViewCell_common.h"
#import "TableViewTitleCellView.h"


@interface VideoLogViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL hasNewData;
}
@property(nonatomic,strong) NSMutableArray * videoList;

@end

@implementation VideoLogViewController

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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 40;
    }else if(indexPath.row==1)
    {
        return 260;
    }
    else
    {
        NSInteger hang = self.videoList.count/2+self.videoList.count%2;
        return hang*SDScreenWidth*1.0/3.0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        TableViewTitleCellView * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewTitleCellView"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.titleLab.text=@"精选视频";
        return cell;
    }else if(indexPath.row==1)
    {
        VideoLogTableViewCell_rec * cell = [tableView dequeueReusableCellWithIdentifier:@"videoLogTableViewCell_rec"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        VideoLogTableViewCell_common * cell = [tableView dequeueReusableCellWithIdentifier:@"videoLogTableViewCell_common"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.videoList=self.videoList;
        return cell;
    }
    
}

#pragma mark - LazyLoad

-(NSMutableArray *)videoList
{
    if(_videoList==nil)
    {
        _videoList=[NSMutableArray arrayWithObjects:@"14",@"13",@"20",@"30",@"40",@"50",@"3",nil];
    }
    return _videoList;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"TableViewTitleCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tableViewTitleCellView"];
    [self.tableview registerNib:[UINib nibWithNibName:@"VideoLogTableViewCell_rec" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"videoLogTableViewCell_rec"];
    [self.tableview registerNib:[UINib nibWithNibName:@"VideoLogTableViewCell_common" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"videoLogTableViewCell_common"];
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
