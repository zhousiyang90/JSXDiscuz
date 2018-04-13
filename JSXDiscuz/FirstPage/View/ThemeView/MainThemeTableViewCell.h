//
//  MainThemeTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainThemeTableViewCellBlock)(NSIndexPath*);

@interface MainThemeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,copy) MainThemeTableViewCellBlock block;

@end
