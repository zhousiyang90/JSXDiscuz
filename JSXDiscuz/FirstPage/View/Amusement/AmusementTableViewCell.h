//
//  AmusementTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AmusementTableViewCellBlock)(void);

@interface AmusementTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *topicBtn;

@property(nonatomic,copy) AmusementTableViewCellBlock block;

@end
