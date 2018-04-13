//
//  SeedingViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "SeedingViewController.h"
#import "SeedingHeaderTableViewCell.h"
#import "SeedingContentShareTableViewCell1.h"
#import "SeedingContentShareTableViewCell2.h"

@interface SeedingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL hasNewData;
}
@property(nonatomic,strong) NSMutableArray * videoList;

@end

@implementation SeedingViewController

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
        return SDScreenWidth;
    }else if(indexPath.row==1)
    {
        return 150;
    }else if(indexPath.row==2)
    {
        NSInteger hang = self.videoList.count/2+self.videoList.count%2;
        return hang*SDScreenWidth*1.0/3.0+40;
    }
    return 0.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        SeedingHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"seedingHeaderTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row==1)
    {
        SeedingContentShareTableViewCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"seedingContentShareTableViewCell1"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row==2)
    {
        SeedingContentShareTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"seedingContentShareTableViewCell2"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.videoList=self.videoList;
        return cell;
    }
    return nil;
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
    [self.tableview registerNib:[UINib nibWithNibName:@"SeedingHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"seedingHeaderTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"SeedingContentShareTableViewCell1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"seedingContentShareTableViewCell1"];
    [self.tableview registerNib:[UINib nibWithNibName:@"SeedingContentShareTableViewCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"seedingContentShareTableViewCell2"];
    
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
