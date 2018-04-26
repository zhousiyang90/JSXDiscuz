//
//  MineCenterSettingViewController_info.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterSettingViewController_info.h"
#import "MineTypeHeaderView.h"
#import "MineCenterSettingInfoCell.h"
#import "MineCenterSettingInfoCell2.h"
#import "MineCenterSettingInfoCell3.h"
#import "MineCenterSettingInfoCell4.h"
#import "MineCenterSettingInfoCell5.h"
#import "MineCommitCell.h"

@interface MineCenterSettingViewController_info ()<UITableViewDelegate,UITableViewDataSource>
{
    ZSPickerView * picker;
    ZSDatePickerView * datepicker;
    
    NSString * sexStr;
    NSString * bloodStr;
    NSString * emotionStr;
    NSString * dateStr;
    NSString * heightStr;
    NSString * weightStr;
    
    NSString * friendsStr;
    NSString * eduStr;
    NSString * qqStr;
    NSString * nameStr;
    NSString * schoolStr;
    
    NSString * professionStr;
    NSString * positionStr;
    NSString * incomeStr;
    NSString * companyStr;
    
    NSString * aboutmeStr;
    
}
//Picker数据源
@property(nonatomic,strong) NSMutableArray * sexArr;
@property(nonatomic,strong) NSMutableArray * bloodArr;
@property(nonatomic,strong) NSMutableArray * emotionArr;
@property(nonatomic,strong) NSMutableArray * friendsArr;
@property(nonatomic,strong) NSMutableArray * eduArr;
@property(nonatomic,strong) NSMutableArray * professionArr;
@property(nonatomic,strong) NSMutableArray * positionArr;
@property(nonatomic,strong) NSMutableArray * incomeArr;

@property(nonatomic,strong) NSMutableArray * layoutData;

@property(nonatomic,strong) NSMutableArray * interstedData;

@property(nonatomic,strong) PersonalDataInfo * personalDataInfo;

@end

