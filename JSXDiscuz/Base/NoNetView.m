//
//  NoNetView.m
//  SOM
//
//  Created by 周思扬 on 2017/6/8.
//  Copyright © 2017年 liang. All rights reserved.
//

#import "NoNetView.h"

@implementation NoNetView

+(instancetype)getView
{
    NoNetView * view =  (NoNetView*)[[[NSBundle mainBundle]loadNibNamed:@"NoNetView" owner:self options:nil]lastObject];
    view.refresh.layer.cornerRadius=15;
    view.refresh.layer.borderColor=SDColor(150, 150, 150).CGColor;
    view.refresh.layer.borderWidth=1;
    view.refresh.layer.masksToBounds=YES;
    return view;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(nonetstatusGetData)])
    {
        [_delegate nonetstatusGetData];
    }
}

@end
