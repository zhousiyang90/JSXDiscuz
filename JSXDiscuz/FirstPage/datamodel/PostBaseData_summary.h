//
//  PostBaseData_summary.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/19.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostBaseData_summary : NSObject

@property(nonatomic,copy) NSString * tem;
@property(nonatomic,copy) NSString * subject;
@property(nonatomic,copy) NSString * uid;
@property(nonatomic,copy) NSString * author;
@property(nonatomic,copy) NSString * views;
@property(nonatomic,copy) NSString * forumname;
@property(nonatomic,copy) NSString * avatar;
@property(nonatomic,copy) NSString * likes;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,copy) NSString * fid;
@property(nonatomic,copy) NSString * replies;
@property(nonatomic,copy) NSString * tid;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSMutableArray * pics;

@end
