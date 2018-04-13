//
//  LoginViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark - 保证LoginViewController单例
// 创建静态对象 防止外部访问
static LoginViewController *_instance;
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


+(instancetype)shareLoginViewController
{
    //return _instance;
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
}
// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.randomBtn.layer.cornerRadius=5;
    self.loginBtn.layer.cornerRadius=5;
    self.registerBtn.layer.cornerRadius=5;
    self.registerBtn.layer.borderWidth=1;
    self.registerBtn.layer.borderColor=ThemeColor.CGColor;
    if(IS_IPHONEX)
    {
        self.heightConstant.constant=88;
    }else
    {
        self.heightConstant.constant=64;
    }
    

    [[self.randomBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
    }];
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
    }];
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        RegisterViewController *vc=[RegisterViewController shareRegisterViewController];
        [self presentViewController:vc animated:YES completion:nil];
    }];

}

- (IBAction)clickClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
