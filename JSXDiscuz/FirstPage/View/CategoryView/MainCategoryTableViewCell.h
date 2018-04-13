//
//  MainCategoryTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainCategoryTableViewCellBlock)(int);

@interface MainCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *view3;

@property(nonatomic,copy) MainCategoryTableViewCellBlock block;

@end
