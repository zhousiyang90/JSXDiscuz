//
//  MineCenterSettingViewController_pwd.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterSettingViewController_pwd.h"

@interface MineCenterSettingViewController_pwd ()

@end

@implementation MineCenterSettingViewController_pwd

#pragma mark - 生命周期

-(void)addSubViews
{
    self.needNoNetTips=NO;
    self.needNoTableViewDataTips=NO;
    
    [[self.oldpwdTf rac_textSignal]subscribeNext:^(id x) {
        
    }];
    
    [[self.newpwdTf rac_textSignal]subscribeNext:^(id x) {
        
    }];
    
    [[self.confirmpwdTf rac_textSignal]subscribeNext:^(id x) {
        
    }];
}

-(void)setNavigationBar
{
    
}


- (IBAction)clickCommit:(id)sender {
}
@end
