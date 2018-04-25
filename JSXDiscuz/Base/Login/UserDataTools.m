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
    WZLSERIALIZE_ARCHIVE(userdata, @"userdata",[[self createCacheDirection]stringByAppendingPathComponent:@"user.data"]);
}

+(UserData *)getUserInfo
{
    UserData *userData = nil;
    WZLSERIALIZE_UNARCHIVE(userData,@"userdata",[[self createCacheDirection]stringByAppendingPathComponent:@"user.data"]);
    return userData;
}

+(void)clearUserInfo
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError * error;
    NSString * userPath=[[self createCacheDirection]stringByAppendingPathComponent:@"user.data"];
    if([fileManager fileExistsAtPath:userPath])
    {
        [fileManager removeItemAtPath:userPath error:&error];
        if(error==nil)
        {
            //SDLog(@"user删除成功");
        }
    }else
    {
        //SDLog(@"user文件不存在");
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:Notification_Logout object:nil];
}

+(NSString *)createCacheDirection
{
    //Document 文件夹目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathDocuments = [paths objectAtIndex:0];
    //创建缓存目录
    NSString *createPath = [pathDocuments stringByAppendingPathComponent:@"UserData"];
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
        //SDLog(@"文件夹存在:%@",createPath);
        return createPath;
    }
}

@end
