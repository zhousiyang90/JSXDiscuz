//
//  TableViewOfRefreshFooterView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "TableViewOfRefreshFooterView.h"

@implementation TableViewOfRefreshFooterView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.loadview startAnimating];
}

@end
