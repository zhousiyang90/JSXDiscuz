//
//  DiscoveryContentTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoveryContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

-(void)clickview1;

-(void)clickview2;

-(void)clickview3;

-(void)clickview4;
@end
