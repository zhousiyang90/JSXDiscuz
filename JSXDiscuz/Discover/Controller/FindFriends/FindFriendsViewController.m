//
//  FindFriendsViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "FindFriendsViewController.h"
#import "NearByPersonViewController.h"

@interface FindFriendsViewController ()
{
    ZSPickerView * picker;
    
    NSString * username;
    NSString * sexStr;
    NSString * emotionStr;
    NSString * friendsStr;
    NSString * eduStr;
    NSString * incomeStr;
    NSString * ageStr;
}
//Picker数据源
@property(nonatomic,strong) NSMutableArray * sexArr;
@property(nonatomic,strong) NSMutableArray * emotionArr;
@property(nonatomic,strong) NSMutableArray * friendsArr;
@property(nonatomic,strong) NSMutableArray * eduArr;
@property(nonatomic,strong) NSMutableArray * incomeArr;
@property(nonatomic,strong) NSMutableArray * ageArr;
@end

@implementation FindFriendsViewController

#pragma mark - 生命周期

-(void)addSubViews
{
    self.searchBtn.layer.cornerRadius=5;
    self.findnearyBtn.layer.cornerRadius=5;
    self.findnearyBtn.layer.borderWidth=1;
    self.findnearyBtn.layer.borderColor=ThemeColor.CGColor;
    
    UITapGestureRecognizer * tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview1)];
    [self.bgview1 setUserInteractionEnabled:YES];
    [self.bgview1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview2)];
    [self.bgview2 setUserInteractionEnabled:YES];
    [self.bgview2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview3)];
    [self.bgview3 setUserInteractionEnabled:YES];
    [self.bgview3 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer * tap4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview4)];
    [self.bgview4 setUserInteractionEnabled:YES];
    [self.bgview4 addGestureRecognizer:tap4];
    
    UITapGestureRecognizer * tap5=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview5)];
    [self.bgview5 setUserInteractionEnabled:YES];
    [self.bgview5 addGestureRecognizer:tap5];
    
    UITapGestureRecognizer * tap6=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview6)];
    [self.bgview6 setUserInteractionEnabled:YES];
    [self.bgview6 addGestureRecognizer:tap6];
    
    [[self.searchtf rac_textSignal]subscribeNext:^(id x) {
        username=x;
    }];
    
    [[self.searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self.view endEditing:YES];
        
        //搜索
        NearByPersonViewController * vc=[[NearByPersonViewController alloc]init];
        vc.navTitle=@"找朋友";
        vc.username=username;
        vc.gender=sexStr;
        vc.affectivestatus=emotionStr;
        vc.lookingfor=friendsStr;
        vc.education=eduStr;
        vc.revenue=incomeStr;
        vc.age=ageStr;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[self.findnearyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        //查找附近的人
        NearByPersonViewController * vc=[[NearByPersonViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];

}

-(void)setNavigationBar
{
    self.title=@"找朋友";
}

-(void)clickview1
{
    picker=[[ZSPickerView alloc]init];
    picker.originArray=self.sexArr;
    @weakify(self);
    picker.block = ^(NSInteger index) {
        @strongify(self);
        if(index==0)
        {
            sexStr=@"";
        }else
        {
            sexStr=[NSString stringWithFormat:@"%ld",(long)index];
        }
        self.lab1.text=self.sexArr[index];
    };
}

-(void)clickview2
{
    picker=[[ZSPickerView alloc]init];
    picker.originArray=self.emotionArr;
    @weakify(self);
    picker.block = ^(NSInteger index) {
        @strongify(self);
        if(index==0)
        {
            emotionStr=@"";
        }else
        {
            emotionStr=[NSString stringWithFormat:@"%ld",(long)index];
        }
        self.lab2.text=self.emotionArr[index];
    };
}

-(void)clickview3
{
    picker=[[ZSPickerView alloc]init];
    picker.originArray=self.friendsArr;
    @weakify(self);
    picker.block = ^(NSInteger index) {
        @strongify(self);
        if(index==0)
        {
            friendsStr=@"";
        }else
        {
            friendsStr=[NSString stringWithFormat:@"%ld",(long)index];
        }
        self.lab3.text=self.friendsArr[index];
    };
}

-(void)clickview4
{
    picker=[[ZSPickerView alloc]init];
    picker.originArray=self.eduArr;
    @weakify(self);
    picker.block = ^(NSInteger index) {
        @strongify(self);
        if(index==0)
        {
            eduStr=@"";
        }else
        {
            eduStr=[NSString stringWithFormat:@"%ld",(long)index];
        }
        self.lab4.text=self.eduArr[index];
    };
}

-(void)clickview5
{
    picker=[[ZSPickerView alloc]init];
    picker.originArray=self.incomeArr;
    @weakify(self);
    picker.block = ^(NSInteger index) {
        @strongify(self);
        if(index==0)
        {
            incomeStr=@"";
        }else
        {
            incomeStr=[NSString stringWithFormat:@"%ld",(long)index];
        }
        self.lab5.text=self.incomeArr[index];
    };
}

-(void)clickview6
{
    picker=[[ZSPickerView alloc]init];
    picker.originArray=self.ageArr;
    @weakify(self);
    picker.block = ^(NSInteger index) {
        @strongify(self);
        if(index==0)
        {
            ageStr=@"";
        }else
        {
            ageStr=[NSString stringWithFormat:@"%ld",(long)index];
        }
        self.lab6.text=self.ageArr[index];
    };
}

#pragma mark - LazyLoad

-(NSMutableArray *)sexArr
{
    if(_sexArr==nil)
    {
        _sexArr=[NSMutableArray arrayWithObjects:@"不限",@"男",@"女",nil];
    }
    return _sexArr;
}

-(NSMutableArray *)emotionArr
{
    if(_emotionArr==nil)
    {
        _emotionArr=[NSMutableArray arrayWithObjects:@"不限",@"单身",@"已婚",@"离异",@"丧偶", nil];
    }
    return _emotionArr;
}

-(NSMutableArray *)friendsArr
{
    if(_friendsArr==nil)
    {
        _friendsArr=[NSMutableArray arrayWithObjects:@"不限",@"谈恋爱",@"结婚对象",@"其他",nil];
    }
    return _friendsArr;
}

-(NSMutableArray *)eduArr
{
    if(_eduArr==nil)
    {
        _eduArr=[NSMutableArray arrayWithObjects:@"不限",@"小学",@"中学",@"专科",@"本科",@"硕士",@"博士",nil];
    }
    return _eduArr;
}


-(NSMutableArray *)incomeArr
{
    if(_incomeArr==nil)
    {
        _incomeArr=[NSMutableArray arrayWithObjects:@"不限",@"5万以下",@"5-10万",@"10-30万",@"50-100万",@"100万以上", nil];
    }
    return _incomeArr;
}

-(NSMutableArray *)ageArr
{
    if(_ageArr==nil)
    {
        _ageArr=[NSMutableArray arrayWithObjects:@"不限",@"20岁以下",@"20-30岁",@"30-40岁",@"40-50岁",@"50岁以上", nil];
    }
    return _ageArr;
}


@end
