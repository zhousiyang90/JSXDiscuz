//
//  MineCenterHeaderTableCell2.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/4.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineCenterHeaderTableCell2Block)(void);

@interface MineCenterHeaderTableCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *fansLab;
@property (weak, nonatomic) IBOutlet UIView *waveView;

@property(nonatomic,copy) MineCenterHeaderTableCell2Block block;

@end
