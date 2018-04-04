//
//  CommunityViewController_Album.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityViewController_Album.h"
#import "CommunityCollectionViewCell_Album.h"

#define CollectionViewMargin 0.0
#define CollectionCellViewMargin 10.0

@interface CommunityViewController_Album ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    double itemWidht;
    double ratio;
    
    BOOL hasNewData;
}
@end

static NSString *const cellId = @"communityCollectionViewCell_Album";

@implementation CommunityViewController_Album

#pragma mark - CollectionViewDelegate


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommunityCollectionViewCell_Album *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    return cell;
}

#pragma mark - 生命周期

-(void)addSubViews
{
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing=CollectionCellViewMargin;
    layout.minimumInteritemSpacing=CollectionCellViewMargin;
    layout.sectionInset = UIEdgeInsetsMake(CollectionCellViewMargin, CollectionCellViewMargin, CollectionCellViewMargin, CollectionCellViewMargin);
    
    itemWidht=(SDScreenWidth-CollectionViewMargin*2-CollectionCellViewMargin*4)/2;
    ratio=5.0/4.0;
    layout.itemSize=CGSizeMake(itemWidht, itemWidht*ratio);
    
    [self.collectionView addPullToRefreshWithActionHandler:^{
        [self.collectionView.pullToRefreshView stopAnimating];
    }];
    
    self.collectionView.collectionViewLayout=layout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CommunityCollectionViewCell_Album" bundle:nil] forCellWithReuseIdentifier:cellId];
}

-(void)getInitData
{

}

@end
