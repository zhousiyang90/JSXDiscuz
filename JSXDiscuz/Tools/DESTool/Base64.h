//
//  Base64.h
//  KcalOfDriver
//
//  Created by 周思扬 on 2017/9/13.
//  Copyright © 2017年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+(NSData *)decode:(NSString *)data;

+(NSString *)encode:(NSData *)data;

+(int)char2Int:(char)c;

@end
