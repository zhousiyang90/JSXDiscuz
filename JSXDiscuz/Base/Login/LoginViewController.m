//
//  LoginViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

#define SumCount 60

@interface LoginViewController ()
{
    BOOL hasSend;
    RACDisposable * racdis;
    
    NSString * randomPhone;
}
@property(nonatomic,strong) UserData *user;

@end

@implementation LoginViewController

/*
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



// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}
*/

+(instancetype)shareLoginViewController
{
    //return _instance;
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
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
    
    [[self.phonetf rac_textSignal]subscribeNext:^(id x) {
        
    }];

    [[self.randomBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        randomPhone=self.phonetf.text;
        if([JSXNumberTool isValidPhoneNumber:randomPhone])
        {
            [self getRandomCode];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"手机号不合法"];
        }
    }];
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(![randomPhone isEqualToString:self.phonetf.text])
        {
            [SVProgressHUD showErrorWithStatus:@"手机号改变！"];
            return;
        }
        if(![JSXNumberTool isValidPhoneNumber:self.phonetf.text])
        {
            [SVProgressHUD showErrorWithStatus:@"手机号不合理！"];
            return;
        }
        
         [self loginInterface];
        
        
    }];
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        RegisterViewController *vc=[RegisterViewController shareRegisterViewController];
        //注册成功回调
        vc.block = ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:vc animated:YES completion:nil];
    }];

}

- (IBAction)clickClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - LazyLoad

-(UserData *)user
{
    if(_user==nil)
    {
        _user=[[UserData alloc]init];
    }
    return _user;
}

#pragma mark - 获取验证码

-(void)getRandomCode
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"mod"]=@"spacecp1";
    params[@"ac"]=@"bindtel";
    params[@"fouid"]=@"1";
    params[@"doup"]=@"logincode";
    params[@"tel"]=randomPhone;
    [JSXHttpTool Get:Interface_GetRandomCode params:params success:^(id json) {
        NSString * returnCode = json[@"code"];
        NSString * message = json[@"msg"];
        if([returnCode isEqualToString:@"1"])
        {
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            self.randomBtn.enabled=NO;
            __block int count=SumCount;
            racdis=[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
                count--;
                NSString * text =[NSString stringWithFormat:@"%d s",count];
                [self.randomBtn setTitle:text forState:UIControlStateNormal];
                if(count==0)
                {
                    self.randomBtn.enabled=YES;
                    [self.randomBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    [racdis dispose];
                }
                
            }];
        }else
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
    }];
}

#pragma mark - 登录

-(void)loginInterface
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"mod"]=@"spacecp1";
    params[@"ac"]=@"bindtel";
    params[@"fouid"]=@"1";
    params[@"doup"]=@"phonelogin";
    params[@"tel"]=self.phonetf.text;
    params[@"verifycode"]=self.randomtf.text;
    [JSXHttpTool Get:Interface_Login params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * errmsg = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            UserData * userData=[UserData mj_objectWithKeyValues:json];
            [UserDataTools saveUserInfo:userData];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else
        {
            [SVProgressHUD showErrorWithStatus:errmsg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
    }];
}


@end
