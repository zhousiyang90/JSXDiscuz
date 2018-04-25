//
//  CommunityViewController_Album.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityViewController_Album.h"
#import "CommunityCollectionViewCell_Album.h"
#import "CommunityNewestData.h"
#import "OtherCenterViewController.h"
#import "TopicDetailViewController.h"

#define CollectionViewMargin 0.0
#define CollectionCellViewMargin 10.0

@interface CommunityViewController_Album ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    double itemWidht;
    double ratio;
    
    BOOL hasNewData;
}
@property(nonatomic,assign) int currentPage;
@property(nonatomic,strong) CommunityNewestData * currentPagedata;
@property(nonatomic,strong) NSMutableArray * dataList;
@end

static NSString *const cellId = @"communityCollectionViewCell_Album";

@implementation CommunityViewController_Album

#pragma mark - CollectionViewDelegate


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommunityCollectionViewCell_Album *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.postdata=self.dataList[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //点击帖子详情
    CommunityPostsData * celldata=self.dataList[indexPath.row];
    [self pushToPostsDetail:celldata.tid andFid:celldata.fid];
}

#pragma mark - LazyLoad

-(NSMutableArray *)dataList
{
    if(_dataList==nil)
    {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
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
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseCollectionview=self.collectionView;
}

-(void)getInitData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if([UserDataTools getUserInfo].uid.length==0)
    {
        [self showLoginView];
        return;
    }else
    {
        params[@"uid"]=[UserDataTools getUserInfo].uid;
    }
    [SVProgressHUD showWithStatus:@"加载中"];
    [JSXHttpTool Get:Interface_CommuityAlbum params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.currentPagedata = [CommunityNewestData mj_objectWithKeyValues:json];
            self.dataList=self.currentPagedata.list;
            
            [self.collectionView reloadData];
            [SVProgressHUD dismiss];
            [self.collectionView.pullToRefreshView stopAnimating];
        }else
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)nonetstatusGetData
{
    [self getInitData];
}

-(void)nodatasGetData
{
    [self getInitData];
}

@end
