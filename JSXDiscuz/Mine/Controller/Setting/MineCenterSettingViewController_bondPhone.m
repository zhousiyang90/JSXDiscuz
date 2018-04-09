//
//  MineCenterSettingViewController_bondPhone.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterSettingViewController_bondPhone.h"
#define SumCount 10

@interface MineCenterSettingViewController_bondPhone ()
{
    BOOL hasSend;
    RACDisposable * racdis;
}
@end

@implementation MineCenterSettingViewController_bondPhone

-(void)addSubViews
{
    [[self.randomBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        self.randomBtn.enabled=NO;
        __block int count=SumCount;
        racdis=[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
            count--;
            NSString * text =[NSString stringWithFormat:@"(%d s)",count];
            [self.randomBtn setTitle:text forState:UIControlStateNormal];
            if(count==0)
            {
                self.randomBtn.enabled=YES;
                [self.randomBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [racdis dispose];
            }
            
        }];
        
    }];
}

- (IBAction)clickBond:(id)sender {
}
@end
