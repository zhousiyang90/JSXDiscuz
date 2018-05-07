//
//  OtherCenterViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "OtherCenterViewController.h"
#import "MineCenterHeaderTableCell2.h"
#import "OtherCenterNavBarView.h"
#import "MineCenterScrollViewTableCell2.h"
#import "MineCenterViewController_circle.h"
#import "MineCenterViewController_focus.h"
#import "MineCenterViewController_mine.h"
#import "MineCenterViewController_info.h"
#import "CommunityTableViewCell_Newest.h"
#import "MineMainDataModel.h"
#import "MinePersonalSubTableViewCell.h"
#import "MineTypeHeaderView.h"
#import "MineVIPStatusViewController.h"
#import "MineExpRecViewController.h"
#import "MineCenterSettingViewController.h"
#import "OtherCenterHeaderTableCell.h"

@interface OtherCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIView * lineView;
    
    OtherCenterNavBarView * header;
    
}

@property(nonatomic,strong) NSMutableArray * testList;
@property(nonatomic,strong) NSMutableArray * layoutData;

@property(nonatomic,strong) PersonalDataInfo * personalDataInfo;
@property(nonatomic,strong) PersonalDataAboutMeInfo * personalAboutMeInfo;
@end

@implementation OtherCenterViewController

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.currentPage==1)
    {
        return self.layoutData.count+2;
    }else
    {
        return 2;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
    }else
    {
        if(self.currentPage==1)
        {
            if(section==1)
            {
                return 0.0;
            }else
            {
                NSDictionary * funs = self.layoutData[section-2];
                NSString * key = funs.allKeys[0];
                NSArray * list = funs[key];
                return list.count;
            }
        }else if(self.currentPage==0)
        {
            return self.testList.count;
        }else
        {
            return 0;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 0.0;
    }else
    {
        return 40;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 260;
    }else
    {
        if(self.currentPage==1)
        {
            if(indexPath.section==1)
            {
                return 0.0;
            }else
            {
                return 50.0;
            }
        }else
        {
            CGFloat autoHeight = [tableView fd_heightForCellWithIdentifier:@"communityTableViewCell_Newest" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configCell:cell andIndexPath:indexPath];
            }];
            
            return autoHeight;
        }
    }
}

