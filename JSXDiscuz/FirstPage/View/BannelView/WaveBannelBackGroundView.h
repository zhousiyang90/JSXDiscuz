//
//  WaveBannelBackGroundView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/16.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveBannelBackGroundView : UIView
//速率
@property(nonatomic,assign) double speed;
//峰值
@property(nonatomic,assign) double crestvalue;
//平移位置
@property(nonatomic,assign) double translateValue;
//波形颜色RGBA
@property(nonatomic,assign) double waveRed;
@property(nonatomic,assign) double waveGreen;
@property(nonatomic,assign) double waveBlue;
@property(nonatomic,assign) double waveAlpha;

-(void)drawWaveShape;

//开始wave
-(void)startwave;

//停止wave
-(void)stopwave;

@end
