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
    self.headImgView.layer.cornerRadius=40;
    self.headImgView.layer.masksToBounds=YES;
}

-(void)setFriendData:(FriendDetailData *)friendData
{
    _friendData=friendData;
    self.nameLab.text=friendData.username;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:friendData.avatar] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Head]];
    self.rankLab.text=friendData.grouptitle;
}

@end
