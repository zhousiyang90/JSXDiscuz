//
//  TopicListTableViewCell_content.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "TopicListTableViewCell_content.h"

@implementation TopicListTableViewCell_content

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topicImgV.layer.cornerRadius=5;
    self.topicImgV.layer.masksToBounds=YES;
}

-(void)setGroupData:(GroupMainData_summary *)groupData
{
    _groupData=groupData;
    [self.topicImgV sd_setImageWithURL:[NSURL URLWithString:groupData.icon] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Group]];
    self.topicName.text=groupData.name;
    self.topicDesc.text=groupData.desc;
}

@end
