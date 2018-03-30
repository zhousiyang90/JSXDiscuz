//
//  JSXDateTool.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSXDateTool : NSObject

#pragma mark 根据NSDate返回YYYY/MM/DD格式字符串

+(NSString*)returnYYYYMMDD_line:(NSDate*)date;

#pragma mark 根据NString的格式转成NSDate

+(NSDate*)returnDateFromString:(NSString*)dateStr;

#pragma mark 根据NSDate返回YYYY-MM-DD格式字符串

+(NSString*)returnYYYYMMDD:(NSDate*)date;

#pragma mark 根据NSDate返回YYYY-MM-DD HH:mm:ss格式字符串

+(NSString *)returnYYYYMMDDHHmmss:(NSDate *)date;

#pragma mark 根据NSDate返回DD格式字符串

+(NSString *)returnDD:(NSDate *)date;

+(NSString *)returnMM:(NSDate *)date;

+(NSString *)returnYY:(NSDate *)date;

+(NSString *)returnYYYY:(NSDate *)date;

#pragma mark 根据NSDate返回YY-MM-DD格式字符串

+(NSString*)returnYYMMDD:(NSDate*)date;

#pragma mark 根据NSDate返回N个月前YYYY-MM-DD格式字符串

+(NSString*)returnYYYYMMDD:(NSDate *)date andPreMon:(int)num;

#pragma mark 根据NSDate返回N个月前YYYY-MM-DD格式字符串

+(NSString*)returnYYMMDD:(NSDate *)date andPreMon:(int)num;

#pragma mark 返回今天日期字格式YYYY-MM-DD符串

+(NSString*)returnYYYYMMDDToday;

#pragma mark 返回本周日期字格式YYYY-MM-DD符串

+(NSString*)returnYYYYMMDDWeek;

#pragma mark 返回本月日期字格式YYYY-MM-DD符串

+(NSString*)returnYYYYMMDDMonth;

#pragma mark 返回本年日期字格式YYYY-MM-DD符串

+(NSString*)returnYYYYMMDDYear;

#pragma mark 比较两个时间的大小

+(BOOL)oneIsGreaterThanTwo:(NSDate*)one andTwo:(NSDate*)two;

#pragma mark 根据YYYY-MM-DD HH:MM:SS字符串返回NSDateComponents容器

+(NSDateComponents*)getCurrentComponent:(NSString*)dateStr;

#pragma mark 根据当前时间显示用户体验更好的时间(例如：本月-2月-2015-03)

+(NSString*)getBetterTime:(NSDate*)date;

#pragma mark 根据当前NSDateComponents时间容器显示用户体验更好的时间(例如：本月-2月-2015-03)

+(NSString*)getBetterTimeFromNSDateComponents:(NSDateComponents*)component;

#pragma mark 返回从今天开始size大小的时间列表

+(NSMutableArray*)getTimeArrayList:(int)size;

#pragma mark 工作日时间

+(BOOL)isWorkDay;

@end
