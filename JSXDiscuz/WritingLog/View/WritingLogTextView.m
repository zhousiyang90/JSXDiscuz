//
//  WritingLogTextView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/28.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "WritingLogTextView.h"

#define TextViewMargin 10
#define TextLineSpace 5

@implementation WritingLogTextView

-(instancetype)init
{
    if(self =[super init])
    {
        self.typingAttributes=self.typingAttrDict;
        self.spellCheckingType=UITextSpellCheckingTypeNo;
    }
    return self;
}


-(NSDictionary *)typingAttrDict
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 字体的行间距
    paragraphStyle.lineSpacing = TextLineSpace;
    //首行缩进
    paragraphStyle.firstLineHeadIndent = TextViewMargin;
    //整体缩进(首行除外)
    paragraphStyle.headIndent = TextViewMargin;
    NSDictionary *attributes = @{NSFontAttributeName:SDFontOf15,NSForegroundColorAttributeName:SDColor(0, 0, 0),NSParagraphStyleAttributeName:paragraphStyle};
    
    return attributes;
}

-(CGFloat)getArrtTextHeight
{
    NSAttributedString *attrStr = self.attributedText;
    CGSize size = [attrStr boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    return size.height;
    
}

@end
