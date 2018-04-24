//
//  JSXLocalTool.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/13.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "JSXLocalTool.h"

@interface JSXLocalTool()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation JSXLocalTool

 #pragma mark - 保证JSXLocalTool单例
 // 创建静态对象 防止外部访问
 static JSXLocalTool *_instance;
 +(instancetype)allocWithZone:(struct _NSZone *)zone
 {
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 if (_instance == nil) {
 _instance = [super allocWithZone:zone];
 }
 });
 return _instance;
 }
 // 为了使实例易于外界访问 我们一般提供一个类方法
 // 类方法命名规范 share类名|default类名|类名 
 
 // 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
 -(id)copyWithZone:(NSZone *)zone
 {
 return _instance;
 }
 -(id)mutableCopyWithZone:(NSZone *)zone
 {
 return _instance;
 }
 
+(instancetype)shareLocationTool
{
    return _instance;
}

-(void)getLocationOnce:(JSXLocalToolBlock)block
{
    self.block=block;
    [self startLocation];
}

//开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        SDLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        SDLog(@"无法获取位置信息");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if(locations.count>0)
    {
        CLLocation *newLocation = locations[0];
        if(_block)
        {
            _block(newLocation);
        }
    }
    [manager stopUpdatingLocation];
}


@end
