//
//  JSXLocalTool.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/13.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JSXLocalToolBlock)(CLLocation*);

@interface JSXLocalTool : NSObject

+(instancetype)shareLocationTool;
-(void)getLocationOnce:(JSXLocalToolBlock)block;
@property(nonatomic,copy) JSXLocalToolBlock block;

@end
