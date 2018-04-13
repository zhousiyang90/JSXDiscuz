//
//  DiscuzMainTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/16.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DiscuzMainTableViewCellBlock)(void);

@interface DiscuzMainTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UILabel *readNumLab;
@property (weak, nonatomic) IBOutlet UIButton *topicBtn;

@property(nonatomic,copy) DiscuzMainTableViewCellBlock block;

@end
