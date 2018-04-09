//
//  MineCenterSettingViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface MineCenterSettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *barView;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

- (IBAction)clickBtn1:(id)sender;
- (IBAction)clickBtn2:(id)sender;
- (IBAction)clickBtn3:(id)sender;
- (IBAction)clickBtn4:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property(nonatomic,assign) NSInteger currentPage;

@end
