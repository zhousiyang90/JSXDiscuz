//
//  JSXHtmlExportTool.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/29.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "JSXHtmlExportTool.h"

@implementation JSXHtmlExportTool

/**
 *  将原生的 AttributedString 导出成 HTML，用于 Web 端显示，可以根据自己需求修改导出的 HTML 内容，比如添加 class 或是 id 等。
 *
 *  @param attributedString 需要被导出的富文本
 *
 *  @return 导出的 HTML
 */

+(NSMutableString*)HTMLFromAttributedString:(NSAttributedString *)attributedString{
    BOOL isNewParagraph = YES;
    NSMutableString *htmlContent = [NSMutableString string];
    NSRange effectiveRange = NSMakeRange(0, 0);
    while (effectiveRange.location + effectiveRange.length < attributedString.length) {
        NSDictionary *attributes = [attributedString attributesAtIndex:effectiveRange.location effectiveRange:&effectiveRange];
        NSTextAttachment *attachment = attributes[@"NSAttachment"];
        NSParagraphStyle *paragraph = attributes[@"NSParagraphStyle"];
        double indentLevel = paragraph.headIndent/32.0;
        if (attachment) {
            switch (attachment.attachmentType) {
                case ZSTextAttachmentTypeImage:
                    [htmlContent appendString:[NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"/>", attachment.localFilePath]];
                    break;
                default:
                    break;
            }
        }
        else {
            NSString *text = [[attributedString string] substringWithRange:effectiveRange];
            UIFont *font = attributes[NSFontAttributeName];
            UIColor *fontColor = attributes[@"NSColor"];
            NSString *color = [self hexStringWithColor:fontColor];
            //BOOL underline = [attributes[NSUnderlineStyleAttributeName] boolValue];
            BOOL isFirst = YES;
            
            NSArray *components = [text componentsSeparatedByString:@"\n"];
            for (NSInteger i = 0; i < components.count; i ++) {
                NSString *content = components[i];
                if (!isFirst && !isNewParagraph) {
                    [htmlContent appendString:@"</p>"];
                    isNewParagraph = YES;
                }
                if (isNewParagraph && (content.length > 0 || i < components.count - 1)) {
                    [htmlContent appendString:[NSString stringWithFormat:@"<p style=\"text-indent:%@em;margin:4px auto 0px auto;\">", @(2 * indentLevel).stringValue]];
                    isNewParagraph = NO;
                }
                [htmlContent appendString:[self HTMLWithContent:content font:font color:color]];
                isFirst = NO;
            }
            if (effectiveRange.location + effectiveRange.length >= attributedString.length && ![htmlContent hasSuffix:@"</p>"]) {
                // 补上</p>
                [htmlContent appendString:@"</p>"];
            }
        }
        effectiveRange = NSMakeRange(effectiveRange.location + effectiveRange.length, 0);
    }
    return htmlContent;
}

+ (NSString *)HTMLWithContent:(NSString *)content font:(UIFont *)font color:(NSString *)color {
    
    if (content.length == 0) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"<font style=\"font-size:%f;color:%@\">%@</font>", [font.fontDescriptor.fontAttributes[@"NSFontSizeAttribute"] floatValue], color, content];
}

+ (NSString *)hexStringWithColor:(UIColor *)color {
    
    NSString *colorString = [[CIColor colorWithCGColor:color.CGColor] stringRepresentation];
    NSArray *parts = [colorString componentsSeparatedByString:@" "];
    
    NSMutableString *hexString = [NSMutableString stringWithString:@"#"];
    for (int i = 0; i < 3; i ++) {
        [hexString appendString:[NSString stringWithFormat:@"%02X", (int)([parts[i] floatValue] * 255)]];
    }
    return [hexString copy];
}

+(NSMutableString*)HTMLFromImageDatas:(NSMutableArray *)imageList
{
    NSMutableString * htmlContent = [NSMutableString string];
    for(int i=0;i<imageList.count;i++)
    {
        [htmlContent appendString:[NSString stringWithFormat:@"<p style=\"text-indent:%@em;margin:4px auto 0px auto;\">", @(0).stringValue]];
        WritingLogImageData * imageData = imageList[i];
        [htmlContent appendString:[NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"/>", imageData.filePath]];
    }
    return htmlContent;
}



@end
