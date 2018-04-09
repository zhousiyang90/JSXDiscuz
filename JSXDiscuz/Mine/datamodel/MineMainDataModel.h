//
//  MineMainDataModel.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineMainDataModel : NSObject

@property(nonatomic,copy) NSString * leftTitle;

@property(nonatomic,copy) NSString * centerTitle;

@property(nonatomic,copy) NSString * rightTitle;

@property(nonatomic,copy) NSString * name;

@property(nonatomic,copy) NSString * headImgUrl;

@property(nonatomic,assign) BOOL  hasArrow;

@property(nonatomic,assign) BOOL  allowable;

@end
