//
//  NearByPersonTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "NearByPersonTableViewCell.h"

@implementation NearByPersonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.rankLab.layer.borderColor=ThemeColor.CGColor;
    self.rankLab.layer.borderWidth=1;
    self.rankLab.layer.cornerRadius=5;
}

@end
