//
//  MineLogoutTableView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineLogoutTableView.h"

@implementation MineLogoutTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickLogout:(id)sender {
    if(_block)
    {
        _block();
    }
}
@end
