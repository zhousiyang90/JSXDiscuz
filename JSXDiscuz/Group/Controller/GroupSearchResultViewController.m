//
//  GroupSearchResultViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "GroupSearchResultViewController.h"
#import "TopicListTableViewCell_content.h"
#import "TopicDetailViewController.h"

@interface GroupSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GroupSearchResultViewController

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicListTableViewCell_content * cell = [tableView dequeueReusableCellWithIdentifier:@"topicListTableViewCell_content"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
 
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //主题详情
    TopicDetailViewController * vc=[[TopicDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 生命周期

-(void)addSubViews
{
    [self.contenttableview registerNib:[UINib nibWithNibName:@"TopicListTableViewCell_content" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"topicListTableViewCell_content"];
    self.contenttableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.contenttableview;
}

-(void)setNavigationBar
{
    self.title=@"搜索";
}

-(void)getInitData
{

}

-(void)nonetstatusGetData
{
    
}

@end