@implementation MineCenterSettingViewController_info

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==5)
    {
        return 0.0;
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 300;
    }else if(indexPath.section==1)
    {
        return 250;
    }else if(indexPath.section==2)
    {
        return 200;
    }else if(indexPath.section==3)
    {
        return 700;
    }else if(indexPath.section==4)
    {
        return 100;
    }else if(indexPath.section==5)
    {
        return 60;
    }
    
    return 0.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MineTypeHeaderView * header=[MineTypeHeaderView shareView];
    NSString * title = self.layoutData[section];
    header.titleLab.text=title;
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        MineCenterSettingInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mineCenterSettingInfoCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(self.personalDataInfo.gender.length>0)
        {
            if([self.personalDataInfo.gender isEqualToString:@"0"])
            {
                cell.contentLab1.text=@"保密";
            }else if([self.personalDataInfo.gender isEqualToString:@"1"])
            {
                cell.contentLab1.text=@"男";
            }else
            {
                cell.contentLab1.text=@"女";
            }
        }
        if(self.personalDataInfo.bloodtype.length>0)
        {
            cell.contentLab2.text=self.personalDataInfo.bloodtype;
        }
        if(self.personalDataInfo.affectivestatus.length>0)
        {
            cell.contentLab3.text=self.personalDataInfo.affectivestatus;
        }
        if(self.personalDataInfo.birthyear.length>0)
        {
            cell.contentLab4.text=[NSString stringWithFormat:@"%@-%@-%@",self.personalDataInfo.birthyear,self.personalDataInfo.birthmonth,self.personalDataInfo.birthday];
        }
        
        if(self.personalDataInfo.height.length>0)
        {
            cell.tfview1.text=self.personalDataInfo.height;
        }
        
        if(self.personalDataInfo.weight.length>0)
        {
            cell.tfview2.text=self.personalDataInfo.weight;
        }
        
        cell.block = ^(int viewtype) {
          if(viewtype==0)
          {
              picker=[[ZSPickerView alloc]init];
              picker.originArray=self.sexArr;
              @weakify(self);
              picker.block = ^(NSInteger index) {
                  @strongify(self);
                  self.personalDataInfo.gender=[NSString stringWithFormat:@"%ld",index];
                  [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
              };
          }else if(viewtype==1)
          {
              picker=[[ZSPickerView alloc]init];
              picker.originArray=self.bloodArr;
              @weakify(self);
              picker.block = ^(NSInteger index) {
                  @strongify(self);
                  self.personalDataInfo.bloodtype=self.bloodArr[index];
                  [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
              };
          }else if(viewtype==2)
          {
              picker=[[ZSPickerView alloc]init];
              picker.originArray=self.emotionArr;
              @weakify(self);
              picker.block = ^(NSInteger index) {
                  @strongify(self);
                  self.personalDataInfo.affectivestatus=self.emotionArr[index];
                  [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
              };
          }else if(viewtype==3)
          {
              datepicker=[[ZSDatePickerView alloc]init];
              @weakify(self);
              datepicker.block = ^(NSString* date) {
                  @strongify(self);
                  NSArray * dateArr=[date componentsSeparatedByString:@"-"];
                  if(dateArr.count==3)
                  {
                      self.personalDataInfo.birthyear=dateArr[0];
                      self.personalDataInfo.birthmonth=dateArr[1];
                      self.personalDataInfo.birthday=dateArr[2];
                  }
                  [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
              };
          }
        };
        [[cell.tfview1 rac_textSignal]subscribeNext:^(id x) {
            self.personalDataInfo.height=x;
        }];
        
        [[cell.tfview2 rac_textSignal]subscribeNext:^(id x) {
            self.personalDataInfo.weight=x;
        }];
        return cell;
    }else if(indexPath.section==1)
    {
        MineCenterSettingInfoCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"mineCenterSettingInfoCell2"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(self.personalDataInfo.lookingfor.length>0)
        {
            cell.contentLab1.text=self.personalDataInfo.lookingfor;
        }
        if(self.personalDataInfo.education.length>0)
        {
            cell.contentLab2.text=self.personalDataInfo.education;
        }
        if(self.personalDataInfo.qq.length>0)
        {
            cell.tfview1.text=self.personalDataInfo.qq;
        }
        if(self.personalDataInfo.realname.length>0)
        {
            cell.tfview2.text=self.personalDataInfo.realname;
        }
        if(self.personalDataInfo.graduateschool.length>0)
        {
            cell.tfview3.text=self.personalDataInfo.graduateschool;
        }
        
        cell.block = ^(int viewtype) {
            if(viewtype==0)
            {
                picker=[[ZSPickerView alloc]init];
                picker.originArray=self.friendsArr;
                @weakify(self);
                picker.block = ^(NSInteger index) {
                    @strongify(self);
                    self.personalDataInfo.lookingfor=self.friendsArr[index];
                    [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                };
            }else if(viewtype==1)
            {
                picker=[[ZSPickerView alloc]init];
                picker.originArray=self.eduArr;
                @weakify(self);
                picker.block = ^(NSInteger index) {
                    @strongify(self);
                    self.personalDataInfo.education=self.eduArr[index];
                    [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                };
            }
        };
        [[cell.tfview1 rac_textSignal]subscribeNext:^(id x) {
            self.personalDataInfo.qq=x;
        }];
        [[cell.tfview2 rac_textSignal]subscribeNext:^(id x) {
            self.personalDataInfo.realname=x;
        }];
        [[cell.tfview3 rac_textSignal]subscribeNext:^(id x) {
            self.personalDataInfo.graduateschool=x;
        }];
        return cell;
    }else if(indexPath.section==2)
    {
        MineCenterSettingInfoCell3 * cell = [tableView dequeueReusableCellWithIdentifier:@"mineCenterSettingInfoCell3"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(self.personalDataInfo.occupation.length>0)
        {
            cell.contentLab1.text=self.personalDataInfo.occupation;
        }
        if(self.personalDataInfo.position.length>0)
        {
            cell.contentLab2.text=self.personalDataInfo.position;
        }
        if(incomeStr.length>0)
        {
            cell.contentLab3.text=incomeStr;
        }
        if(self.personalDataInfo.company.length>0)
        {
            cell.tfview1.text=self.personalDataInfo.company;
        }
 
        cell.block = ^(int viewtype) {
            if(viewtype==0)
            {
                picker=[[ZSPickerView alloc]init];
                picker.originArray=self.professionArr;
                @weakify(self);
                picker.block = ^(NSInteger index) {
                    @strongify(self);
                    self.personalDataInfo.occupation=self.professionArr[index];
                    [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                };
            }else if(viewtype==1)
            {
                picker=[[ZSPickerView alloc]init];
                picker.originArray=self.positionArr;
                @weakify(self);
                picker.block = ^(NSInteger index) {
                    @strongify(self);
                    self.personalDataInfo.position=self.positionArr[index];
                    [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                };

            }else if(viewtype==2)
            {
                picker=[[ZSPickerView alloc]init];
                picker.originArray=self.incomeArr;
                @weakify(self);
                picker.block = ^(NSInteger index) {
                    @strongify(self);
                    incomeStr=self.incomeArr[index];
                    [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                };

            }
        };
        [[cell.tfview1 rac_textSignal]subscribeNext:^(id x) {
            self.personalDataInfo.company=x;
        }];
        return cell;
    }else if(indexPath.section==3)
    {
        MineCenterSettingInfoCell4 * cell = [tableView dequeueReusableCellWithIdentifier:@"mineCenterSettingInfoCell4"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.intrestStr=self.personalDataInfo.interest;
        //cell.insData=self.interstedData;
        [cell.insBtn1 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn2 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn3 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn4 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn5 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn6 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn7 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn8 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn9 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn10 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn11 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn12 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn13 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.insBtn14 addTarget:self action:@selector(changeInterstedData:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if(indexPath.section==4)
    {
        MineCenterSettingInfoCell5 * cell = [tableView dequeueReusableCellWithIdentifier:@"mineCenterSettingInfoCell5"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(self.personalDataInfo.bio.length>0)
        {
            cell.tfview.text=self.personalDataInfo.bio;
        }
        [[cell.tfview rac_textSignal]subscribeNext:^(id x) {
            self.personalDataInfo.bio=x;
        }];
        return cell;
    }else if(indexPath.section==5)
    {
        MineCommitCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mineCommitCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.block = ^{
            [self commitInfo];
        };
        return cell;
    }
    
    return nil;
}


#pragma mark - LazyLoad

-(NSMutableArray *)sexArr
{
    if(_sexArr==nil)
    {
        _sexArr=[NSMutableArray arrayWithObjects:@"保密",@"男",@"女",nil];
    }
    return _sexArr;
}

-(NSMutableArray *)bloodArr
{
    if(_bloodArr==nil)
    {
        _bloodArr=[NSMutableArray arrayWithObjects:@"不知道",@"A",@"B",@"AB",@"O",nil];
    }
    return _bloodArr;
}

-(NSMutableArray *)emotionArr
{
    if(_emotionArr==nil)
    {
        _emotionArr=[NSMutableArray arrayWithObjects:@"保密",@"单身",@"已婚",@"离异",@"丧偶", nil];
    }
    return _emotionArr;
}

-(NSMutableArray *)friendsArr
{
    if(_friendsArr==nil)
    {
        _friendsArr=[NSMutableArray arrayWithObjects:@"兴趣交友",@"谈恋爱",@"结婚对象",@"其他",nil];
    }
    return _friendsArr;
}

-(NSMutableArray *)eduArr
{
    if(_eduArr==nil)
    {
        _eduArr=[NSMutableArray arrayWithObjects:@"保密",@"小学",@"中学",@"专科",@"本科",@"硕士",@"博士",nil];
    }
    return _eduArr;
}

-(NSMutableArray *)professionArr
{
    if(_professionArr==nil)
    {
        _professionArr=[NSMutableArray arrayWithObjects:@"保密",@"服务",@"IT",@"金融",@"汽车",@"房产",@"教育",@"艺术",@"零售",@"公务员", nil];
    }
    return _professionArr;
}

-(NSMutableArray *)positionArr
{
    if(_positionArr==nil)
    {
        _positionArr=[NSMutableArray arrayWithObjects:@"保密",@"员工",@"骨干",@"管理岗位",@"负责人",nil];
    }
    return _positionArr;
}

-(NSMutableArray *)incomeArr
{
    if(_incomeArr==nil)
    {
        _incomeArr=[NSMutableArray arrayWithObjects:@"保密",@"5万以下",@"5-10万",@"10-30万",@"50-100万",@"100万以上", nil];
    }
    return _incomeArr;
}

-(NSMutableArray *)layoutData
{
    if(_layoutData==nil)
    {
        _layoutData=[NSMutableArray arrayWithObjects:@"基本信息",@"其他信息",@"工作信息",@"兴趣爱好",@"自我介绍",@"",nil];
        
    }
    return _layoutData;
}

-(NSMutableArray *)interstedData
{
    if(_interstedData==nil)
    {
        _interstedData=[NSMutableArray arrayWithCapacity:14];
        for (int i=0; i<14; i++) {
            [_interstedData addObject:@"0"];
        }
    } 
    return _interstedData;
}


-(void)changeInterstedData:(UIButton*)button
{
    NSInteger btntag=button.tag;
    NSString * data = self.interstedData[btntag-1];
    if([data isEqualToString:@"0"])
    {
        [self.interstedData replaceObjectAtIndex:btntag-1 withObject:@"1"];
        
    }else
    {
        [self.interstedData replaceObjectAtIndex:btntag-1 withObject:@"0"];
    }
    
    [self.tableview reloadSections:[NSMutableIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
}



#pragma mark - 生命周期

-(void)addSubViews
{

    [self.tableview registerNib:[UINib nibWithNibName:@"MineCenterSettingInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineCenterSettingInfoCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MineCenterSettingInfoCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineCenterSettingInfoCell2"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MineCenterSettingInfoCell3" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineCenterSettingInfoCell3"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MineCenterSettingInfoCell4" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineCenterSettingInfoCell4"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MineCenterSettingInfoCell5" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineCenterSettingInfoCell5"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MineCommitCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mineCommitCell"];
    
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.needNoNetTips=NO;
    self.needNoTableViewDataTips=NO;
    self.baseTableview=self.tableview;
}

-(void)getInitData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSString * url=[NSString stringWithFormat:@"%@&fouid=%@",Interface_PersonalInfo,[UserDataTools getUserInfo].uid];
    [JSXHttpTool Post:url params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * errmsg = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.personalDataInfo=[PersonalDataInfo mj_objectWithKeyValues:json];
            [self.tableview reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:errmsg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    }];
}

#pragma mark - 网络访问

-(void)commitInfo
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    //params[@"fouid"]=[UserDataTools getUserInfo].uid;
    params[@"gender"]=self.personalDataInfo.gender;
    params[@"bloodtype"]=self.personalDataInfo.bloodtype;
    params[@"affectivestatus"]=self.personalDataInfo.affectivestatus;
    params[@"birthyear"]=self.personalDataInfo.birthyear;
    params[@"birthmonth"]=self.personalDataInfo.birthmonth;
    params[@"birthday"]=self.personalDataInfo.birthday;
    params[@"height"]=self.personalDataInfo.height;
    params[@"weight"]=self.personalDataInfo.weight;
    params[@"lookingfor"]=self.personalDataInfo.lookingfor;
    params[@"education"]=self.personalDataInfo.education;
    params[@"qq"]=self.personalDataInfo.qq;
    params[@"realname"]=self.personalDataInfo.realname;
    params[@"graduateschool"]=self.personalDataInfo.graduateschool;
    params[@"occupation"]=self.personalDataInfo.occupation;
    params[@"company"]=self.personalDataInfo.company;
    params[@"position"]=self.personalDataInfo.position;
    params[@"bio"]=self.personalDataInfo.bio;
    params[@"interest"]=self.personalDataInfo.interest;
    
    NSString * url=[NSString stringWithFormat:@"%@&fouid=%@",Interface_PersonalInfoCommit,[UserDataTools getUserInfo].uid];
    [JSXHttpTool Post:url params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        if([returnCode intValue]==0)
        {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            self.personalDataInfo=[PersonalDataInfo mj_objectWithKeyValues:json];
            [self.tableview reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    }];
}

@end
