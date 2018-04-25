//
//  RegisterViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RegisterViewControllerBlock)(void);

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phonetf;
@property (weak, nonatomic) IBOutlet UITextField *randomtf;
@property (weak, nonatomic) IBOutlet UIButton *randomBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreeboxBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *useragreeonBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstant;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic,copy) RegisterViewControllerBlock block;

- (IBAction)clickClose:(id)sender;

+(instancetype)shareRegisterViewController;

@end
