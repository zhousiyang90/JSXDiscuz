//
//  MainThemeCollectionViewCell2.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/28.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainThemeCollectionViewCell2.h"

@implementation MainThemeCollectionViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius=25;
    self.imgV.layer.masksToBounds=YES;
}

@end
