//
//  MineHeaderTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineHeaderTableViewCellBlock)(int);

@interface MineHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *headImgeView;
- (IBAction)clickSetting:(id)sender;

@property(nonatomic,copy) MineHeaderTableViewCellBlock block;

@end
