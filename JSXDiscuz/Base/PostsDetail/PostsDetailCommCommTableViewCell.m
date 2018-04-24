//
//  PostsDetailCommCommTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "PostsDetailCommCommTableViewCell.h"

@implementation PostsDetailCommCommTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setCommentText:(NSString *)commentText
{
    _commentText=commentText;
    self.commentLab.text=commentText;
    
}


@end
