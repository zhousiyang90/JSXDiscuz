//
//  MainThemeTableViewCell2.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/28.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MainThemeTableViewCell2.h"
#import "MainThemeCollectionViewCell2.h"

@interface MainThemeTableViewCell2()<UICollectionViewDelegate,UICollectionViewDataSource>
@end

@implementation MainThemeTableViewCell2

static NSString *const cellId = @"mainThemeCollectionViewCell2";

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing=0.0;
    layout.minimumInteritemSpacing=0.0;
    layout.itemSize=CGSizeMake(150, self.collectionView.bounds.size.height);
    layout.sectionInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    
    self.collectionView.collectionViewLayout=layout;
    self.collectionView.backgroundColor = BGThemeColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainThemeCollectionViewCell2" bundle:nil] forCellWithReuseIdentifier:cellId];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.baseData.catlist.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainThemeCollectionViewCell2 *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    GroupMainData_summary * cellData=self.baseData.catlist[indexPath.row];
    cell.titleLab.text=cellData.name;
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:cellData.icon] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Group]];
    cell.postsNumLab.text=[NSString stringWithFormat:@"%@主题/%@帖子",cellData.threadnum,cellData.repliesnum];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_block)
    {
        _block(indexPath);
    }
}

-(void)setBaseData:(GroupMainData *)baseData
{
    _baseData=baseData;
    [self.collectionView reloadData];
    
}

@end
