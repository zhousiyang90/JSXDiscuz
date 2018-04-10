//
//  NearByPersonViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "NearByPersonViewController.h"
#import "NearByPersonTableViewCell.h"
#import "OtherCenterViewController.h"

@interface NearByPersonViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation NearByPersonViewController

#pragma mark - TableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByPersonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nearByPersonTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //别人的个人空间
    OtherCenterViewController * vc=[[OtherCenterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"NearByPersonTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nearByPersonTableViewCell"];

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
    self.title=@"附近的人";
}

@end
