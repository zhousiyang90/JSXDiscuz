//
//  UITableView+ZSTableView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/24.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "UITableView+ZSTableView.h"

@implementation UITableView (ZSTableView)

- (void)scrollViewToBottom:(BOOL)animated
{
    if (self.contentSize.height > self.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.contentSize.height - self.frame.size.height);
        [self setContentOffset:offset animated:animated];
    }
}

@end
