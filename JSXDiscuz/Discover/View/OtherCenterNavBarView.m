//
//  OtherCenterNavBarView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "OtherCenterNavBarView.h"

@interface OtherCenterNavBarView()
{
    UIView * lineView;
}
@end

@implementation OtherCenterNavBarView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(SDScreenWidth/4-30, 39, 60, 1)];
    lineView.backgroundColor=SDColor(46, 196, 252);
    [self.navBarView addSubview:lineView];
}

- (IBAction)clickNavBtn1:(id)sender {
    
}
- (IBAction)clickNavBtn2:(id)sender {
    
}

-(void)refreshNavBar:(NSInteger)page
{
    switch (page) {
        case 0:
            self.navBtn1.selected=YES;
            self.navBtn2.selected=NO;
            lineView.x=SDScreenWidth/4-30;
            break;
        case 1:
            self.navBtn1.selected=NO;
            self.navBtn2.selected=YES;
            lineView.x=SDScreenWidth/4*3-30;
            break;
        default:
            break;
    }
}

-(void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex=currentIndex;
    
    [self refreshNavBar:currentIndex];
}


@end
