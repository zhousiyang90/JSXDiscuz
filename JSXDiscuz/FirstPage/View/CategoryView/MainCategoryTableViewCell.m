//
//  MainCategoryTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainCategoryTableViewCell.h"

@implementation MainCategoryTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.view1 setUserInteractionEnabled:YES];
    [self.view2 setUserInteractionEnabled:YES];
    [self.view3 setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView1)];
    [self.view1 addGestureRecognizer:tap1];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView2)];
    [self.view2 addGestureRecognizer:tap2];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView3)];
    [self.view3 addGestureRecognizer:tap3];
}

-(void)clickView1
{
    if(_block)
    {
        _block(0);
    }
}

-(void)clickView2
{
    if(_block)
    {
        _block(1);
    }
}

-(void)clickView3
{
    if(_block)
    {
        _block(2);
    }
}

@end
