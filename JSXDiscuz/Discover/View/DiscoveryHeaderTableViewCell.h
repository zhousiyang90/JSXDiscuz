//
//  DiscoveryHeaderTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoveryHeaderTableViewCell : CommonViewFromXib

@property (weak, nonatomic) IBOutlet UITextField *searchview;

@property (weak, nonatomic) IBOutlet UILabel *dayLab;

@property (weak, nonatomic) IBOutlet UILabel *weekLab;

@property (weak, nonatomic) IBOutlet UILabel *yearmonthLab;

@end
