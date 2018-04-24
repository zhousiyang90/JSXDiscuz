//
//  CommunityCollectionViewCell_Album.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CommunityCollectionViewCell_Album.h"

@implementation CommunityCollectionViewCell_Album

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPostdata:(CommunityPostsData *)postdata
{
    _postdata=postdata;
    if(postdata.pics.count>0)
    {
        [self.imgV sd_setImageWithURL:[NSURL URLWithString:postdata.pics[0]] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Post]];
    }
    self.titleLab.text=postdata.subject;
}

@end
