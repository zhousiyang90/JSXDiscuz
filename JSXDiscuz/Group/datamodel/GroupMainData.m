//
//  GroupMainData.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/19.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "GroupMainData.h"

@implementation GroupMainData

+(NSDictionary*)mj_objectClassInArray
{
    return @{@"myforumlist":GroupMainData_summary.class,
             @"forumlist":GroupMainData_summary.class,
             @"catlist":GroupMainData_summary.class,
             @"alllist":GroupMainData_summary.class,
             @"glist":GroupMainData_summary.class
             };
}

@end
