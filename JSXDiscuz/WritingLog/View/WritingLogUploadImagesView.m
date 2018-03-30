//
//  WritingLogUploadImagesView.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/29.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "WritingLogUploadImagesView.h"
#import "WritingLogUploadImagesCell.h"
#import "MainQuickScanCollectionViewCell.h"

#define CellMargin 5

@interface WritingLogUploadImagesView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
}
@end

@implementation WritingLogUploadImagesView

static NSString *const cellId = @"writingLogUploadImagesCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing=0.0;
    layout.minimumInteritemSpacing=0.0;
    layout.itemSize=CGSizeMake((SDScreenWidth-CellMargin*10)/4,(SDScreenWidth-CellMargin*10)/4);
    layout.sectionInset = UIEdgeInsetsMake(CellMargin, CellMargin, CellMargin, CellMargin);
    self.hangHeight=(SDScreenWidth-CellMargin*10)/4+CellMargin;
    self.collectionView.collectionViewLayout=layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"WritingLogUploadImagesCell" bundle:nil] forCellWithReuseIdentifier:cellId];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesList.count+1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WritingLogUploadImagesCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if(self.imagesList.count>0 &&indexPath.row<self.imagesList.count)
    {
        UIImage * image = self.imagesList[indexPath.row];
        cell.imageContent.image=image;
    }else
    {
        cell.imageContent.image=[UIImage imageNamed:@"tj"];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_block)
    {
        _block(indexPath);
    }
}

-(void)setImagesList:(NSMutableArray *)imagesList
{
    _imagesList=imagesList;
    [self.collectionView reloadData];
}


@end
