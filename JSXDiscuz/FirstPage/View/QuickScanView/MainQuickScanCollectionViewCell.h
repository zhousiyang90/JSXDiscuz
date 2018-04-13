//
//  MainQuickScanCollectionViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainQuickScanCollectionViewCellBlock)(void);
@interface MainQuickScanCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgview;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UIImageView *userImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *readNumLab;

@property(nonatomic,copy) MainQuickScanCollectionViewCellBlock block;
@end
