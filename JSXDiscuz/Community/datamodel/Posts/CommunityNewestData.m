//
//  CommunityNewestData.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityNewestData.h"

@implementation CommunityNewestData

+(NSDictionary*)mj_objectClassInArray
{
    return @{@"list":[CommunityPostsData class]};
}

@end
