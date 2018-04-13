//
//  DiscuzMainTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/16.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "DiscuzMainTableViewCell.h"

@implementation DiscuzMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV1.layer.borderColor=[UIColor whiteColor].CGColor;
    self.imgV1.layer.borderWidth=2;
    self.imgV2.layer.borderColor=[UIColor whiteColor].CGColor;
    self.imgV2.layer.borderWidth=2;
    self.imgV3.layer.borderColor=[UIColor whiteColor].CGColor;
    self.imgV3.layer.borderWidth=2;
    
    [[self.topicBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(_block)
        {
            _block();
        }
    }];
}

@end
