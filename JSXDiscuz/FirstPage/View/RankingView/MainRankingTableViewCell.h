//
//  MainRankingTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/28.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostBaseData.h"

typedef void(^MainRankingTableViewCellBlock)(int);

@interface MainRankingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *themeBtn1;
@property (weak, nonatomic) IBOutlet UIButton *themeBtn2;
@property (weak, nonatomic) IBOutlet UIButton *themeBtn3;
@property (weak, nonatomic) IBOutlet UILabel *timeLab1;
@property (weak, nonatomic) IBOutlet UILabel *timeLab2;
@property (weak, nonatomic) IBOutlet UILabel *timeLab3;
@property (weak, nonatomic) IBOutlet UILabel *titleLab1;
@property (weak, nonatomic) IBOutlet UILabel *titleLab2;
@property (weak, nonatomic) IBOutlet UILabel *titleLab3;
- (IBAction)clickTheme1:(id)sender;
- (IBAction)clickTheme2:(id)sender;
- (IBAction)clickTheme3:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *bg1;
@property (weak, nonatomic) IBOutlet UIView *bg2;
@property (weak, nonatomic) IBOutlet UIView *bg3;

@property(nonatomic,strong) PostBaseData * baseData;
@property(nonatomic,copy) MainRankingTableViewCellBlock block;
@end
