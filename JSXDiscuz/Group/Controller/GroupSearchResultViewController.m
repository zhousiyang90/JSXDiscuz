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

@property(nonatomic,strong) GroupMainData * data;

@end

@implementation GroupSearchResultViewController

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.search.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupMainData_summary *cellData=self.data.search[indexPath.row];
    TopicListTableViewCell_content * cell = [tableView dequeueReusableCellWithIdentifier:@"topicListTableViewCell_content"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.groupData=cellData;
    return cell;
 
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //小组详情
    GroupMainData_summary *cellData=self.data.search[indexPath.row];
    [self pushToGroupDetail:cellData.fid];
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
    self.title=@"搜索列表";
}

-(void)getInitData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"uid"]=[UserDataTools getUserInfo].uid;
    params[@"gcid"]=@"3";
    params[@"stxt"]=self.searchText;
    
    [SVProgressHUD showWithStatus:@"加载中"];
    [JSXHttpTool Get:Interface_GroupSearch params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.data = [GroupMainData mj_objectWithKeyValues:json];
            [self.contenttableview reloadData];
            [SVProgressHUD dismiss];
        }else
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)nonetstatusGetData
{
    [self getInitData];
}

@end
