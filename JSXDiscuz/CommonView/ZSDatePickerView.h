//
//  ZSDatePickerView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZSDatePickerViewBlock)(NSString *date);

@interface ZSDatePickerView : UIView

@property(nonatomic,copy)ZSDatePickerViewBlock block;

-(instancetype)init;

@end
