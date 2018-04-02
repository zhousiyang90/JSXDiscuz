//
//  GroupViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupViewTableViewCell.h"
#import "GroupSectionHeaderView.h"

@interface GroupViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GroupViewController

#pragma mark - UITableViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        GroupSectionHeaderView * header=[GroupSectionHeaderView shareView];
        header.themeLab.text=@"我的话题";
        [header.functionBtn setTitle:@"创建话题" forState:UIControlStateNormal];
        [[header.functionBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
        }];
        return header;
    }else
    {
        GroupSectionHeaderView * header=[GroupSectionHeaderView shareView];
        header.themeLab.text=@"推荐话题";
        [header.functionBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        [[header.functionBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
        }];
        return header;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"groupViewTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    self.searchBar.translucent=NO;
    self.searchBar.barTintColor=BGThemeColor;
    
    [self.groupTableView registerNib:[UINib nibWithNibName:@"GroupViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"groupViewTableViewCell"];
    
    self.groupTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.groupTableView;
}

-(void)setNavigationBar
{
    self.title=@"小组";
}

-(void)getInitData
{
    
}

@end
