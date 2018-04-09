//
//  MineCenterSettingInfoCell3.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineCenterSettingInfoCellBlock3)(int);

@interface MineCenterSettingInfoCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgview1;
@property (weak, nonatomic) IBOutlet UIView *bgview2;
@property (weak, nonatomic) IBOutlet UIView *bgview3;

@property (weak, nonatomic) IBOutlet UILabel *contentLab1;
@property (weak, nonatomic) IBOutlet UILabel *contentLab2;
@property (weak, nonatomic) IBOutlet UILabel *contentLab3;


@property (weak, nonatomic) IBOutlet UITextField *tfview1;

@property(nonatomic,copy) MineCenterSettingInfoCellBlock3 block;
@end
