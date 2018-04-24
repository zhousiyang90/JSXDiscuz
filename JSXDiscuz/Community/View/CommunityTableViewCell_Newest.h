//
//  CommunityTableViewCell_Newest.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityPostsData.h"
#import "CommunityNewestData.h"

typedef void(^CommunityTableViewCell_NewestBlock)(int type);

@interface CommunityTableViewCell_Newest : UITableViewCell

@property(nonatomic,strong) CommunityPostsData * postdata;
@property(nonatomic,strong) CommunityNewestData * data;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;

@property (weak, nonatomic) IBOutlet UILabel *readNumberLab;

@property (weak, nonatomic) IBOutlet UIButton *themeBtn;
@property(nonatomic,copy) CommunityTableViewCell_NewestBlock block;

- (IBAction)clickThemeBtn:(id)sender;

@end
