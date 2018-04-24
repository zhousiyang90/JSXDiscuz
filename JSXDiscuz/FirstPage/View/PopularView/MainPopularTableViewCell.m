//
//  MainPopularTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainPopularTableViewCell.h"

@implementation MainPopularTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userHeadImgV.layer.cornerRadius=12.5;
    self.userHeadImgV.layer.masksToBounds=YES;
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickuserImgV)];
    [self.userHeadImgV setUserInteractionEnabled:YES];
    [self.userHeadImgV addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickuserImgV)];
    [self.userNameLab setUserInteractionEnabled:YES];
    [self.userNameLab addGestureRecognizer:tap2];
}

-(void)clickuserImgV
{
    if(_block)
    {
        _block();
    }
}

-(void)setBaseData:(PostBaseData *)baseData
{
    _baseData=baseData;
    if(baseData.list.count>0)
    {
        PostBaseData_summary * data=baseData.list[0];
        self.titleNameLab.text=data.subject;
        if(data.pics.count>0)
        {
            NSString *picurl=data.pics[0];
            [self.popularImgv sd_setImageWithURL:[NSURL URLWithString:picurl] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Post]];
        }
        [self.userHeadImgV sd_setImageWithURL:[NSURL URLWithString:data.avatar] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Head]];
        self.userNameLab.text=data.author;
        self.readNumLab.text=[NSString stringWithFormat:@"阅读%@|评论%@",data.views,data.replies];
    }
}

@end
