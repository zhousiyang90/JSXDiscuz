//
//  MineCenterSettingInfoCell2.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineCenterSettingInfoCellBlock2)(int);

@interface MineCenterSettingInfoCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgview1;
@property (weak, nonatomic) IBOutlet UIView *bgview2;

@property (weak, nonatomic) IBOutlet UILabel *contentLab1;
@property (weak, nonatomic) IBOutlet UILabel *contentLab2;


@property (weak, nonatomic) IBOutlet UITextField *tfview1;
@property (weak, nonatomic) IBOutlet UITextField *tfview2;
@property (weak, nonatomic) IBOutlet UITextField *tfview3;

@property(nonatomic,copy) MineCenterSettingInfoCellBlock2 block;

@end
