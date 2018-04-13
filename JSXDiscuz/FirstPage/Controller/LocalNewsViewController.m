//
//  LocalNewsViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "LocalNewsViewController.h"
#import "LocalNewsTableViewCell.h"
#import "LocalNewsHeaderTableViewCell.h"
#import "VideoLogTableViewCell_rec.h"
#import "TableViewTitleCellView.h"

@interface LocalNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL hasNewData;
}
@property(nonatomic, strong) NSMutableArray *layoutData;

@end

@implementation LocalNewsViewController

#pragma mark -UITableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layoutData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * cellName = self.layoutData[indexPath.row];
    if([cellName isEqualToString:@"localnewsheader"])
    {
        LocalNewsHeaderTableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:@"localNewsHeaderTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if([cellName isEqualToString:@"title1"])
    {
        TableViewTitleCellView * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewTitleCellView"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.titleLab.text=@"热门排行";
        return cell;
        
    }else if([cellName isEqualToString:@"localnews"])
    {
        LocalNewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"localNewsTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if([cellName isEqualToString:@"title2"])
    {
        TableViewTitleCellView * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewTitleCellView"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.titleLab.text=@"视频资讯";
        return cell;
        
    }else if([cellName isEqualToString:@"videoheader"])
    {
        VideoLogTableViewCell_rec * cell = [tableView dequeueReusableCellWithIdentifier:@"videoLogTableViewCell_rec"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
        [_layoutData addObject:@"localnewsheader"];
        [_layoutData addObject:@"title1"];
        [_layoutData addObject:@"localnews"];
        [_layoutData addObject:@"localnews"];
        [_layoutData addObject:@"localnews"];
        [_layoutData addObject:@"title2"];
        [_layoutData addObject:@"videoheader"];
        [_layoutData addObject:@"videoheader"];
        [_layoutData addObject:@"videoheader"];
    }
    return _layoutData;
}


#pragma mark - VC生命周期

-(void)addSubViews
{

    [self.tableview registerNib:[UINib nibWithNibName:@"TableViewTitleCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tableViewTitleCellView"];
    [self.tableview registerNib:[UINib nibWithNibName:@"LocalNewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"localNewsTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"LocalNewsHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"localNewsHeaderTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"VideoLogTableViewCell_rec" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"videoLogTableViewCell_rec"];
    
    
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
