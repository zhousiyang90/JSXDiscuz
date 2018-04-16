//
//  UserDataTools.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/13.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "UserDataTools.h"

@implementation UserDataTools

+(void)saveUserInfo:(UserData *)userdata
{
    EGOCache *egocache = [[EGOCache globalCache] initWithCacheDirectory:[self createCacheDirection]];
    egocache.defaultTimeoutInterval=60*60*24*30;
    [egocache setString:userdata.userPhone forKey:@"userdata_phone"];
}

+(UserData *)getUserInfo
{
    EGOCache *egocache = [[EGOCache globalCache] initWithCacheDirectory:[self createCacheDirection]];
    NSString * userPhone = [egocache stringForKey:@"userdata_phone"];
    UserData * userData =[[UserData alloc]init];
    userData.userPhone=userPhone;
    return userData;
}

+(void)clearUserInfo
{
    EGOCache *egocache = [[EGOCache globalCache] initWithCacheDirectory:[self createCacheDirection]];
    [egocache clearCache];
    [[NSNotificationCenter defaultCenter]postNotificationName:Notification_Logout object:nil];
}

+(NSString *)createCacheDirection
{
    //Document 文件夹目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathDocuments = [paths objectAtIndex:0];
    //创建缓存目录
    NSString *createPath = [NSString stringWithFormat:@"%@/UserData", pathDocuments];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        BOOL result = [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (result) {
            return createPath;
        }else
        {
            return nil;
        }
    } else {
        SDLog(@"FileDir is exists.");
        return createPath;
    }
}

@end
