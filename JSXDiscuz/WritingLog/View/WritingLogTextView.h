//
//  WritingLogTextView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/28.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WritingLogTextView : UITextView

@property(nonatomic,strong) NSDictionary * typingAttrDict;

-(CGFloat)getArrtTextHeight;

@end
