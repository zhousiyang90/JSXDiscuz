//
//  OtherCenterHeaderTableCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OtherCenterHeaderTableCellBlock)(int);

@interface OtherCenterHeaderTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *fansLab;
@property (weak, nonatomic) IBOutlet UIView *waveView;
@property (weak, nonatomic)  UIButton *friendBtn;
@property (weak, nonatomic)  UIImageView *headImgView;

@property(nonatomic,copy) OtherCenterHeaderTableCellBlock block;

@property(nonatomic,strong) UIButton * focusBtn;

@property(nonatomic,strong) PersonalDataAboutMeInfo * data;

@end
