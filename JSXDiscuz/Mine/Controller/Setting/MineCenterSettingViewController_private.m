//
//  MineCenterSettingViewController_private.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterSettingViewController_private.h"

@interface MineCenterSettingViewController_private ()

@end

@implementation MineCenterSettingViewController_private

#pragma mark - 生命周期

-(void)addSubViews
{
    @weakify(self);
    [[self.privateBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        self.privateBtn1.selected=!self.privateBtn1.selected;
    }];
    
    [[self.privateBtn2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        self.privateBtn2.selected=!self.privateBtn2.selected;
    }];
    
    [[self.privateBtn3 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        self.privateBtn3.selected=!self.privateBtn3.selected;
    }];
    
    [[self.privateBtn4 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        self.privateBtn4.selected=!self.privateBtn4.selected;
    }];
    
    [[self.privateBtn5 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        self.privateBtn5.selected=!self.privateBtn5.selected;
    }];
    
}


- (IBAction)clickCommit:(id)sender {
}
@end
