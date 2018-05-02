//
//  DES.h
//  KcalOfDriver
//
//  Created by 周思扬 on 2017/9/13.
//  Copyright © 2017年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES : NSObject

+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

+(NSString *) parseByte2HexString:(Byte *) bytes;

+(NSString *) parseByteArray2HexString:(Byte[]) bytes;

+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;

@end
