//
//  MineCenterHeaderTableCell2.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/4.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterHeaderTableCell2.h"
#import "WaveBannelBackGroundView.h"

@interface MineCenterHeaderTableCell2()
{
    WaveBannelBackGroundView * wavev1;
    WaveBannelBackGroundView * wavev2;
    UIView * lineView;
    UIButton * settingBtn;
    UIImageView * headImageView;
    
}
@end

@implementation MineCenterHeaderTableCell2

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
    
    settingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame=CGRectMake(SDScreenWidth-80, 200, 60, 25);
    settingBtn.backgroundColor=BGThemeColor;
    settingBtn.layer.borderWidth=1;
    settingBtn.layer.cornerRadius=5;
    settingBtn.layer.borderColor=SDColor(162, 162, 162).CGColor;
    [settingBtn setTitleColor:SDColor(93, 93, 93) forState:UIControlStateNormal];
    settingBtn.titleLabel.font=SDFontOf13;
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [[settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(_block)
        {
            _block();
        }
    }];
    [self.bgView addSubview:settingBtn];
    
    self.statusLab.layer.cornerRadius=5;
    self.statusLab.layer.borderWidth=1;
    self.statusLab.layer.borderColor=ThemeColor.CGColor;

}

-(void)clickSetting
{
    
}

@end