-(void)configCell:(CommunityTableViewCell_Newest*)cell andIndexPath:(NSIndexPath*)indexpath
{
    if(self.currentPage==0)
    {
        cell.data=self.testList[indexpath.row];
        [cell.collectionView reloadData];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        UIView * header=[[UIView alloc]init];
        return header;
    }else
    {
        if(self.currentPage==1 && section!=1)
        {
            NSDictionary * dict = self.layoutData[section-2];
            MineTypeHeaderView * header=[MineTypeHeaderView shareView];
            header.titleLab.text=dict.allKeys[0];
            return header;
        }else
        {
            header=[OtherCenterNavBarView shareView];
            header.currentIndex=self.currentPage;
            [[header rac_signalForSelector:@selector(clickNavBtn1:)]subscribeNext:^(id x) {
                self.currentPage=0;
                [self.tableview reloadData];
            }];
            [[header rac_signalForSelector:@selector(clickNavBtn2:)]subscribeNext:^(id x) {
                self.currentPage=1;
                [self.tableview reloadData];
            }];
            return header;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        OtherCenterHeaderTableCell * cell =[tableView dequeueReusableCellWithIdentifier:@"otherCenterHeaderTableCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.block = ^(int type){
            if(type==0)
            {
                //点击关注/取消关注
                if([self.personalAboutMeInfo.isfollow isEqualToString:@"0"])
                {
                    //关注
                   
                }else
                {
                    //取消关注
                   
                }
                
            }else
            {
                //点击加好友/发消息
                if([self.personalAboutMeInfo.isfriend isEqualToString:@"0"])
                {
                    //加好友
                }else
                {
                    //发消息
                }
            }
            
        };
        cell.nameLab.text=self.personalDataInfo.username;
        cell.data=self.personalAboutMeInfo;
        return cell;
    }else
    {
        if(self.currentPage==1)
        {
            if(indexPath.section!=1)
            {
                NSDictionary * sections = self.layoutData[indexPath.section-2];
                NSString * key = sections.allKeys[0];
                NSArray * list = sections[key];
                MineMainDataModel * data=list[indexPath.row];
                
                MinePersonalSubTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"minePersonalSubTableViewCell"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.typeLab.text=data.leftTitle;
                if(data.centerTitle.length==0)
                {
                    cell.contentLab.text=@"-";
                }else
                {
                    cell.contentLab.text=data.centerTitle;
                }
                cell.arrowImg.hidden=!data.hasArrow;
                return cell;
            }else
            {
                return [[UITableViewCell alloc]init];
            }
            
        }else
        {
            CommunityTableViewCell_Newest * cell = [tableView dequeueReusableCellWithIdentifier:@"communityTableViewCell_Newest"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [self configCell:cell andIndexPath:indexPath];
            return cell;
        }
    }
}


#pragma mark - LazyLoad

-(NSMutableArray *)testList
{
    if(_testList==nil)
    {
        _testList=[NSMutableArray array];
        CommunityNewestData * data = [[CommunityNewestData alloc]init];
        data.title=@"sad撒大所大所大所大所大所大所大所多撒大所多sad撒大所大所大所大所大所大所大所多撒大所多sad撒大所大所大所大所大所大所大所多s大所多s大所多s大所多s大所多s大所多s大所多撒大所多";
        data.imgCount=5;
        [_testList addObject:data];
        
        CommunityNewestData * data2 = [[CommunityNewestData alloc]init];
        data2.title=@"s大所多";
        data2.imgCount=9;
        [_testList addObject:data2];
        
        CommunityNewestData * data3 = [[CommunityNewestData alloc]init];
        data3.title=@"s大所多s大所多ss大所多大所s大所多多";
        data3.imgCount=0;
        [_testList addObject:data3];
        
        CommunityNewestData * data4 = [[CommunityNewestData alloc]init];
        data4.title=@"ss大所多s大所多s大所多大所多";
        data4.imgCount=2;
        [_testList addObject:data4];
    }
    return _testList;
}


-(NSMutableArray *)layoutData
{
    if(_layoutData==nil)
    {
        _layoutData=[NSMutableArray array];
        
        MineMainDataModel * head=[[MineMainDataModel alloc]init];
        head.leftTitle=@"用户组";
        head.centerTitle=@"会员";
        head.hasArrow=NO;
        MineMainDataModel * head2=[[MineMainDataModel alloc]init];
        head2.leftTitle=@"经验值";
        head2.centerTitle=@"0";
        head2.hasArrow=NO;
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
        NSDictionary * dict6=[NSDictionary dictionaryWithObject:section6 forKey:@"自我介绍"];
        
        [_layoutData addObject:dict1];
        [_layoutData addObject:dict2];
        [_layoutData addObject:dict3];
        [_layoutData addObject:dict4];
        [_layoutData addObject:dict5];
        [_layoutData addObject:dict6];
        
    }
    return _layoutData;
}

-(void)completeLayoutData
{
    for (int i=0; i<self.layoutData.count; i++) {
        NSDictionary * dict=self.layoutData[i];
        NSString * key=dict.allKeys[0];
        NSArray * arr=dict[key];
        for (MineMainDataModel * data in arr) {
            if([data.leftTitle isEqualToString:@"自我介绍"])
            {
                data.centerTitle=self.personalDataInfo.bio;
            }else if([data.leftTitle isEqualToString:@"兴趣爱好"])
            {
                data.centerTitle=self.personalDataInfo.interest;
            }else if([data.leftTitle isEqualToString:@"用户组"])
            {
                data.centerTitle=self.personalAboutMeInfo.grouptitle;
            }else if([data.leftTitle isEqualToString:@"经验值"])
            {
                data.centerTitle=self.personalDataInfo.credits;
            }else if([data.leftTitle isEqualToString:@"性别"])
            {
                if([self.personalDataInfo.gender isEqualToString:@"1"])
                {
                    data.centerTitle=@"男";
                }else if([self.personalDataInfo.gender isEqualToString:@"2"])
                {
                    data.centerTitle=@"女";
                }else
                {
                    data.centerTitle=@"";
                }
            }else if([data.leftTitle isEqualToString:@"血型"])
            {
                data.centerTitle=self.personalDataInfo.bloodtype;
            }else if([data.leftTitle isEqualToString:@"情感状态"])
            {
                data.centerTitle=self.personalDataInfo.affectivestatus;
            }else if([data.leftTitle isEqualToString:@"生日"])
            {
                data.centerTitle=[NSString stringWithFormat:@"%@-%@-%@",self.personalDataInfo.birthyear,self.personalDataInfo.birthmonth,self.personalDataInfo.birthday];
            }else if([data.leftTitle isEqualToString:@"身高"])
            {
                data.centerTitle=self.personalDataInfo.height;
            }else if([data.leftTitle isEqualToString:@"体重"])
            {
                data.centerTitle=self.personalDataInfo.weight;
            }else if([data.leftTitle isEqualToString:@"行业"])
            {
                data.centerTitle=self.personalDataInfo.occupation;
            }else if([data.leftTitle isEqualToString:@"职业"])
            {
                data.centerTitle=self.personalDataInfo.position;
            }else if([data.leftTitle isEqualToString:@"年收入"])
            {
                data.centerTitle=@"";
            }else if([data.leftTitle isEqualToString:@"所在单位"])
            {
                data.centerTitle=self.personalDataInfo.company;
            }else if([data.leftTitle isEqualToString:@"交友目的"])
            {
                data.centerTitle=self.personalDataInfo.lookingfor;
            }else if([data.leftTitle isEqualToString:@"学历"])
            {
                data.centerTitle=self.personalDataInfo.education;
            }else if([data.leftTitle isEqualToString:@"QQ号"])
            {
                data.centerTitle=self.personalDataInfo.qq;
            }else if([data.leftTitle isEqualToString:@"真实姓名"])
            {
                data.centerTitle=self.personalDataInfo.realname;
            }else if([data.leftTitle isEqualToString:@"毕业院校"])
            {
                data.centerTitle=self.personalDataInfo.graduateschool;
            }
        }
        
    }
}

#pragma mark - 生命周期

-(void)addSubViews
{
    self.currentPage=0;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"MinePersonalSubTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"minePersonalSubTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"CommunityTableViewCell_Newest" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"communityTableViewCell_Newest"];
    [self.tableview registerNib:[UINib nibWithNibName:@"OtherCenterHeaderTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"otherCenterHeaderTableCell"];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight=250;
    self.tableview.rowHeight=UITableViewAutomaticDimension;
    
    
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.needNoNetTips=NO;
    self.needNoTableViewDataTips=NO;
    self.baseTableview=self.tableview;
    
}

-(void)getInitData
{
    [self getUserInfo];
    [self getUserDataWithMe];
}

#pragma mark - 网络访问

-(void)getUserInfo
{
    if(self.uid.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"缺少参数"];
        return;
    }
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSString * url=[NSString stringWithFormat:@"%@&fouid=%@",Interface_PersonalInfo,self.uid];
    [JSXHttpTool Post:url params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * errmsg = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.personalDataInfo=[PersonalDataInfo mj_objectWithKeyValues:json];
            self.title=[NSString stringWithFormat:@"%@的空间",self.personalDataInfo.username];
            [self completeLayoutData];
            [self.tableview reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:errmsg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    }];
}

-(void)getUserDataWithMe
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSString * url=[NSString stringWithFormat:@"%@&uid=%@&fouid=%@",Interface_PersonalInfo2,self.uid,[UserDataTools getUserInfo].uid];
    [JSXHttpTool Post:url params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * errmsg = json[@"errmsg"];
        NSDictionary * dict = json[@"list"];
        if([returnCode intValue]==0)
        {
            self.personalAboutMeInfo = [PersonalDataAboutMeInfo mj_objectWithKeyValues:dict];
            [self completeLayoutData];
            [self.tableview reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:errmsg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    }];
}

-(void)getUserPostsData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSString * url=[NSString stringWithFormat:@"%@&uid=%@&fouid=%@",Interface_PersonalInfo2,self.uid,[UserDataTools getUserInfo].uid];
    [JSXHttpTool Post:url params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * errmsg = json[@"errmsg"];
        NSDictionary * dict = json[@"list"];
        if([returnCode intValue]==0)
        {
            self.personalAboutMeInfo = [PersonalDataAboutMeInfo mj_objectWithKeyValues:dict];
            [self completeLayoutData];
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
