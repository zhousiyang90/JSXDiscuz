//
//  JSXHtmlExportTool.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/29.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WritingLogImageData.h"

@interface JSXHtmlExportTool : NSObject

+(NSMutableString*)HTMLFromAttributedString:(NSAttributedString *)attributedString;

+(NSMutableString*)HTMLFromImageDatas:(NSMutableArray*)imageList;

@end
