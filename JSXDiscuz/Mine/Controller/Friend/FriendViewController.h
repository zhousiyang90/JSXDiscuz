//
//  FriendViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/5/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendViewController_focus.h"
#import "FriendViewController_friend.h"

@interface FriendViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *barView;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;


- (IBAction)clickBtn1:(id)sender;
- (IBAction)clickBtn2:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end
