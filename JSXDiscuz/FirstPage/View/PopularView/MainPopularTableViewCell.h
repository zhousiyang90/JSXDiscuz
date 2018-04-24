//
//  MainPopularTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainPopularTableViewCellBlock)(void);

@interface MainPopularTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *popularImgv;
@property (weak, nonatomic) IBOutlet UILabel *readNumLab;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;

@property(nonatomic,copy) MainPopularTableViewCellBlock block;

@property(nonatomic,strong) PostBaseData * baseData;

@end
