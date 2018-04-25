//
//  UserData.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/13.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject<NSCoding,NSCopying>

@property(nonatomic,copy) NSString * auth;
@property(nonatomic,copy) NSString * avatar;
@property(nonatomic,copy) NSString * credits;
@property(nonatomic,copy) NSString * grouptitle;
@property(nonatomic,copy) NSString * uid;
@property(nonatomic,copy) NSString * username;

@end
