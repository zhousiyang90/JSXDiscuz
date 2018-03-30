//
//  JSXNumberTool.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSXNumberTool : NSObject

#pragma mark 判断是不是整型数据

+(BOOL)isIntData:(NSString*)number;

#pragma mark 判断是不是浮点型数据

+(BOOL)isDoubleData:(NSString*)number;

#pragma mark 判断是不是身份证号

+(BOOL)isValidIDCardNumber:(NSString*)number;

#pragma mark 获取最近被4整除的好看数字

+(NSString*)getNearFourBeautifulNumber:(double)number;

@end
