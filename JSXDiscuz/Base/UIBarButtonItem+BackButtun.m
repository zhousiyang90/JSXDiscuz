//
//  UIBarButtonItem+BackButtun.m
//  KiloCalorie
//
//  Created by 亮 on 16/1/27.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "UIBarButtonItem+BackButtun.h"

@implementation UIBarButtonItem (BackButtun)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 4, 30, 36);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
