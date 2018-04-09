//
//  MineCenterSettingViewController_pwd.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface MineCenterSettingViewController_pwd : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *oldpwdTf;

@property (weak, nonatomic) IBOutlet UITextField *newpwdTf;

@property (weak, nonatomic) IBOutlet UITextField *confirmpwdTf;

- (IBAction)clickCommit:(id)sender;

@end
