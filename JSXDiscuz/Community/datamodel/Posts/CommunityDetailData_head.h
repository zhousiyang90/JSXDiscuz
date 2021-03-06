//
//  CommunityDetailData_head.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/24.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityDetailData_head : NSObject

@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * des;
@property(nonatomic,copy) NSString * fid;
@property(nonatomic,copy) NSString * posts;
@property(nonatomic,copy) NSString * membernum;
@property(nonatomic,copy) NSString * icon;
@property(nonatomic,copy) NSString * icon1;
@property(nonatomic,copy) NSString * icon2;
//成员等级 (0:未加入 1:群主)
@property(nonatomic,copy) NSString * showg;
@property(nonatomic,copy) NSString * focus;
//成员等级 (0:待审核 1:群主 2:副群主 3:明星成员 4:普通成员)
@property(nonatomic,copy) NSString * usess;

@end
