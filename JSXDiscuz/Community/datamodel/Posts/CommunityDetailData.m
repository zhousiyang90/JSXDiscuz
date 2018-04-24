//
//  CommunityDetailData.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/24.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityDetailData.h"

@implementation CommunityDetailData

+(NSDictionary*)mj_objectClassInArray
{
    return @{
             @"list":[CommunityPostsData class],
             @"rlist":[CommunityPostsData class]
             };
}

@end
