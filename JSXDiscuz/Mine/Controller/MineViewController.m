//
//  MineViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineViewController.h"
#import "MineMainDataModel.h"
#import "MineMainTableViewCell.h"
#import "MineHeaderTableViewCell.h"
#import "MineLogoutTableView.h"
#import "MineCenterViewController.h"
#import "MineCenterViewController2.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray * layoutData;

@end

@implementation MineViewController

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
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
         return 80;
    }else if(indexPath.row==self.layoutData.count-1)
    {
         return 60;
    }else
    {
         return 50;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header=[[UIView alloc]init];
    header.backgroundColor=BGThemeColor;
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * sections = self.layoutData[indexPath.section];
    MineMainDataModel * data=sections[indexPath.row];
    
    if(indexPath.section==0)
    {
        MineHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mineHeaderTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [[cell rac_signalForSelector:@selector(clickSetting:)]subscribeNext:^(id x) {
            //点击设置
        }];
        return cell;
        
    }else if(indexPath.section==self.layoutData.count-1)
    {
        MineLogoutTableView * cell = [tableView dequeueReusableCellWithIdentifier:@"mineLogoutTableView"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [[cell rac_signalForSelector:@selector(clickLogout:)]subscribeNext:^(id x) {
            //点击退出
        }];
        return cell;
    }else
    {
        MineMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mineMainTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.leftLab.text=data.leftTitle;
        cell.rightLab.text=data.rightTitle;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        MineCenterViewController2 * vc =[[MineCenterViewController2 alloc]init];
        //MineCenterViewController * vc =[[MineCenterViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - LazyLoad

-(NSMutableArray *)layoutData
{
    if(_layoutData==nil)
    {
        _layoutData=[NSMutableArray array];
        
        MineMainDataModel * head=[[MineMainDataModel alloc]init];
        head.name=@"ZS";
        NSMutableArray * section1=[NSMutableArray arrayWithObject:head];
        
        MineMainDataModel * base1=[[MineMainDataModel alloc]init];
        base1.leftTitle=@"完善个人账号";
        MineMainDataModel * base2=[[MineMainDataModel alloc]init];
        base2.leftTitle=@"一级会员";
        MineMainDataModel * base3=[[MineMainDataModel alloc]init];
        base3.leftTitle=@"我的收藏";;
        NSMutableArray * section2=[NSMutableArray arrayWithObjects:base1,base2,base3,nil];
        
        MineMainDataModel * mes1=[[MineMainDataModel alloc]init];
        mes1.leftTitle=@"系统消息";
        mes1.rightTitle=@"查看";
        MineMainDataModel * mes2=[[MineMainDataModel alloc]init];
        mes2.leftTitle=@"聊天";
        mes2.rightTitle=@"查看";
        MineMainDataModel * mes3=[[MineMainDataModel alloc]init];
        mes3.leftTitle=@"联系人";
        mes3.rightTitle=@"查看";
        NSMutableArray * section3=[NSMutableArray arrayWithObjects:mes1,mes2,mes3,nil];
        
        MineMainDataModel * set1=[[MineMainDataModel alloc]init];
        set1.leftTitle=@"编辑资料";
        MineMainDataModel * set2=[[MineMainDataModel alloc]init];
        set2.leftTitle=@"系统反馈";
        MineMainDataModel * set3=[[MineMainDataModel alloc]init];
        set3.leftTitle=@"问题反馈";;
        NSMutableArray * section4=[NSMutableArray arrayWithObjects:set1,set2,set3,nil];
        
        MineMainDataModel * logout=[[MineMainDataModel alloc]init];
        logout.name=@"退出登录";
        NSMutableArray * section5=[NSMutableArray arrayWithObject:logout];
        
        [_layoutData addObject:section1];
        [_layoutData addObject:section2];
        [_layoutData addObject:section3];
        [_layoutData addObject:section4];
        [_layoutData addObject:section5];
        
        
    }
    return _layoutData;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"MineMainTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineMainTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MineHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineHeaderTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MineLogoutTableView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineLogoutTableView"];
    
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.needNoNetTips=NO;
    self.needNoTableViewDataTips=NO;
    self.baseTableview=self.tableview;
}

-(void)setNavigationBar
{
    self.title=@"我的";
}

-(void)getInitData
{
    
}

@end
