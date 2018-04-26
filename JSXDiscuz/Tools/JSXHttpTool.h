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

#pragma mark 上传一张图片

+ (void)upLoadOnePic:(NSString *)url params:(NSDictionary *)params img:(NSDictionary*)imgDict andCompress:(float)comress success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

#pragma mark 下载文件

#pragma mark 检测网络状态

+(BOOL)isConnectionAvailable;


@end
