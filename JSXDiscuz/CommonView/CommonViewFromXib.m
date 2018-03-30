//
//  CommonViewFromXib.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommonViewFromXib.h"

@implementation CommonViewFromXib

+(instancetype)shareView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
}

@end
