//
//  MineCenterViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface MineCenterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *fansLab;
@property (weak, nonatomic) IBOutlet UIView *waveView;
@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UIButton *navBtn1;
@property (weak, nonatomic) IBOutlet UIButton *navBtn2;
@property (weak, nonatomic) IBOutlet UIButton *navBtn3;
@property (weak, nonatomic) IBOutlet UIButton *navBtn4;

- (IBAction)clickNavBtn1:(id)sender;
- (IBAction)clickNavBtn2:(id)sender;
- (IBAction)clickNavBtn3:(id)sender;
- (IBAction)clickNavBtn4:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end
