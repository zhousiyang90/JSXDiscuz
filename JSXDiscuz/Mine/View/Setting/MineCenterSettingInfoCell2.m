//
//  MineCenterSettingInfoCell2.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterSettingInfoCell2.h"

@implementation MineCenterSettingInfoCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer * tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview1)];
    [self.bgview1 setUserInteractionEnabled:YES];
    [self.bgview1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview2)];
    [self.bgview2 setUserInteractionEnabled:YES];
    [self.bgview2 addGestureRecognizer:tap2];
}

-(void)clickbgview1
{
    if(_block)
    {
        _block(0);
    }
}

-(void)clickbgview2
{
    if(_block)
    {
        _block(1);
    }
}

@end
