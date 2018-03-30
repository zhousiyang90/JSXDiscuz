//
//  WritingLogBodyFooterView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WritingLogBodyFooterView : CommonViewFromXib
@property (weak, nonatomic) IBOutlet UIButton *addTitleBtn;
- (IBAction)clickAddTitleBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addPositionBtn;
- (IBAction)clickAddPositionBtn:(id)sender;

- (IBAction)clickAddImageBtn:(id)sender;

- (IBAction)clickAddVideoBtn:(id)sender;
@end
