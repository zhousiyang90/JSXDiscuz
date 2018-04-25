//
//  MainRankingTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/28.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainRankingTableViewCell.h"

@implementation MainRankingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.themeBtn1.layer.cornerRadius=5;
    self.themeBtn1.layer.borderWidth=1;
    self.themeBtn1.layer.borderColor=ThemeColor.CGColor;
    
    self.themeBtn2.layer.cornerRadius=5;
    self.themeBtn2.layer.borderWidth=1;
    self.themeBtn2.layer.borderColor=ThemeColor.CGColor;
    
    self.themeBtn3.layer.cornerRadius=5;
    self.themeBtn3.layer.borderWidth=1;
    self.themeBtn3.layer.borderColor=ThemeColor.CGColor;
    
    [self.bg1 setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBg1)];
    [self.bg1 addGestureRecognizer:tap1];
    
    [self.bg2 setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBg2)];
    [self.bg2 addGestureRecognizer:tap2];
    
    [self.bg3 setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBg3)];
    [self.bg3 addGestureRecognizer:tap3];
}

-(void)setBaseData:(PostBaseData *)baseData
{
    _baseData=baseData;
    if(baseData.list.count>0)
    {
        PostBaseData_summary *data=baseData.list[0];
        self.titleLab1.text=data.subject;
        [self.themeBtn1 setTitle:[NSString stringWithFormat:@" %@ ",data.forumname] forState:UIControlStateNormal];
        self.timeLab1.text=data.time;
    }
    if(baseData.list.count>1)
    {
        PostBaseData_summary *data=baseData.list[1];
        self.titleLab2.text=data.subject;
        [self.themeBtn2 setTitle:[NSString stringWithFormat:@" %@ ",data.forumname] forState:UIControlStateNormal];
        self.timeLab2.text=data.time;
    }
    if(baseData.list.count>2)
    {
        PostBaseData_summary *data=baseData.list[2];
        self.titleLab3.text=data.subject;
        [self.themeBtn3 setTitle:[NSString stringWithFormat:@" %@ ",data.forumname] forState:UIControlStateNormal];
        self.timeLab3.text=data.time;
    }
}

- (IBAction)clickTheme1:(id)sender {
    if(_clickblock)
    {
        _clickblock(0);
    }
}

- (IBAction)clickTheme2:(id)sender {
    if(_clickblock)
    {
        _clickblock(1);
    }
}

- (IBAction)clickTheme3:(id)sender {
    if(_clickblock)
    {
        _clickblock(2);
    }
}

-(void)clickBg1
{
    if(_block)
    {
        _block(0);
    }
}
-(void)clickBg2
{
    if(_block)
    {
        _block(1);
    }
}
-(void)clickBg3
{
    if(_block)
    {
        _block(2);
    }
}
@end
