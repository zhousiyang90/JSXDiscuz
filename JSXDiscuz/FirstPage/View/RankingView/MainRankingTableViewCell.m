//
//  MainRankingTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/28.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainRankingTableViewCell.h"

@implementation MainRankingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.themeBtn1.layer.cornerRadius=5;
    self.themeBtn1.layer.borderWidth=1;
    self.themeBtn1.layer.borderColor=ThemeColor.CGColor;
    
    self.themeBtn2.layer.cornerRadius=5;
    self.themeBtn2.layer.borderWidth=1;
    self.themeBtn2.layer.borderColor=ThemeColor.CGColor;
    
    self.themeBtn3.layer.cornerRadius=5;
    self.themeBtn3.layer.borderWidth=1;
    self.themeBtn3.layer.borderColor=ThemeColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickTheme1:(id)sender {
}

- (IBAction)clickTheme2:(id)sender {
}

- (IBAction)clickTheme3:(id)sender {
}
@end
