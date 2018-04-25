//
//  UserDataTools.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/13.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

@interface UserDataTools : NSObject

+(void)saveUserInfo:(UserData*)userdata;

+(UserData*)getUserInfo;

+(void)clearUserInfo;

@end
