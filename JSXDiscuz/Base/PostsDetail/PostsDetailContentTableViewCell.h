//
//  PostsDetailContentTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PostsDetailContentTableViewCellBlock)(int);
typedef void(^PostsDetailContentTableViewCellBlock2)(void);
typedef void(^PostsDetailContentTableViewCellBlock3)(void);

@interface PostsDetailContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIButton *themeBtn;
@property (weak, nonatomic) IBOutlet UILabel *readNumLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;

@property(nonatomic,strong) PostsDetailData_content * contentData;

@property(nonatomic,copy) PostsDetailContentTableViewCellBlock  block;
@property(nonatomic,copy) PostsDetailContentTableViewCellBlock2  clickblock;
@property(nonatomic,copy) PostsDetailContentTableViewCellBlock3  headblock;

@end
