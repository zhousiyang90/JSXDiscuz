//
//  FriendTableViewCell_focus.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/5/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "FriendTableViewCell_focus.h"

@implementation FriendTableViewCell_focus

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(_block)
        {
            _block();
        }
    }];
}


@end
