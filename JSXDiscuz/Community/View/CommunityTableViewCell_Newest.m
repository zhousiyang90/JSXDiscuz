//
//  CommunityTableViewCell_Newest.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/2.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityTableViewCell_Newest.h"
#import "CommunityTableViewCollectionCell_Newest.h"

#define CollectionViewMargin 7.0
#define CollectionCellViewMargin 3.0

@interface CommunityTableViewCell_Newest()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    double itemWidht;
    double ratio;
}
@end

static NSString *const cellId = @"communityTableViewCollectionCell_Newest";

@implementation CommunityTableViewCell_Newest

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing=CollectionCellViewMargin;
    layout.minimumInteritemSpacing=CollectionCellViewMargin;
    layout.sectionInset = UIEdgeInsetsMake(CollectionCellViewMargin, CollectionCellViewMargin, CollectionCellViewMargin, CollectionCellViewMargin);
    
    itemWidht=(SDScreenWidth-CollectionViewMargin*2-CollectionCellViewMargin*6)/3;
    ratio=9.0/16.0;
    layout.itemSize=CGSizeMake(itemWidht, itemWidht*ratio);
    self.collectionView.collectionViewLayout=layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CommunityTableViewCollectionCell_Newest" bundle:nil] forCellWithReuseIdentifier:cellId];
    
    self.headImage.layer.cornerRadius=15;
    self.headImage.layer.masksToBounds=YES;
    UITapGestureRecognizer * tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeadImgandName)];
    [self.headImage setUserInteractionEnabled:YES];
    [self.headImage addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeadImgandName)];
    [self.nameLab setUserInteractionEnabled:YES];
    [self.nameLab addGestureRecognizer:tap2];
}

-(void)setPostdata:(CommunityPostsData *)postdata
{
    _postdata=postdata;
    self.contentLab.text=postdata.subject;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:postdata.uesicon] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Group]];
    self.nameLab.text=postdata.author;
    self.timeLab.text=postdata.time;
    [self.themeBtn setTitle:postdata.forumname forState:UIControlStateNormal];
    self.readNumberLab.text=[NSString stringWithFormat:@"阅读%@-点赞%@",postdata.views,postdata.likes];
    
    if(postdata.pics.count==0)
    {
        self.constraintHeight.constant=0.0;
    }else
    {
        int hang=((int)postdata.pics.count-1)/3+1;
        int hangHeight=itemWidht*ratio+CollectionCellViewMargin*2;
        self.constraintHeight.constant=hang*hangHeight;
    }
}

-(void)setData:(CommunityNewestData *)data
{
    _data=data;
    self.contentLab.text=data.title;
    
    if(data.imgCount==0)
    {
        self.constraintHeight.constant=0.0;
    }else
    {
        int hang=(data.imgCount-1)/3+1;
        int hangHeight=itemWidht*ratio+CollectionCellViewMargin*2;
        self.constraintHeight.constant=hang*hangHeight;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.postdata.pics.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommunityTableViewCollectionCell_Newest *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSString * imgUrl=self.postdata.pics[indexPath.row];
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Post]];
    return cell;
}

-(void)clickHeadImgandName
{
    if(_block)
    {
        _block(0);
    }
}

- (IBAction)clickThemeBtn:(id)sender {
    if(_block)
    {
        _block(1);
    }
}
@end
