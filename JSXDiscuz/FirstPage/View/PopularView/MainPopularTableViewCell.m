//
//  MainPopularTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainPopularTableViewCell.h"

@implementation MainPopularTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickuserImgV)];
    [self.userHeadImgV setUserInteractionEnabled:YES];
    [self.userHeadImgV addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickuserImgV)];
    [self.userNameLab setUserInteractionEnabled:YES];
    [self.userNameLab addGestureRecognizer:tap2];
}

-(void)clickuserImgV
{
    if(_block)
    {
        _block();
    }
}

@end
