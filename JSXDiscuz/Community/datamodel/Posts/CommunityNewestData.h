//
//  CommunityNewestData.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunityPostsData.h"

@interface CommunityNewestData : NSObject

@property(nonatomic,strong) NSMutableArray * list;
@property(nonatomic,copy) NSString * total;

@property(nonatomic,copy) NSString * title;
@property(nonatomic,assign) int imgCount;

@end
