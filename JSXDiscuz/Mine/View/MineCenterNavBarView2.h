//
//  MineCenterNavBarView2.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/4.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCenterNavBarView2 : CommonViewFromXib

@property(nonatomic,assign) NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UIButton *navBtn1;
@property (weak, nonatomic) IBOutlet UIButton *navBtn2;
@property (weak, nonatomic) IBOutlet UIButton *navBtn3;
@property (weak, nonatomic) IBOutlet UIButton *navBtn4;

- (IBAction)clickNavBtn1:(id)sender;
- (IBAction)clickNavBtn2:(id)sender;
- (IBAction)clickNavBtn3:(id)sender;
- (IBAction)clickNavBtn4:(id)sender;

-(void)refreshNavBar:(NSInteger)page;

@end
