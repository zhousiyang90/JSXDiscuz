//
//  LoginViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phonetf;
@property (weak, nonatomic) IBOutlet UITextField *randomtf;
@property (weak, nonatomic) IBOutlet UIButton *randomBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstant;

- (IBAction)clickClose:(id)sender;

+(instancetype)shareLoginViewController;

@end
