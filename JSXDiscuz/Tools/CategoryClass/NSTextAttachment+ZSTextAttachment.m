//
//  NSTextAttachment+ZSTextAttachment.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/30.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "NSTextAttachment+ZSTextAttachment.h"
#import <objc/runtime.h>

@implementation NSTextAttachment (ZSTextAttachment)

+ (instancetype)attachmentWithImage:(UIImage *)image width:(CGFloat)width {
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    CGRect rect = CGRectZero;
    rect.size.width = width;
    rect.size.height = width * image.size.height / image.size.width;
    textAttachment.bounds = rect;
    textAttachment.image = image;
    return textAttachment;
}

static void * keyOfAttachmentType = &keyOfAttachmentType;
static void * keyOfLocalFilePath = &keyOfLocalFilePath;

- (ZSTextAttachmentType)attachmentType {
    return [(NSNumber *)objc_getAssociatedObject(self, keyOfAttachmentType) intValue];
}

- (void)setAttachmentType:(ZSTextAttachmentType)attachmentType {
    objc_setAssociatedObject(self, keyOfAttachmentType, @(attachmentType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)localFilePath
{
    return objc_getAssociatedObject(self, keyOfLocalFilePath);
}

-(void)setLocalFilePath:(NSString *)localFilePath
{
    objc_setAssociatedObject(self, keyOfLocalFilePath, localFilePath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
