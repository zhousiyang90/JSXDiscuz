//
//  WritingLogUploadImagesView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/29.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WritingLogUploadImagesViewBlock)(NSIndexPath*);

@interface WritingLogUploadImagesView : CommonViewFromXib

@property(nonatomic,strong) NSMutableArray * imagesList;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,assign) CGFloat hangHeight;

@property(nonatomic,copy) WritingLogUploadImagesViewBlock block;

@end
