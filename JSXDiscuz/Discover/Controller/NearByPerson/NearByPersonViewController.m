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
#import "FriendDetailData.h"

@interface NearByPersonViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray * listData;

@end

@implementation NearByPersonViewController

#pragma mark - TableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByPersonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nearByPersonTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    FriendDetailData * cellData = self.listData[indexPath.row];
    cell.friendData=cellData;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //别人的个人空间
    OtherCenterViewController * vc=[[OtherCenterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LazyLoad

-(NSMutableArray *)listData
{
    if(_listData==nil)
    {
        _listData=[NSMutableArray array];
    }
    return _listData;
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
    if(self.navTitle.length>0)
    {
        self.title=self.navTitle;
    }else
    {
        self.title=@"附近的人";
    }
}

-(void)getInitData
{
    [self searchFriend];
}

#pragma mark - 网络访问

-(void)searchFriend
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"username"]=self.username;
    params[@"gender"]=self.gender;
    params[@"affectivestatus"]=self.affectivestatus;
    params[@"lookingfor"]=self.lookingfor;
    params[@"education"]=self.education;
    params[@"revenue"]=self.revenue;
    params[@"age"]=self.age;
    
    [SVProgressHUD showWithStatus:@"加载中"];
    [JSXHttpTool Get:Interface_DiscoverySearchFriend params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            NSArray * arraydata=json[@"list"];
            for (int i=0; i<arraydata.count; i++) {
                NSDictionary * dict=arraydata[i];
                FriendDetailData * detailData = [FriendDetailData mj_objectWithKeyValues:dict];
                [self.listData addObject:detailData];
            }
            [self.tableview reloadData];
            [SVProgressHUD dismiss];
        }else
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    }];
}
@end
