//
//  DiscuzBannelTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/19.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "DiscuzBannelTableViewCell.h"
#import "DiscuzBannelCollectionCell.h"
#import "WaveBannelBackGroundView.h"


@interface DiscuzBannelTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    WaveBannelBackGroundView * wavev1;
    WaveBannelBackGroundView * wavev2;
    RACDisposable * disposable;
    NSInteger currentIndex;
}
@end

@implementation DiscuzBannelTableViewCell

static NSString *const cellId = @"discuzBannelCollectionCell";

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing=0.0;
    layout.minimumInteritemSpacing=0.0;
    layout.itemSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, self.bounds.size.height);
    layout.sectionInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    
    self.bannelview.frame=self.bounds;
    self.bannelview.collectionViewLayout=layout;
    self.bannelview.backgroundColor = [UIColor whiteColor];
    self.bannelview.dataSource = self;
    self.bannelview.delegate = self;
    self.bannelview.pagingEnabled=YES;
    [self.bannelview registerNib:[UINib nibWithNibName:@"DiscuzBannelCollectionCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    
    //RAC-KVO
    [RACObserve(self.bannelview,contentOffset)subscribeNext:^(id  _Nullable x){
        if(self.bannelImgs.count>0)
        {
            CGPoint cp =[x CGPointValue];
            int pageNum=(int)(cp.x/SDScreenWidth)%(self.bannelImgs.count);
        }
        
    }];
    
    wavev1=[[WaveBannelBackGroundView alloc]init];
    wavev1.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.waveView.bounds.size.height);
    wavev1.backgroundColor=[UIColor clearColor];
    wavev1.speed=0.2;
    [self.waveView addSubview:wavev1];
    [wavev1 startwave];
   
    wavev2=[[WaveBannelBackGroundView alloc]init];
    wavev2.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.waveView.bounds.size.height);
    wavev2.backgroundColor=[UIColor clearColor];
    wavev2.translateValue=[UIScreen mainScreen].bounds.size.width/8;
    wavev2.waveAlpha=0.5;
    wavev2.speed=0.2;
    [self.waveView addSubview:wavev2];
    [wavev2 startwave];
    
    currentIndex=0;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10000;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DiscuzBannelCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSString * imgName = self.bannelImgs[indexPath.item%self.bannelImgs.count];
    cell.bannelImg.image=[UIImage imageNamed:imgName];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)adjustPosition
{
    currentIndex=self.bannelImgs.count*1000;
    [self.bannelview scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0]
                            atScrollPosition:UICollectionViewScrollPositionNone
                                    animated:NO];
    [self startScroll];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating:%f",scrollView.contentOffset.x/SDScreenWidth);
    currentIndex=scrollView.contentOffset.x/SDScreenWidth;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopScroll];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startScroll];
}

-(void)startScroll
{
    if(disposable==nil)
    {
        disposable = [[RACSignal interval:5.0 onScheduler:[RACScheduler mainThreadScheduler] withLeeway:3.0]subscribeNext:^(id x) {
            currentIndex++;
            [self.bannelview scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionNone
                                            animated:YES];
        }];
    }
}

-(void)stopScroll
{
    if(disposable)
    {
        [disposable dispose];
        disposable=nil;
    }
}

@end
