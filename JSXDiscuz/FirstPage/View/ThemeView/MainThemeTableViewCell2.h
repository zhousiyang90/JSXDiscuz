//
//  MainThemeTableViewCell2.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/28.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainThemeTableViewCell2Block)(NSIndexPath*);

@interface MainThemeTableViewCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,copy)MainThemeTableViewCell2Block block;

@end
