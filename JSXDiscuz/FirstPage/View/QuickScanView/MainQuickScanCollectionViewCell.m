//
//  MainQuickScanCollectionViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainQuickScanCollectionViewCell.h"

@implementation MainQuickScanCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgview.layer.cornerRadius=5;
    self.bgview.layer.borderWidth=1;
    self.bgview.layer.borderColor=SDColor(232, 232, 232).CGColor;
}

@end
