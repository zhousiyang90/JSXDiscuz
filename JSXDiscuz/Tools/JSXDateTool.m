//
//  JSXDateTool.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "JSXDateTool.h"

@implementation JSXDateTool

+(NSString*)returnYYYYMMDD_line:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    return [dateFormatter stringFromDate:date];
}


+(NSDate *)returnDateFromString:(NSString *)dateStr
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    NSDate *date=[formatter dateFromString:dateStr];
    
    //时区转换，取得系统时区，取得格林威治时间差秒
    
    NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
    
    date = [date dateByAddingTimeInterval:timeZoneOffset];
    
    return date;
    
}

+(NSString *)returnDD:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"dd"];
    
    return [dateFormatter stringFromDate:date];
}

+(NSString *)returnMM:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"MM"];
    
    return [dateFormatter stringFromDate:date];
}

+(NSString *)returnYY:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yy"];
    
    return [dateFormatter stringFromDate:date];
}

+(NSString *)returnYYYY:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy"];
    
    return [dateFormatter stringFromDate:date];
}


+(NSString *)returnYYMMDD:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    
    return [dateFormatter stringFromDate:date];
}

+(NSString *)returnYYYYMMDD:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:date];
}


+(NSString *)returnYYYYMMDDHHmmss:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:date];
}


+(NSString *)returnYYYYMMDD:(NSDate *)date andPreMon:(int)num
{
    NSTimeInterval currentTime = [date timeIntervalSince1970];
    
    NSTimeInterval preTime = currentTime-num*30*24*60*60;
    
    NSDate * predate = [NSDate dateWithTimeIntervalSince1970:preTime];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:predate];
}

+(NSString *)returnYYMMDD:(NSDate *)date andPreMon:(int)num
{
    NSTimeInterval currentTime = [date timeIntervalSince1970];
    
    NSTimeInterval preTime = currentTime-num*30*24*60*60;
    
    NSDate * predate = [NSDate dateWithTimeIntervalSince1970:preTime];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    
    return [dateFormatter stringFromDate:predate];
}


+(NSString *)returnYYYYMMDDToday
{
    return [self returnYYYYMMDD:[NSDate date]];
}

+(NSString *)returnYYYYMMDDWeek
{
    
    NSDate *startDateOfWeek;
    
    NSTimeInterval TIOfWeek;
    
    [[NSCalendar currentCalendar] rangeOfUnit:NSWeekCalendarUnit startDate:&startDateOfWeek interval:&TIOfWeek forDate:[NSDate date]];
    
    return [self returnYYYYMMDD:[startDateOfWeek dateByAddingTimeInterval:24*60*60]];
}

+(NSString *)returnYYYYMMDDMonth
{
    
    NSDate *startDateOfMonth;
    
    NSTimeInterval TIOfMonth;
    
    [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDateOfMonth interval:&TIOfMonth forDate:[NSDate date]];
    
    return [self returnYYYYMMDD:startDateOfMonth];
}


+(NSString *)returnYYYYMMDDYear
{
    NSDate *startDateOfYear;
    
    NSTimeInterval TIOfYear;
    
    [[NSCalendar currentCalendar] rangeOfUnit:NSYearCalendarUnit startDate:&startDateOfYear interval:&TIOfYear forDate:[NSDate date]];
    
    return [self returnYYYYMMDD:startDateOfYear];
}

+(BOOL)oneIsGreaterThanTwo:(NSDate *)one andTwo:(NSDate *)two
{
    if([one timeIntervalSince1970]>[two timeIntervalSince1970])
    {
        return YES;
    }
    
    return NO;
}


+(NSDateComponents*)getCurrentComponent:(NSString *)dateStr
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date = [dateFormatter dateFromString:dateStr];
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [cal components:unitFlags fromDate:date];
    
    return comps;
}

+(NSString *)getBetterTime:(NSDate *)date
{
    NSCalendar * currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [currentCalendar components:unitFlags fromDate:[NSDate date]];
    
    NSCalendar * currentCalendar2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps2 = [currentCalendar2 components:unitFlags fromDate:date];
    
    if(comps.year==comps2.year && comps.month==comps2.month)
    {
        return @"本月";
        
    }else if(comps.year==comps2.year && comps.month!=comps2.month)
    {
        return [NSString stringWithFormat:@"%ld月",comps2.month];
        
    }else
    {
        return [NSString stringWithFormat:@"%ld-%ld",comps2.year,comps2.month];
    }
    
}

+(NSString *)getBetterTimeFromNSDateComponents:(NSDateComponents *)component
{
    NSCalendar * currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [currentCalendar components:unitFlags fromDate:[NSDate date]];
    
    
    if(comps.year==component.year && comps.month==component.month)
    {
        return @"本月";
        
    }else if(comps.year==component.year && comps.month!=component.month)
    {
        return [NSString stringWithFormat:@"%ld月",component.month];
        
    }else
    {
        return [NSString stringWithFormat:@"%ld-%ld",component.year,component.month];
    }
}

+(NSMutableArray *)getTimeArrayList:(int)size
{
    NSMutableArray * array = [NSMutableArray array];
    
    NSCalendar * currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [currentCalendar components:unitFlags fromDate:[NSDate date]];
    
    for (int i=0; i<size; i++) {
        
        NSDate* date = [currentCalendar dateFromComponents:comps];
        
        [array addObject:[self returnYYYYMMDD:date]];
        
        comps.day++;
    }
    
    return array;
}


+(BOOL)isWorkDay
{
    NSCalendar * currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [currentCalendar components:unitFlags fromDate:[NSDate date]];
    
    if(comps.hour>8 && comps.hour<21)
    {
        return YES;
    }
    
    return NO;
    
}

@end
