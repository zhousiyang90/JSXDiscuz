//
//  CommunityPostsData.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/18.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityPostsData.h"

@implementation CommunityPostsData

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"tem":@"template"};
}

+(NSDictionary*)mj_objectClassInArray
{
    return @{@"pics":[NSString class]};
}

@end
