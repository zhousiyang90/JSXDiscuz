//
//  MainQuickScanTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainQuickScanTableViewCellBlock)(int,NSIndexPath*);

@interface MainQuickScanTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property(nonatomic,copy) MainQuickScanTableViewCellBlock block;

@end
