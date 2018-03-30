//
//  JSXImageTool.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSXImageTool : NSObject

#pragma mark UIColor->UIImage

+(UIImage*)getUIImageFromUIColor:(UIColor*)color;

#pragma mark UIImage->UIColor

+(UIColor*)getUIColorFromUIImage:(UIImage*)image;

@end
