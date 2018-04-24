//
//  DiscuzMainTableViewCell2.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/16.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "DiscuzMainTableViewCell2.h"

@implementation DiscuzMainTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
    if(baseData.pics.count==1)
    {
        self.imgV.hidden=NO;
        [self.imgV sd_setImageWithURL:[NSURL URLWithString:baseData.pics[0]] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Post]];
    }else
    {
        self.imgV.hidden=YES;
    }
}

@end
