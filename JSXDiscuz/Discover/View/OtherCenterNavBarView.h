//
//  OtherCenterNavBarView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherCenterNavBarView : CommonViewFromXib

@property(nonatomic,assign) NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UIButton *navBtn1;
@property (weak, nonatomic) IBOutlet UIButton *navBtn2;


- (IBAction)clickNavBtn1:(id)sender;
- (IBAction)clickNavBtn2:(id)sender;

-(void)refreshNavBar:(NSInteger)page;

@end
