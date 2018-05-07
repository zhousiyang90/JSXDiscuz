//
//  FriendViewController_focus.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/5/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "FriendViewController_focus.h"
#import "FriendTableViewCell_focus.h"

@interface FriendViewController_focus ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray * listData;

@end

@implementation FriendViewController_focus

#pragma mark - TableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendTableViewCell_focus * cell = [tableView dequeueReusableCellWithIdentifier:@"friendTableViewCell_focus"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //别人的个人空间
//    FriendDetailData * cellData = self.listData[indexPath.row];
//    [self pushToOtherPersonalCenter:cellData.uid];
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
    [self.tableview registerNib:[UINib nibWithNibName:@"FriendTableViewCell_focus" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"friendTableViewCell_focus"];
    
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.tableview addPullToRefreshWithActionHandler:^{
        [self.tableview.pullToRefreshView stopAnimating];
    }];
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.tableview;
}

-(void)getInitData
{
   
}


@end
