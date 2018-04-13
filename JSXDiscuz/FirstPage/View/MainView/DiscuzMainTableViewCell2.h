//
//  DiscuzMainTableViewCell2.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/16.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DiscuzMainTableViewCell2Block)(void);

@interface DiscuzMainTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *readNumLab;
@property (weak, nonatomic) IBOutlet UIButton *topicBtn;

@property(nonatomic,copy)DiscuzMainTableViewCell2Block block;
@end
