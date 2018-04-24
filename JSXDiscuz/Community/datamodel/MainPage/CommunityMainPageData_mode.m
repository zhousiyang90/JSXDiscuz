//
//  CommunityMainPageData_mode.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/18.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityMainPageData_mode.h"

@implementation CommunityMainPageData_mode

+(NSDictionary*)mj_objectClassInArray
{
    return @{@"forumlist" : [CommunityMainPageData_submode class]};
}

@end
