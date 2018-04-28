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
#import "GroupMainData.h"

@interface GroupViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property(nonatomic,strong) GroupMainData * data;

@end

@implementation GroupViewController

#pragma mark - UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    if(searchBar.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"搜索内容为空"];
        return;
    }
    //主题详情
    GroupSearchResultViewController * vc=[[GroupSearchResultViewController alloc]init];
    vc.searchText=searchBar.text;
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
    if(section==0)
    {
        return self.data.myforumlist.count;
    }else
    {
        return self.data.forumlist.count;
    }
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
    GroupMainData_summary * celldatas;
    if(indexPath.section==0)
    {
        celldatas=self.data.myforumlist[indexPath.row];
    }else
    {
        celldatas=self.data.forumlist[indexPath.row];
    }
    GroupViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"groupViewTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:celldatas.icon] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Head]];
    cell.descLab.text=celldatas.desc;
    cell.nameLab.text=celldatas.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupMainData_summary * celldatas;
    if(indexPath.section==0)
    {
        celldatas=self.data.myforumlist[indexPath.row];
    }else
    {
        celldatas=self.data.forumlist[indexPath.row];
    }
    //话题详情
    TopicDetailViewController * vc=[[TopicDetailViewController alloc]init];
    vc.fid=celldatas.fid;
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
    
    [self.groupTableView addPullToRefreshWithActionHandler:^{
        [self getInitData];
    }];
    
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
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if([UserDataTools getUserInfo].uid.length==0)
    {
        [self showLoginView];
        return;
    }else
    {
        params[@"uid"]=[UserDataTools getUserInfo].uid;
    }
    [SVProgressHUD showWithStatus:@"加载中"];
    [JSXHttpTool Get:Interface_GroupMainPage params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.data = [GroupMainData mj_objectWithKeyValues:json];
            [self.groupTableView reloadData];
            [SVProgressHUD dismiss];
            [self.groupTableView.pullToRefreshView stopAnimating];
        }else
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:message];
            [self.groupTableView.pullToRefreshView stopAnimating];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self.groupTableView.pullToRefreshView stopAnimating];
    }];
}

-(void)nonetstatusGetData
{
    [self getInitData];
}

-(void)nodatasGetData
{
    [self getInitData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getInitData];
}

@end
