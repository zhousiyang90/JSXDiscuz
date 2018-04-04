//
//  MineCenterViewController_info.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterViewController_info.h"
#import "MinePersonalSubTableViewCell.h"
#import "MineMainDataModel.h"
#import "MineTypeHeaderView.h"

@interface MineCenterViewController_info ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray * layoutData;

@end

@implementation MineCenterViewController_info

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.layoutData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * funs = self.layoutData[section];
    NSString * key = funs.allKeys[0];
    NSArray * list = funs[key];
    return list.count;
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
    NSDictionary * dict = self.layoutData[section];
    MineTypeHeaderView * header=[MineTypeHeaderView shareView];
    header.titleLab.text=dict.allKeys[0];
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * sections = self.layoutData[indexPath.section];
    NSString * key = sections.allKeys[0];
    NSArray * list = sections[key];
    MineMainDataModel * data=list[indexPath.row];
    
    MinePersonalSubTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"minePersonalSubTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.typeLab.text=data.leftTitle;
    if(data.centerTitle.length==0)
    {
        cell.contentLab.text=@"前去完善";
    }else
    {
        cell.contentLab.text=data.centerTitle;
    }
    cell.arrowImg.hidden=!data.hasArrow;
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
        
        MineMainDataModel * head=[[MineMainDataModel alloc]init];
        head.leftTitle=@"用户组";
        head.centerTitle=@"一级会员";
        head.hasArrow=YES;
        MineMainDataModel * head2=[[MineMainDataModel alloc]init];
        head2.leftTitle=@"经验值";
        head2.centerTitle=@"100";
        head2.hasArrow=YES;
        NSMutableArray * section1=[NSMutableArray arrayWithObjects:head,head2,nil];
        NSDictionary * dict1=[NSDictionary dictionaryWithObject:section1 forKey:@"用户信息"];
        
        MineMainDataModel * base1=[[MineMainDataModel alloc]init];
        base1.leftTitle=@"性别";
        base1.hasArrow=NO;
        MineMainDataModel * base2=[[MineMainDataModel alloc]init];
        base2.leftTitle=@"血型";
        base2.hasArrow=NO;
        MineMainDataModel * base3=[[MineMainDataModel alloc]init];
        base3.leftTitle=@"情感状态";
        base3.hasArrow=NO;
        MineMainDataModel * base4=[[MineMainDataModel alloc]init];
        base4.leftTitle=@"生日";
        base4.hasArrow=NO;
        MineMainDataModel * base5=[[MineMainDataModel alloc]init];
        base5.leftTitle=@"身高";
        base5.hasArrow=NO;
        MineMainDataModel * base6=[[MineMainDataModel alloc]init];
        base6.leftTitle=@"体重";
        base6.hasArrow=NO;
        NSMutableArray * section2=[NSMutableArray arrayWithObjects:base1,base2,base3,base4,base5,base6,nil];
        NSDictionary * dict2=[NSDictionary dictionaryWithObject:section2 forKey:@"基本信息"];
        
        MineMainDataModel * mes1=[[MineMainDataModel alloc]init];
        mes1.leftTitle=@"行业";
        mes1.hasArrow=NO;
        MineMainDataModel * mes2=[[MineMainDataModel alloc]init];
        mes2.leftTitle=@"职业";
        mes2.hasArrow=NO;
        MineMainDataModel * mes3=[[MineMainDataModel alloc]init];
        mes3.leftTitle=@"年收入";
        mes3.hasArrow=NO;
        MineMainDataModel * mes4=[[MineMainDataModel alloc]init];
        mes4.leftTitle=@"所在单位";
        mes4.hasArrow=NO;
        NSMutableArray * section3=[NSMutableArray arrayWithObjects:mes1,mes2,mes3,mes4,nil];
        NSDictionary * dict3=[NSDictionary dictionaryWithObject:section3 forKey:@"工作信息"];
        
        MineMainDataModel * set1=[[MineMainDataModel alloc]init];
        set1.leftTitle=@"交友目的";
        set1.hasArrow=NO;
        MineMainDataModel * set2=[[MineMainDataModel alloc]init];
        set2.leftTitle=@"学历";
        set2.hasArrow=NO;
        MineMainDataModel * set3=[[MineMainDataModel alloc]init];
        set3.leftTitle=@"QQ号";
        set3.hasArrow=NO;
        MineMainDataModel * set4=[[MineMainDataModel alloc]init];
        set4.leftTitle=@"真实姓名";
        set4.hasArrow=NO;
        MineMainDataModel * set5=[[MineMainDataModel alloc]init];
        set5.leftTitle=@"毕业院校";
        set5.hasArrow=NO;
        NSMutableArray * section4=[NSMutableArray arrayWithObjects:set1,set2,set3,set4,set5,nil];
        NSDictionary * dict4=[NSDictionary dictionaryWithObject:section4 forKey:@"其他信息"];
        
        MineMainDataModel * logout=[[MineMainDataModel alloc]init];
        logout.leftTitle=@"兴趣爱好";
        logout.hasArrow=NO;
        NSMutableArray * section5=[NSMutableArray arrayWithObject:logout];
        NSDictionary * dict5=[NSDictionary dictionaryWithObject:section5 forKey:@"兴趣爱好"];
        
        MineMainDataModel * aboutme=[[MineMainDataModel alloc]init];
        aboutme.leftTitle=@"自我介绍";
        aboutme.hasArrow=NO;
        NSMutableArray * section6=[NSMutableArray arrayWithObject:aboutme];
        NSDictionary * dict6=[NSDictionary dictionaryWithObject:section6 forKey:@"兴趣爱好"];
        
        [_layoutData addObject:dict1];
        [_layoutData addObject:dict2];
        [_layoutData addObject:dict3];
        [_layoutData addObject:dict4];
        [_layoutData addObject:dict5];
        [_layoutData addObject:dict6];
        
    }
    return _layoutData;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"MinePersonalSubTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"minePersonalSubTableViewCell"];
    
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
//    [RACObserve(self.tableview, contentSize)subscribeNext:^(id x) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"cs" object:x];
//    }];
    
    self.needNoNetTips=NO;
    self.needNoTableViewDataTips=NO;
    self.baseTableview=self.tableview;
}

-(void)setNavigationBar
{
    
}

-(void)getInitData
{
    
}

@end
