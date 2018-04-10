//
//  DiscoveryViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/30.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryHeaderTableViewCell.h"
#import "DiscoveryContentTableViewCell.h"
#import "NearByPersonViewController.h"
#import "WritingLogViewController.h"
#import "NearByThingViewController.h"
#import "SearchResultViewController.h"
#import "FindFriendsViewController.h"

@interface DiscoveryViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation DiscoveryViewController


#pragma mark - TableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 250;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoveryContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"discoveryContentTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [[cell rac_signalForSelector:@selector(clickview1)]subscribeNext:^(id x) {
        //找朋友
        FindFriendsViewController *vc=[[FindFriendsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[cell rac_signalForSelector:@selector(clickview2)]subscribeNext:^(id x) {
        //写日志
        WritingLogViewController * vc = [[WritingLogViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[cell rac_signalForSelector:@selector(clickview3)]subscribeNext:^(id x) {
        //附近的人
        NearByPersonViewController * vc=[[NearByPersonViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[cell rac_signalForSelector:@selector(clickview4)]subscribeNext:^(id x) {
        //附近的事
        NearByThingViewController * vc=[[NearByThingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DiscoveryHeaderTableViewCell * view = [DiscoveryHeaderTableViewCell shareView];
    view.weekLab.text=[JSXDateTool weekdayStringFromDate];
    view.dayLab.text=[JSXDateTool returnDD:[NSDate date]];
    view.yearmonthLab.text=[NSString stringWithFormat:@"%@年%@月",[JSXDateTool returnYYYY:[NSDate date]],[JSXDateTool returnMM:[NSDate date]]];
    view.searchview.delegate=self;
    [[view.searchview rac_textSignal]subscribeNext:^(id x) {
        SDLog(@"searchview:%@",x);
    }];
    
    return view;
}


#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //搜索结果
    SearchResultViewController * vc=[[SearchResultViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    return YES;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"DiscoveryHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discoveryHeaderTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"DiscoveryContentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discoveryContentTableViewCell"];
    
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.bounces=NO;
    self.tableview.contentInset=UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.bounds.size.height, 0);
    
    self.needNoNetTips=NO;
    self.needNoTableViewDataTips=NO;
    self.baseTableview=self.tableview;
}

-(void)setNavigationBar
{
    self.title=@"发现";
}

@end
