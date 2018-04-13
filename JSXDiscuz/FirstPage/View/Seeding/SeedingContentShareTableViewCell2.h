//
//  SeedingContentShareTableViewCell2.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/12.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeedingContentShareTableViewCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray * videoList;

@end
