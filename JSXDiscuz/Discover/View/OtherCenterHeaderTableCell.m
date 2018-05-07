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
    headImageView.image=[UIImage imageNamed:PlaceHolderImg_Head];
    [self.bgView addSubview:headImageView];
    self.headImgView=headImageView;
    
    self.focusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //self.focusBtn.frame=CGRectMake(SDScreenWidth-160, 200, 60, 25);
    self.focusBtn.backgroundColor=BGThemeColor;
    self.focusBtn.layer.borderWidth=1;
    self.focusBtn.layer.cornerRadius=5;
    self.focusBtn.layer.borderColor=SDColor(200, 200, 200).CGColor;
    [self.focusBtn setTitleColor:SDColor(93, 93, 93) forState:UIControlStateNormal];
    self.focusBtn.titleLabel.font=SDFontOf13;
    [self.focusBtn setTitle:@"  关注  " forState:UIControlStateNormal];
    [[self.focusBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(_block)
        {
            _block(0);
        }
    }];
    [self.bgView addSubview:self.focusBtn];
    
    addFriendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    addFriendBtn.frame=CGRectMake(SDScreenWidth-90, 200, 70, 25);
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
    self.friendBtn=addFriendBtn;
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addFriendBtn.mas_top);
        make.height.mas_equalTo(addFriendBtn.mas_height);
        make.right.mas_equalTo(addFriendBtn.mas_left).offset(-10);
    }];
    
    self.statusLab.layer.cornerRadius=5;
    self.statusLab.layer.borderWidth=1;
    self.statusLab.layer.borderColor=ThemeColor.CGColor;
    
}


-(void)setData:(PersonalDataAboutMeInfo *)data
{
    _data=data;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:data.headimg] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Head]];
    self.fansLab.text=[NSString stringWithFormat:@"%@关注 %@粉丝",data.follownum,data.bfollownum];
    self.statusLab.text=data.grouptitle;
    if([data.isfriend isEqualToString:@"0"])
    {
        [self.friendBtn setTitle:@"加好友" forState:UIControlStateNormal];
        [self.friendBtn setTitleColor:SDColor(93, 93, 93) forState:UIControlStateNormal];
        self.friendBtn.backgroundColor=BGThemeColor;
        self.friendBtn.layer.borderColor=SDColor(200, 200, 200).CGColor;
    }else
    {
        [self.friendBtn setTitle:@"发消息" forState:UIControlStateNormal];
        [self.friendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.friendBtn.backgroundColor=ThemeColor;
        self.friendBtn.layer.borderColor=ThemeColor.CGColor;
        
    }
    
    if([data.isfollow isEqualToString:@"0"])
    {
        [self.focusBtn setTitle:@"  关注  " forState:UIControlStateNormal];
    }else
    {
        [self.focusBtn setTitle:@"  取消关注  " forState:UIControlStateNormal];
    }
    
}

@end
