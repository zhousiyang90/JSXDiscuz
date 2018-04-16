//
//  JSXImageTool.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "JSXImageTool.h"

@implementation JSXImageTool

+(UIImage *)getUIImageFromUIColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

+(UIColor *)getUIColorFromUIImage:(UIImage *)image
{
    return  [UIColor colorWithPatternImage:image];
}

+(UIImage*)composeImg:(UIImage*)bigImg andimg2:(UIImage*)smallImg{
    UIGraphicsBeginImageContext(CGSizeMake(bigImg.size.width, bigImg.size.height));
    [bigImg drawInRect:CGRectMake(0, 0, bigImg.size.width, bigImg.size.height)];
    [smallImg drawInRect:CGRectMake(bigImg.size.width/2-smallImg.size.width/2, bigImg.size.height/2-smallImg.size.height/2, smallImg.size.width, smallImg.size.height)];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    return resultImg;
}

@end
