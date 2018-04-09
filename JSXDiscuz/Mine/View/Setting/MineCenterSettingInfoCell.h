//
//  MineCenterSettingInfoCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineCenterSettingInfoCellBlock)(int);

@interface MineCenterSettingInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgview1;
@property (weak, nonatomic) IBOutlet UIView *bgview2;
@property (weak, nonatomic) IBOutlet UIView *bgview3;
@property (weak, nonatomic) IBOutlet UIView *bgview4;

@property (weak, nonatomic) IBOutlet UILabel *contentLab1;
@property (weak, nonatomic) IBOutlet UILabel *contentLab2;
@property (weak, nonatomic) IBOutlet UILabel *contentLab3;
@property (weak, nonatomic) IBOutlet UILabel *contentLab4;

@property (weak, nonatomic) IBOutlet UITextField *tfview1;
@property (weak, nonatomic) IBOutlet UITextField *tfview2;

@property(nonatomic,copy) MineCenterSettingInfoCellBlock block;
@end
