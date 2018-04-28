//
//  GroupMainData.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/19.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupMainData_summary.h"

@interface GroupMainData : NSObject

@property(nonatomic,strong) NSMutableArray * myforumlist;
@property(nonatomic,strong) NSMutableArray * forumlist;
@property(nonatomic,strong) NSMutableArray * alllist;
@property(nonatomic,strong) NSMutableArray * glist;
@property(nonatomic,strong) NSMutableArray * search;


//首页小组
@property(nonatomic,strong) NSMutableArray * catlist;

@end
