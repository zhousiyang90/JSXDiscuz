//
//  DiscuzMainTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/16.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "DiscuzMainTableViewCell.h"

@implementation DiscuzMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV1.layer.borderColor=[UIColor whiteColor].CGColor;
    self.imgV1.layer.borderWidth=2;
    self.imgV2.layer.borderColor=[UIColor whiteColor].CGColor;
    self.imgV2.layer.borderWidth=2;
    self.imgV3.layer.borderColor=[UIColor whiteColor].CGColor;
    self.imgV3.layer.borderWidth=2;
    
    [[self.topicBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(_block)
        {
            _block();
        }
    }];
}

-(void)setBaseData:(PostBaseData_summary *)baseData
{
    _baseData=baseData;
    self.titleLab.text=baseData.subject;
    [self.topicBtn setTitle:baseData.forumname forState:UIControlStateNormal];
    self.readNumLab.text=[NSString stringWithFormat:@"阅读%@ - 评论%@ - 点赞%@",baseData.views,baseData.replies,baseData.likes];
    if(baseData.pics.count==2)
    {
        self.imgV1.hidden=NO;
        self.imgV2.hidden=NO;
        self.imgV3.hidden=YES;
        [self.imgV1 sd_setImageWithURL:[NSURL URLWithString:baseData.pics[0]] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Post]];
        [self.imgV2 sd_setImageWithURL:[NSURL URLWithString:baseData.pics[1]] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Post]];
    }else if(baseData.pics.count>2)
    {
        self.imgV1.hidden=NO;
        self.imgV2.hidden=NO;
        self.imgV3.hidden=NO;
        [self.imgV1 sd_setImageWithURL:[NSURL URLWithString:baseData.pics[0]] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Post]];
        [self.imgV2 sd_setImageWithURL:[NSURL URLWithString:baseData.pics[1]] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Post]];
        [self.imgV3 sd_setImageWithURL:[NSURL URLWithString:baseData.pics[2]] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Post]];
    }
}

@end
