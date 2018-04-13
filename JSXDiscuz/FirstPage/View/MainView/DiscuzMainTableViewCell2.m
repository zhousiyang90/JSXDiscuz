//
//  DiscuzMainTableViewCell2.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/16.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "DiscuzMainTableViewCell2.h"

@implementation DiscuzMainTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[self.topicBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(_block)
        {
           _block();
        }
    }];
    
}

@end
