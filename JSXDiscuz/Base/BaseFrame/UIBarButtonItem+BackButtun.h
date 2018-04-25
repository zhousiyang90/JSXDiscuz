//
//  UIBarButtonItem+BackButtun.h
//  KiloCalorie
//
//  Created by 亮 on 16/1/27.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BackButtun)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title;


@end
