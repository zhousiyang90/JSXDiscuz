//
//  CommunityDetailData.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/24.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunityDetailData_head.h"
#import "CommunityPostsData.h"

@interface CommunityDetailData : NSObject

@property(nonatomic,strong) CommunityDetailData_head * forum;
@property(nonatomic,strong) NSMutableArray * list;
@property(nonatomic,strong) NSMutableArray * rlist;

@end
