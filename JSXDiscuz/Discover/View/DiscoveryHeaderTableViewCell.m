//
//  DiscoveryHeaderTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "DiscoveryHeaderTableViewCell.h"

@implementation DiscoveryHeaderTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.searchview setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.searchview.returnKeyType=UIReturnKeySearch;
}


@end
