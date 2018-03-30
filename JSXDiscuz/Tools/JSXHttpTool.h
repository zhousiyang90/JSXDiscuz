//
//  JSXHttpTool.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSXHttpTool : NSObject

#pragma mark Post异步请求

+ (void)Post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

#pragma mark Get异步请求

+ (void)Get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

#pragma mark Post同步请求

+ (void)syPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

#pragma mark Get同步请求

+ (void)syGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

#pragma mark 上传文件

+ (void)upLoadImageofAFN:(NSString *)url params:(NSDictionary *)params img:(NSDictionary*)imgDict success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

#pragma mark 上传图片

+ (void)upLoadImage:(NSString *)url params:(NSDictionary *)params img:(NSDictionary*)imgDict success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

#pragma mark 断点续传图片

+ (void)upLoadBreakPointImage:(NSString *)paramsurl params:(NSDictionary *)params imgurl:(NSString*)imgurl img:(NSDictionary*)imgDict imgparams:(NSDictionary*)imgParams success:(void (^)(id json))bothsuccess onesuccess:(void (^)(id json))paramsuccess failure:(void (^)(NSError *error))bothfailure;

#pragma mark 下载文件

#pragma mark 检测网络状态

+(BOOL)isConnectionAvailable;


@end
