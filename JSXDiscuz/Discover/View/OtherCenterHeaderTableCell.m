//
//  OtherCenterHeaderTableCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "OtherCenterHeaderTableCell.h"
#import "WaveBannelBackGroundView.h"

@interface OtherCenterHeaderTableCell()
{
    WaveBannelBackGroundView * wavev1;
    WaveBannelBackGroundView * wavev2;
    UIView * lineView;
    UIButton * addFriendBtn;
    UIImageView * headImageView;
    
}
@end

@implementation OtherCenterHeaderTableCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    wavev1=[[WaveBannelBackGroundView alloc]init];
    wavev1.frame=CGRectMake(0, 0, SDScreenWidth, self.waveView.bounds.size.height);
    wavev1.backgroundColor=[UIColor clearColor];
    wavev1.speed=0.2;
    [self.waveView addSubview:wavev1];
    [wavev1 startwave];
    
    wavev2=[[WaveBannelBackGroundView alloc]init];
    wavev2.frame=CGRectMake(0, 0, SDScreenWidth, self.waveView.bounds.size.height);
    wavev2.backgroundColor=[UIColor clearColor];
    wavev2.translateValue=SDScreenWidth/8;
    wavev2.waveAlpha=0.5;
    wavev2.speed=0.2;
    [self.waveView addSubview:wavev2];
    [wavev2 startwave];
    
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 140, 60, 60)];
    headImageView.layer.cornerRadius=30;
    headImageView.layer.borderWidth=1;
    headImageView.layer.masksToBounds=YES;
    headImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    headImageView.image=[UIImage imageNamed:@"timg"];
    [self.bgView addSubview:headImageView];
    
    self.focusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.focusBtn.frame=CGRectMake(SDScreenWidth-160, 200, 60, 25);
    self.focusBtn.backgroundColor=BGThemeColor;
    self.focusBtn.layer.borderWidth=1;
    self.focusBtn.layer.cornerRadius=5;
    self.focusBtn.layer.borderColor=SDColor(200, 200, 200).CGColor;
    [self.focusBtn setTitleColor:SDColor(93, 93, 93) forState:UIControlStateNormal];
    self.focusBtn.titleLabel.font=SDFontOf13;
    [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [[self.focusBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(_block)
        {
            _block(0);
        }
    }];
    [self.bgView addSubview:self.focusBtn];
    
    addFriendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    addFriendBtn.frame=CGRectMake(SDScreenWidth-90, 200, 80, 25);
    addFriendBtn.backgroundColor=BGThemeColor;
    addFriendBtn.layer.borderWidth=1;
    addFriendBtn.layer.cornerRadius=5;
    addFriendBtn.layer.borderColor=SDColor(200, 200, 200).CGColor;
    [addFriendBtn setTitleColor:SDColor(93, 93, 93) forState:UIControlStateNormal];
    addFriendBtn.titleLabel.font=SDFontOf13;
    [addFriendBtn setTitle:@"加好友" forState:UIControlStateNormal];
    [[addFriendBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(_block)
        {
            _block(1);
        }
    }];
    [self.bgView addSubview:addFriendBtn];
    
    self.statusLab.layer.cornerRadius=5;
    self.statusLab.layer.borderWidth=1;
    self.statusLab.layer.borderColor=ThemeColor.CGColor;
    
}

@end
