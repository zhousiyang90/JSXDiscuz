//
//  ZSDatePickerView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "ZSDatePickerView.h"

@interface ZSDatePickerView()
{
    UIView * bgview;
    UIDatePicker * pickerview;
}
@end

@implementation ZSDatePickerView

-(instancetype)init
{
    if(self=[super init])
    {
        bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SDScreenWidth, SDScreenHeight)];
        bgview.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.5];
        pickerview = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SDScreenHeight-200, SDScreenWidth, 200)];
        pickerview.backgroundColor=[UIColor whiteColor];
        pickerview.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        pickerview.maximumDate=[NSDate date];
        pickerview.datePickerMode = UIDatePickerModeDate;
        [bgview addSubview:pickerview];
        UIView * barView=[[UIView alloc]initWithFrame:CGRectMake(0, SDScreenHeight-240, SDScreenWidth, 40)];
        barView.backgroundColor=BGThemeColor;
        [bgview addSubview:barView];
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(SDScreenWidth-60, 0, 60, 40);
        [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        btn.titleLabel.font=SDFontOf15;
        [btn addTarget:self action:@selector(clickDone) forControlEvents:UIControlEventTouchUpInside];
        [barView addSubview:btn];
        [[UIApplication sharedApplication].keyWindow addSubview:bgview];
    }
    return self;
}

-(void)clickDone
{
    NSDate *date = pickerview.date;
    NSString * dateStr = [JSXDateTool returnYYYYMMDD:date];
    if(_block)
    {
        _block(dateStr);
    }
    [bgview removeFromSuperview];
    bgview=nil;
}



@end
