//
//  MainQuickScanTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainQuickScanTableViewCell.h"
#import "MainQuickScanCollectionViewCell.h"

@interface MainQuickScanTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation MainQuickScanTableViewCell

static NSString *const cellId = @"mainQuickScanCollectionViewCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing=0.0;
    layout.minimumInteritemSpacing=0.0;
    layout.itemSize=CGSizeMake([UIScreen mainScreen].bounds.size.width/3*2, self.collectionView.bounds.size.height);
    layout.sectionInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    
    self.collectionView.collectionViewLayout=layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainQuickScanCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainQuickScanCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.block = ^() {
        //点击用户头像和名称
        if(_block)
        {
            _block(0,indexPath);
        }
    };
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_block)
    {
        _block(1,indexPath);
    }
}
@end
