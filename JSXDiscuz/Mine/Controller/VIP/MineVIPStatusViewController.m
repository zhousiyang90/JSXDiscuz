//
//  MineVIPStatusViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineVIPStatusViewController.h"
#import "MineMainDataModel.h"
#import "MineVIPStatusTableViewCell.h"
#import "MineTypeHeaderView.h"

@interface MineVIPStatusViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray * layoutData;

@end

@implementation MineVIPStatusViewController

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.layoutData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * funs = self.layoutData[section];
    return funs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MineTypeHeaderView * header=[MineTypeHeaderView shareView];
    header.titleLab.text=@"用户权限";
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * sections = self.layoutData[indexPath.section];
    MineMainDataModel * data=sections[indexPath.row];
    
    MineVIPStatusTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mineVIPStatusTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(data.allowable)
    {
        cell.statusImge.hidden=NO;
    }else
    {
        cell.statusImge.hidden=YES;
    }
    cell.userLab.text=data.leftTitle;
    cell.statusLab.text=data.rightTitle;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark - LazyLoad

-(NSMutableArray *)layoutData
{
    if(_layoutData==nil)
    {
        _layoutData=[NSMutableArray array];
        
        MineMainDataModel * base1=[[MineMainDataModel alloc]init];
        base1.leftTitle=@"用户组";
        base1.allowable=NO;
        base1.rightTitle=@"二级会员";
        
        MineMainDataModel * base2=[[MineMainDataModel alloc]init];
        base2.leftTitle=@"允许访问";
        base2.allowable=YES;
        base2.rightTitle=@"";
        
        MineMainDataModel * base3=[[MineMainDataModel alloc]init];
        base3.leftTitle=@"允许发帖";
        base3.allowable=YES;
        base3.rightTitle=@"";
        
        MineMainDataModel * base4=[[MineMainDataModel alloc]init];
        base4.leftTitle=@"允许回帖";
        base4.allowable=YES;
        base4.rightTitle=@"";
        
        MineMainDataModel * base5=[[MineMainDataModel alloc]init];
        base5.leftTitle=@"允许创建话题数";
        base5.allowable=NO;
        base5.rightTitle=@"2";
        
        MineMainDataModel * base6=[[MineMainDataModel alloc]init];
        base6.leftTitle=@"创建话题免审核";
        base6.allowable=YES;
        base6.rightTitle=@"";
        
        MineMainDataModel * base7=[[MineMainDataModel alloc]init];
        base7.leftTitle=@"允许添加好友";
        base7.allowable=YES;
        base7.rightTitle=@"";
        
        MineMainDataModel * base8=[[MineMainDataModel alloc]init];
        base8.leftTitle=@"允许发送消息";
        base8.allowable=YES;
        base8.rightTitle=@"";
        
        MineMainDataModel * base9=[[MineMainDataModel alloc]init];
        base9.leftTitle=@"允许点赞";
        base9.allowable=YES;
        base9.rightTitle=@"";
        
        MineMainDataModel * base10=[[MineMainDataModel alloc]init];
        base10.leftTitle=@"发帖免审核";
        base10.allowable=YES;
        base10.rightTitle=@"";
        
        MineMainDataModel * base11=[[MineMainDataModel alloc]init];
        base11.leftTitle=@"升级所需经验";
        base11.allowable=NO;
        base11.rightTitle=@"100";
        
        NSMutableArray * section1=[NSMutableArray arrayWithObjects:base1,base2,base3,base4,base5,base6,base7,base8,base9,base10,base11,nil];
        
        [_layoutData addObject:section1];
        
    }
    return _layoutData;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"MineVIPStatusTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineVIPStatusTableViewCell"];
    
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.needNoNetTips=NO;
    self.needNoTableViewDataTips=NO;
    self.baseTableview=self.tableview;
}

-(void)setNavigationBar
{
    self.title=@"用户组";
}

-(void)getInitData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"fouid"]=[UserDataTools getUserInfo].uid;
    [JSXHttpTool Get:Interface_PersonaUserPermission params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * errmsg = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            [self.tableview reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:errmsg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    }];
}


@end
