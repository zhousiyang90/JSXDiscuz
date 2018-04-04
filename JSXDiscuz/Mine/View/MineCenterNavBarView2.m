//
//  MineCenterNavBarView2.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/4.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterNavBarView2.h"

@interface MineCenterNavBarView2()
{
    UIView * lineView;
}
@end

@implementation MineCenterNavBarView2

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(SDScreenWidth/8-30, 39, 60, 1)];
    lineView.backgroundColor=SDColor(46, 196, 252);
    [self.navBarView addSubview:lineView];
}

- (IBAction)clickNavBtn1:(id)sender {
    
}
- (IBAction)clickNavBtn2:(id)sender {
    
}
- (IBAction)clickNavBtn3:(id)sender {
    
}
- (IBAction)clickNavBtn4:(id)sender {
    
}

-(void)refreshNavBar:(NSInteger)page
{
    switch (page) {
        case 0:
            self.navBtn1.selected=YES;
            self.navBtn2.selected=NO;
            self.navBtn3.selected=NO;
            self.navBtn4.selected=NO;
            lineView.x=SDScreenWidth/8-30;
            break;
        case 1:
            self.navBtn1.selected=NO;
            self.navBtn2.selected=YES;
            self.navBtn3.selected=NO;
            self.navBtn4.selected=NO;
            lineView.x=SDScreenWidth/8*3-30;
            break;
        case 2:
            self.navBtn1.selected=NO;
            self.navBtn2.selected=NO;
            self.navBtn3.selected=YES;
            self.navBtn4.selected=NO;
            lineView.x=SDScreenWidth/8*5-30;
            break;
        case 3:
            self.navBtn1.selected=NO;
            self.navBtn2.selected=NO;
            self.navBtn3.selected=NO;
            self.navBtn4.selected=YES;
            lineView.x=SDScreenWidth/8*7-30;
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
