//
//  VideoLogTableViewCell_rec.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/11.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "VideoLogTableViewCell_rec.h"

@implementation VideoLogTableViewCell_rec

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.videobgImg.layer.cornerRadius=5;
    self.videobgImg.layer.masksToBounds=YES;
}


@end
