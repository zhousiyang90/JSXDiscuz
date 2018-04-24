//
//  CommunityMainPageData.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/18.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunityMainPageData_mode.h"
#import "CommunityMainPageData_public.h"

@interface CommunityMainPageData : NSObject

@property(nonatomic,strong) NSMutableArray * catlist;
@property(nonatomic,strong) CommunityMainPageData_public * gonggao;

@end
