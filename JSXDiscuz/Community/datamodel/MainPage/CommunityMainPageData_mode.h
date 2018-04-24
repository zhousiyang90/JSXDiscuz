//
//  CommunityMainPageData_mode.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/18.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunityMainPageData_submode.h"

@interface CommunityMainPageData_mode : NSObject
@property(nonatomic,copy) NSString * fid;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * displayorder;
@property(nonatomic,strong) NSMutableArray * forumlist;
@end
