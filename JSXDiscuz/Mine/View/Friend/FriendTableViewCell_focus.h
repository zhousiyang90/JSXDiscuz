//
//  FriendTableViewCell_focus.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/5/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FriendTableViewCell_focusBlock)(void);

@interface FriendTableViewCell_focus : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property(nonatomic,copy)FriendTableViewCell_focusBlock block;

@end
