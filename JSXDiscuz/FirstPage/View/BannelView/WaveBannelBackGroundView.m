//
//  WaveBannelBackGroundView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/16.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "WaveBannelBackGroundView.h"

#define SplitPoint 30

@interface WaveBannelBackGroundView()
{
    float waverate;
    
    RACDisposable * disposable;
    
}
@property(nonatomic,strong) CAShapeLayer * shapeLayer;
@end

@implementation WaveBannelBackGroundView

-(instancetype)init
{
    if(self=[super init])
    {
        //初始化默认值
        self.speed=1;
        self.crestvalue=10;
        self.translateValue=0.0;
        self.waveRed=1.0;
        self.waveGreen=1.0;
        self.waveBlue=1.0;
        self.waveAlpha=1.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect: rect];
    if(waverate>=[UIScreen mainScreen].bounds.size.width)
    {
        waverate=0;
    }else{
        waverate+=self.speed;
    }
    
    [self drawWave];
}


#pragma mark - 绘制sin曲线

-(void)drawWave
{
    //1.获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.创建路径
    CGContextMoveToPoint(context, 0,self.center.y);
    for (int i=0; i<=SplitPoint; i++) {
        float x=[UIScreen mainScreen].bounds.size.width/SplitPoint*i;
        float y=self.crestvalue*sinf(M_PI*2*i/SplitPoint-waverate+self.translateValue)+self.center.y;
        CGContextAddLineToPoint(context,x,y);
    }

    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(self.frame));
    CGContextAddLineToPoint(context, 0, CGRectGetMaxY(self.frame));
    CGContextAddLineToPoint(context, 0, self.center.y);
    
    //3.设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context, self.waveRed,self.waveGreen,self.waveBlue,self.waveAlpha);//设置笔触颜色
    CGContextSetRGBFillColor(context, self.waveRed,self.waveGreen,self.waveBlue,self.waveAlpha);//设置填充色
    CGContextSetLineWidth(context, 1.0);//设置线条宽度
 
    //4.绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    

    //5.释放上下文资源
    //CGContextRelease(context);
}

-(void)drawWaveShape
{
    if(waverate==[UIScreen mainScreen].bounds.size.width)
    {
        waverate=0;
    }else{
        waverate+=self.speed;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,0,self.center.y);
    for (int i=0; i<=SplitPoint; i++) {
        float x=[UIScreen mainScreen].bounds.size.width/SplitPoint*i;
        float y=self.crestvalue*sinf(M_PI*2*i/SplitPoint-waverate)+self.center.y;
        CGPathAddLineToPoint(path,NULL,x,y);
    }
    CGPathAddLineToPoint(path, NULL, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(self.frame));
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetMaxY(self.frame));
    CGPathAddLineToPoint(path, NULL, 0, self.center.y);
    CGPathCloseSubpath(path);
    self.shapeLayer.path = path;
    CGPathRelease(path);
}

- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor colorWithRed:self.waveRed green:self.waveGreen blue:self.waveBlue alpha:self.waveAlpha].CGColor;
        [self.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}

-(void)startwave
{
    //RAC定时器-主线程绘制UI
    if(!disposable)
    {
     disposable=[[RACSignal interval:0.1 onScheduler:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
        [self setNeedsDisplay];
    }];
    }
}

-(void)stopwave
{
    if(disposable)
    {
        [disposable dispose];
        disposable=nil;
    }
    
}

@end
