//
//  CommentBottomView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommentBottomView.h"

@implementation CommentBottomView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.commentBtn.layer.cornerRadius=5;
    self.likeLab.layer.cornerRadius=7.5;
    self.likeLab.layer.masksToBounds=YES;
}

@end
