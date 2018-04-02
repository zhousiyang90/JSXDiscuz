//
//  DiscoveryContentTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "DiscoveryContentTableViewCell.h"

@implementation DiscoveryContentTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.view1 setUserInteractionEnabled:YES];
    [self.view2 setUserInteractionEnabled:YES];
    [self.view3 setUserInteractionEnabled:YES];
    [self.view4 setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview1)];
    [self.view1 addGestureRecognizer:tap1];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview2)];
    [self.view2 addGestureRecognizer:tap2];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview3)];
    [self.view3 addGestureRecognizer:tap3];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview4)];
    [self.view4 addGestureRecognizer:tap4];
}

-(void)clickview1
{
}
-(void)clickview2
{
}
-(void)clickview3
{
}
-(void)clickview4
{
}

@end
