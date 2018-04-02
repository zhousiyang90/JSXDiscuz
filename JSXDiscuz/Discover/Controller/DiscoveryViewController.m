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

@interface DiscoveryViewController ()<UITableViewDelegate,UITableViewDataSource>

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
        
    }];
    
    [[cell rac_signalForSelector:@selector(clickview2)]subscribeNext:^(id x) {
        
    }];
    
    [[cell rac_signalForSelector:@selector(clickview3)]subscribeNext:^(id x) {
        
    }];
    
    [[cell rac_signalForSelector:@selector(clickview4)]subscribeNext:^(id x) {
        
    }];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DiscoveryHeaderTableViewCell * view = [DiscoveryHeaderTableViewCell shareView];
    view.weekLab.text=[JSXDateTool weekdayStringFromDate];
    view.dayLab.text=[JSXDateTool returnDD:[NSDate date]];
    view.yearmonthLab.text=[NSString stringWithFormat:@"%@年%@月",[JSXDateTool returnYYYY:[NSDate date]],[JSXDateTool returnMM:[NSDate date]]];
    
    [[view.searchview rac_textSignal]subscribeNext:^(id x) {
        SDLog(@"searchview:%@",x);
    }];
    
    return view;
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
