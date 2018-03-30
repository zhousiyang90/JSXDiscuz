//
//  DiscuzBannelTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/19.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscuzBannelTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *bannelview;

@property (weak, nonatomic) IBOutlet UIView *waveView;

@property(nonatomic,strong) NSArray * bannelImgs;

-(void)adjustPosition;

-(void)startScroll;

-(void)stopScroll;

@end
