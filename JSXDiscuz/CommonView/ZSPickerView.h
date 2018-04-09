//
//  ZSPickerView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZSPickerViewBlock)(NSInteger index);

@interface ZSPickerView : UIView

@property(nonatomic,strong)NSMutableArray * originArray;

@property(nonatomic,copy)ZSPickerViewBlock block;

-(instancetype)init;

@end
