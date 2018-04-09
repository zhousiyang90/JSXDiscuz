//
//  MineCenterSettingInfoCell3.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterSettingInfoCell3.h"

@implementation MineCenterSettingInfoCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer * tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview1)];
    [self.bgview1 setUserInteractionEnabled:YES];
    [self.bgview1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview2)];
    [self.bgview2 setUserInteractionEnabled:YES];
    [self.bgview2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview3)];
    [self.bgview3 setUserInteractionEnabled:YES];
    [self.bgview3 addGestureRecognizer:tap3];
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
-(void)clickbgview3
{
    if(_block)
    {
        _block(2);
    }
}


@end
