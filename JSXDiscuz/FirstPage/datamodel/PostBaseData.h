//
//  PostBaseData.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/19.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostBaseData_summary.h"

@interface PostBaseData : NSObject

@property(nonatomic,copy) NSString *order;
@property(nonatomic,strong) NSMutableArray *list;

@end
