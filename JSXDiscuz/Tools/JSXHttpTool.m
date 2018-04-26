//
//  JSXHttpTool.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "JSXHttpTool.h"

@implementation JSXHttpTool

/*
 利用NSURLSession发送Post异步请求
 */

+(void)Post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    SDLog(@"Post请求:%@ 参数:%@",url,params);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SDLog(@"成功:%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SDLog(@"失败:%@",error.description);
        if (failure) {
            failure(error);
        }
    }];
    
    /*
    SDLog(@"请求:%@-%@",url,params);
    NSURL * requrl = [NSURL URLWithString:url];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:requrl];
    [request setHTTPMethod:@"POST"];
    //设置超时时间
    [request setTimeoutInterval:20];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    NSData * jsondata = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:jsondata];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error)
        {
            id resData= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //这样使用打印的JSON字段无引号
            //id  resData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            SDLog(@"成功:%@",resData);
            //修改HTTP请求工具类，主线程Block回调
            dispatch_async(dispatch_get_main_queue(), ^{
                success(resData);
            });
        }else
        {
            SDLog(@"失败:%@",error.description);
            //修改HTTP请求工具类，主线程Block回调
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
    [dataTask resume];
     */
}

/*
 利用NSURLSession发送GET异步请求
 */

+(void)Get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    SDLog(@"Get请求:%@ 参数:%@",url,params);
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置超时时间
    manager.requestSerializer.timeoutInterval = 10.0;
    // 设置响应内容的类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SDLog(@"成功:%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SDLog(@"失败:%@",error.description);
        if (failure) {
            failure(error);
        }
    }];

    /*
    SDLog(@"请求:%@-%@",url,params);
    NSURL * requrl = [NSURL URLWithString:url];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:requrl];
    //设置超时时间
    [request setTimeoutInterval:15];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    NSData * jsondata = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:jsondata];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id  resData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if(!error)
        {
            SDLog(@"成功:%@",resData);
            success(resData);
        }else
        {
            SDLog(@"失败:%@",error.description);
            failure(error);
        }
    }];
    [dataTask resume];
     */
}

/*
 利用NSURLConnection实现Post同步请求
 */

+(void)syPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    SDLog(@"请求:%@-%@",url,params);
    NSURL * requrl = [NSURL URLWithString:url];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:requrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    NSData * jsondata = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:jsondata];
    NSURLResponse *repsonse = nil;
    NSError *error;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&repsonse error:&error];
    if(error==nil)
    {
        id result=[NSJSONSerialization
                   JSONObjectWithData:received
                   options:NSJSONReadingMutableLeaves
                   error:nil];
        SDLog(@"成功:%@",result);
        success(result);
    }else
    {
        SDLog(@"失败:%@",error.description);
        failure(error);
    }
}
/*
 利用NSURLConnection实现Get同步请求
 */
+(void)syGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    SDLog(@"请求:%@-%@",url,params);
    //第一步，构建URL
    NSMutableString * urlParams=[NSMutableString string];
    for(int i=0;i<params.allKeys.count;i++)
    {
        NSString * key = [params.allKeys objectAtIndex:i];
        NSString * value = params[key];
        [urlParams appendString:[NSString stringWithFormat:@"&%@=%@",key,value]];
    }
    NSURL * requrl=[[NSURL alloc] initWithString:[[NSString stringWithFormat:@"%@%@",url,urlParams] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:requrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //第三步，连接服务器
    NSError * error;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if(error==nil)
    {
        id result=[NSJSONSerialization
                   JSONObjectWithData:received
                   options:NSJSONReadingMutableLeaves
                   error:nil];
        SDLog(@"成功:%@",result);
        success(result);
    }else
    {
        SDLog(@"失败:%@",error.description);
        failure(error);
    }
}

/*
 利用AFN上传图片
 */

+(void)upLoadImageofAFN:(NSString *)url params:(NSDictionary *)params img:(NSDictionary *)imgDict success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    SDLog(@"请求:%@-%@-%@",url,params,imgDict);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //2.上传文件
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //上传文件参数
        if(imgDict.allKeys.count>0)
        {
            [imgDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [formData appendPartWithFileData:obj name:key fileName:key mimeType:@"image/jpeg"];
            }];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        SDLog(@"上传进度:%.2lf%%", progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        SDLog(@"请求成功:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        SDLog(@"请求失败:%@",error);
        
    }];
    
}


+ (void)upLoadOnePic:(NSString *)url params:(NSDictionary *)params img:(NSDictionary*)imgDict andCompress:(float)comress success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    if(imgDict.allKeys.count>0)
    {
        SDLog(@"请求:%@-%@",url,params);
        NSString * key=imgDict.allKeys[0];
        UIImage * img=imgDict[key];
        NSData *imageData =UIImageJPEGRepresentation(img,comress);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:Interface_UploadHeadImg parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:key fileName:[NSString stringWithFormat:@"%@.jpeg",key] mimeType:@"image/jpeg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            SDLog(@"成功:%@",dictionary);
            if(success) {
                success(dictionary);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            SDLog(@"失败:%@",error);
            if(failure) {
                failure(error);
            }
        }];
    }else
    {
        SDLog(@"图片数据为空!");
    }
}

//检测网络连接状态

+(BOOL)isConnectionAvailable{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    return isExistenceNetwork;
}


@end
