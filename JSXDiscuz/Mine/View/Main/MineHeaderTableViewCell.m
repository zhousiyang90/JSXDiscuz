//
//  MineHeaderTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineHeaderTableViewCell.h"

@implementation MineHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgeView.layer.cornerRadius=5;
    self.headImgeView.layer.masksToBounds=YES;
    [self.headImgeView setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHead)];
    [self.headImgeView addGestureRecognizer:tap];
}

-(void)clickHead
{
    if(_block)
    {
        _block(1);
    }
}

- (IBAction)clickSetting:(id)sender {
    if(_block)
    {
        _block(0);
    }
}
@end
