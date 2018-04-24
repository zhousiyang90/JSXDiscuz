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
#import "CommunityDetailViewController.h"
#import "CommunityMainPageData.h"

@interface CommunityViewController_Mode ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray * openStatus;

@property(nonatomic,strong) CommunityMainPageData *data;
@end

@implementation CommunityViewController_Mode

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.catlist.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * openStatus=self.openStatus[section];
    CommunityMainPageData_mode * mode=self.data.catlist[section];
    if([openStatus isEqualToString:@"1"])
    {
        return mode.forumlist.count;
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
    CommunityMainPageData_mode * mode = self.data.catlist[section];
    
    CommunityHeaderView * header=[CommunityHeaderView shareView];
    header.frame=CGRectMake(0, 0, SDScreenWidth, 40);
    header.titleLab.text=mode.name;
    [header setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeader:)];
    objc_setAssociatedObject(tap,"section",[NSNumber numberWithInteger:section],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [header addGestureRecognizer:tap];
    return header;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityMainPageData_mode *mode=self.data.catlist[indexPath.section];
    CommunityMainPageData_submode *submode=mode.forumlist[indexPath.row];
    
    CommunityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"communityTableViewCell"];
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:submode.icon] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Group]];
    cell.titleLab.text=submode.name;
    cell.descLab.text=submode.desc;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //社区详情
    CommunityMainPageData_mode *mode=self.data.catlist[indexPath.section];
    CommunityMainPageData_submode *submode=mode.forumlist[indexPath.row];
    CommunityDetailViewController *vc=[[CommunityDetailViewController alloc]init];
    vc.fid=submode.fid;
    [self.navigationController pushViewController:vc animated:YES];
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
        _openStatus=[NSMutableArray array];
    }
    return _openStatus;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"CommunityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"communityTableViewCell"];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=NO;
    self.baseTableview=self.tableview;
}

-(void)getInitData
{
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"uid"]=@"11";
    [JSXHttpTool Get:Interface_CommuityMainPage params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.data = [CommunityMainPageData mj_objectWithKeyValues:json];
            for (int i=0;i<self.data.catlist.count;i++) {
                 [self.openStatus addObject:@"1"];
            }
            self.publicLab.text=self.data.gonggao.message;
            [self.tableview reloadData];
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
