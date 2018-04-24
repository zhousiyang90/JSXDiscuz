//
//  PostDetailData.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostsDetailData_content.h"
#import "PostsDetailData_comment.h"

@interface PostDetailData : NSObject

@property(nonatomic,strong) PostsDetailData_content *pinfo;
@property(nonatomic,strong) NSMutableArray *hpost;

@end
