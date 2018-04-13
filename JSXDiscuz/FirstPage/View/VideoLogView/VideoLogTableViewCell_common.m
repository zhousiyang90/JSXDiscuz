//
//  VideoLogTableViewCell_common.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/11.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "VideoLogTableViewCell_common.h"
#import "VideoLogCollectionCell_common.h"

#define CollectionViewMargin 0.0
#define CollectionCellViewMargin 10.0

@interface VideoLogTableViewCell_common()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    double itemWidht;
    double ratio;
}
@end

static NSString *const cellId = @"videoLogCollectionCell_common";

@implementation VideoLogTableViewCell_common

#pragma mark - CollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.videoList.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * video = self.videoList[indexPath.row];
    VideoLogCollectionCell_common *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.playNumLab.text=[NSString stringWithFormat:@"播放%@次",video];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing=CollectionCellViewMargin;
    layout.minimumInteritemSpacing=CollectionCellViewMargin;
    layout.sectionInset = UIEdgeInsetsMake(CollectionCellViewMargin, CollectionCellViewMargin, CollectionCellViewMargin, CollectionCellViewMargin);
    
    itemWidht=(SDScreenWidth-CollectionViewMargin*2-CollectionCellViewMargin*4)/2;
    ratio=2.0/3.0;
    layout.itemSize=CGSizeMake(itemWidht, itemWidht*ratio);
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator=NO;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    self.collectionView.bounces=NO;
    self.collectionView.collectionViewLayout=layout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoLogCollectionCell_common" bundle:nil] forCellWithReuseIdentifier:cellId];
}


-(void)setVideoList:(NSMutableArray *)videoList
{
    _videoList=videoList;
}

@end
