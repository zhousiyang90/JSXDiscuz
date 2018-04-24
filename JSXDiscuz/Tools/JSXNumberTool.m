//
//  JSXNumberTool.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "JSXNumberTool.h"

#define NUMBERS @"0123456789\n"

@implementation JSXNumberTool

+(BOOL)isIntData:(NSString *)number
{
    NSCharacterSet * cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[number componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL res = [number isEqualToString:filtered];
    return res;
}

+(BOOL)isDoubleData:(NSString *)number
{
    NSScanner* scan = [NSScanner scannerWithString:number];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

+(BOOL)isValidIDCardNumber:(NSString *)number
{
    NSString * idCard = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",idCard];
    if ([regextestct evaluateWithObject:number] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)isValidPhoneNumber:(NSString *)phone
{
    if(phone.length==0)
    {
        return NO;
    }
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phone];
}

+(NSString*)getNearFourBeautifulNumber:(double)number
{
    
    /*0.数据源>=1000时
     
     源数据36323->最终数37000
     
     最终字符串=[前两位+1]+(数据位-2)个0
     
     数据源>100 && <1000时
     
     源数据363->最终数400
     
     最终字符串=[第一位+1]+(数据位-1)个0
     
     数据源<100
     
     源数据61->最终数80
     
     */
    NSMutableString * resultNumber=[NSMutableString string];
    //1.四舍五入小数
    NSString * originNumber = [NSString stringWithFormat:@"%.0f",round(number)];
    if(number<=100)
    {
        if(number<=20)
        {
            [resultNumber appendString:@"20"];
            
        }else if(number>20 && number<40)
        {
            [resultNumber appendString:@"40"];
            
        }else if(number>40 && number<60)
        {
            [resultNumber appendString:@"60"];
            
        }else if(number>60 && number<80)
        {
            [resultNumber appendString:@"80"];
            
        }else if(number>80 && number<100)
        {
            [resultNumber appendString:@"100"];
            
        }else
        {
            [resultNumber appendString:@"100"];
        }
        
    }else if(number>100 && number<1000)
    {
        //1.1 最终数
        NSString * tempStr = [originNumber substringToIndex:1];
        long  tempNumebr = [tempStr integerValue]+1;
        [resultNumber appendString:[NSString stringWithFormat:@"%ld",tempNumebr]];
        for (int i=0; i<originNumber.length-1; i++) {
            [resultNumber appendString:@"0"];
        };
        
    }else
    {
        //2.1 最终数
        NSString * tempStr = [originNumber substringToIndex:2];
        long  tempNumebr = [tempStr integerValue]+1;
        [resultNumber appendString:[NSString stringWithFormat:@"%ld",tempNumebr]];
        for (int i=0; i<originNumber.length-2; i++) {
            [resultNumber appendString:@"0"];
        };
    }
    return resultNumber;
}


@end
