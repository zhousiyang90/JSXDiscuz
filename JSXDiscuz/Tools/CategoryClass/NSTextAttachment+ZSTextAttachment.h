//
//  NSTextAttachment+ZSTextAttachment.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/30.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ZSTextAttachmentType) {
    ZSTextAttachmentTypeImage,
    ZSTextAttachmentTypeVideo
};

@interface NSTextAttachment (ZSTextAttachment)

+ (instancetype)attachmentWithImage:(UIImage *)image width:(CGFloat)width;

@property (nonatomic, assign) ZSTextAttachmentType attachmentType;

@property (nonatomic, copy) NSString * localFilePath;

@end
