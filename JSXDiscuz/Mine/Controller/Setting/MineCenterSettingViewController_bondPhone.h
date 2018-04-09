//
//  MineCenterSettingViewController_bondPhone.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface MineCenterSettingViewController_bondPhone : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *randomTf;
@property (weak, nonatomic) IBOutlet UIButton *randomBtn;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf;
- (IBAction)clickBond:(id)sender;

@end
