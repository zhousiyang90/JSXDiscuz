//
//  ZSPickerView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "ZSPickerView.h"

@interface ZSPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView * bgview;
    UIPickerView * pickerview;
}
@end

@implementation ZSPickerView

-(instancetype)init
{
    if(self=[super init])
    {
        bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SDScreenWidth, SDScreenHeight)];
        bgview.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.5];
        pickerview = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SDScreenHeight-200, SDScreenWidth, 200)];
        pickerview.backgroundColor=[UIColor whiteColor];
        pickerview.dataSource=self;
        pickerview.delegate=self;
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.originArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = self.originArray[row];
    return title;
}

-(void)clickDone
{
    NSInteger seletedRow = [pickerview selectedRowInComponent:0];
    if(_block)
    {
        _block(seletedRow);
    }
    [bgview removeFromSuperview];
    bgview=nil;
}


-(void)setOriginArray:(NSMutableArray *)originArray
{
    _originArray=originArray;
    [pickerview reloadAllComponents];
}

@end
