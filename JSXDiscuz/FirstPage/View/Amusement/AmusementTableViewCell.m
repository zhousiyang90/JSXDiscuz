//
//  AmusementTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "AmusementTableViewCell.h"

@implementation AmusementTableViewCell

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
