//
//  GroupSectionHeaderView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "GroupSectionHeaderView.h"

@implementation GroupSectionHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.functionBtn.layer.cornerRadius=5;
    self.functionBtn.layer.borderWidth=1;
    self.functionBtn.layer.borderColor=SDColor(43, 152, 240).CGColor;
}
@end
