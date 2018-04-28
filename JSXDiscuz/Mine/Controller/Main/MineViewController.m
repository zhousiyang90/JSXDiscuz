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
#import "MineVIPStatusViewController.h"
#import "MineCenterSettingViewController.h"
#import "MineCenterSettingViewController.h"
#import "MineReNameViewController.h"
#import "FeedBackViewController.h"
#import "SystemInfoViewController.h"
#import "MineCollectionViewController.h"
#import "LoginViewController.h"

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
        [cell.headImgeView sd_setImageWithURL:[NSURL URLWithString:[UserDataTools getUserInfo].avatar] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Head]];
        cell.nameLab.text=[UserDataTools getUserInfo].username;
        cell.block = ^(int type){
            if(type==0)
            {
                //点击设置
                MineCenterSettingViewController * vc =[[MineCenterSettingViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else if(type==1)
            {
                //点击上传头像
                [self showSystemPhotos:^(NSArray *photos) {
                    if(photos.count>0)
                    {
                        NSMutableDictionary * params = [NSMutableDictionary dictionary];
                        NSString *url=[NSString stringWithFormat:@"%@&fouid=%@",Interface_UploadHeadImg,[UserDataTools getUserInfo].uid];
                        NSMutableDictionary * paramsofImg = [NSMutableDictionary dictionary];
                        paramsofImg[@"avatar"]=photos[0];
                        [JSXHttpTool upLoadOnePic:url params:params img:paramsofImg andCompress:0.5 success:^(id json) {
                            NSNumber * errcode=json[@"errcode"];
                            NSString * errmsg=json[@"errmsg"];
                            if(errcode==0)
                            {
                                NSString * imgUrl=json[@"img"];
                                UserData *user=[UserDataTools getUserInfo];
                                user.avatar=imgUrl;
                                [UserDataTools saveUserInfo:user];
                                [self.tableview reloadData];
                                
                            }else
                            {
                                [SVProgressHUD showErrorWithStatus:errmsg];
                            }
                            
                        } failure:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:error.description];
                        }];
                    }

                }];
            }
            
        };
        return cell;
        
    }else if(indexPath.section==self.layoutData.count-1)
    {
        MineLogoutTableView * cell = [tableView dequeueReusableCellWithIdentifier:@"mineLogoutTableView"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.block = ^{
            //点击退出
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"退出"message:@"确定要退出吗？"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //1.清空用户数据
                [UserDataTools clearUserInfo];
                //2.跳转到首页
                [self.tabBarController setSelectedIndex:0];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertController addAction:sureAction];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        };
        return cell;
    }else
    {
        MineMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mineMainTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if([data.leftTitle isEqualToString:@"会员"])
        {
            cell.leftLab.text=[UserDataTools getUserInfo].grouptitle;
        }else
        {
            cell.leftLab.text=data.leftTitle;
        }
        cell.rightLab.text=data.rightTitle;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        //个人中心
        MineCenterViewController2 * vc =[[MineCenterViewController2 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section==1)
    {
        if(indexPath.row==0)
        {
            //修改用户名
            MineReNameViewController * vc =[[MineReNameViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if(indexPath.row==1)
        {
            //会员状态
            MineVIPStatusViewController * vc =[[MineVIPStatusViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row==2)
        {
            //我的收藏
            MineCollectionViewController * vc =[[MineCollectionViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.section==2)
    {
        
    }else if(indexPath.section==3)
    {
        if(indexPath.row==0)
        {
            //点击个人设置
            MineCenterSettingViewController * vc =[[MineCenterSettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row==1)
        {
            //点击系统信息
            SystemInfoViewController * vc =[[SystemInfoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row==2)
        {
            //点击建议反馈
            FeedBackViewController * vc =[[FeedBackViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
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
        base1.leftTitle=@"修改用户名";
        MineMainDataModel * base2=[[MineMainDataModel alloc]init];
        base2.leftTitle=@"会员";
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
        set1.leftTitle=@"个人设置";
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

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableview reloadData];
}

@end
