//
//  MainFunctionTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/26.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainFunctionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *view3;

@property (weak, nonatomic) IBOutlet UIView *view4;

-(void)clickView1;

-(void)clickView2;

-(void)clickView3;

-(void)clickView4;


@end
