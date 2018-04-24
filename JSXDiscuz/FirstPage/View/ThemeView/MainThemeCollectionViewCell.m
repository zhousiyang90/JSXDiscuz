//
//  MainThemeCollectionViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainThemeCollectionViewCell.h"

@implementation MainThemeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius=25;
    self.imgV.layer.masksToBounds=YES;
}



@end
