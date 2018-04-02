//
//  CommunityViewController_Mode.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityViewController_Mode.h"
#import "CommunityTableViewCell.h"
#import "CommunityHeaderView.h"
#import "GroupSectionHeaderView.h"
#import <objc/runtime.h>

@interface CommunityViewController_Mode ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray * openStatus;

@end

@implementation CommunityViewController_Mode

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * openStatus=self.openStatus[section];
    if([openStatus isEqualToString:@"1"])
    {
        return 10;
    }else
    {
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CommunityHeaderView * header=[CommunityHeaderView shareView];
    header.frame=CGRectMake(0, 0, SDScreenWidth, 40);
    header.titleLab.text=@"样式";
    [header setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeader:)];
    objc_setAssociatedObject(tap,"section",[NSNumber numberWithInteger:section],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [header addGestureRecognizer:tap];
    return header;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"communityTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)clickHeader:(UITapGestureRecognizer*)tapges
{
    NSNumber * number = objc_getAssociatedObject(tapges,"section");
    NSString * res=self.openStatus[number.intValue];
    if([res isEqualToString:@"0"])
    {
        [self.openStatus replaceObjectAtIndex:number.integerValue withObject:@"1"];
    }else
    {
        [self.openStatus replaceObjectAtIndex:number.integerValue withObject:@"0"];
    }
   
    [self.tableview reloadData];
}


#pragma mark - LazyLoad

-(NSMutableArray *)openStatus
{
    if(_openStatus==nil)
    {
        _openStatus=[NSMutableArray arrayWithObjects:@"1",@"1",@"1",nil];
    }
    return _openStatus;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"CommunityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"communityTableViewCell"];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.needNoNetTips=NO;
    self.needNoTableViewDataTips=NO;
    self.baseTableview=self.tableview;
}

-(void)getInitData
{
    
}

@end
