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
#import "CreatTopicViewController.h"
#import "TopicDetailViewController.h"
#import "TopicListViewController.h"
#import "GroupSearchResultViewController.h"

@interface GroupViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@end

@implementation GroupViewController

#pragma mark - UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //主题详情
    GroupSearchResultViewController * vc=[[GroupSearchResultViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

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
    return 8;
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
            //创建话题
            CreatTopicViewController * vc=[[CreatTopicViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return header;
    }else
    {
        GroupSectionHeaderView * header=[GroupSectionHeaderView shareView];
        header.themeLab.text=@"推荐话题";
        [header.functionBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        [[header.functionBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            //查看全部话题
            TopicListViewController * vc=[[TopicListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //话题详情
    TopicDetailViewController * vc=[[TopicDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 生命周期

-(void)addSubViews
{
    self.searchBar.translucent=NO;
    self.searchBar.backgroundColor=BGThemeColor;
    self.searchBar.barTintColor=BGThemeColor;
    self.searchBar.delegate=self;
    UITextField *textfield = [self.searchBar valueForKey:@"_searchField"];
    textfield.font=SDFontOf14;
    textfield.textColor=TextColor;
    [textfield setValue:SDFontOf14 forKeyPath:@"_placeholderLabel.font"];
    
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
