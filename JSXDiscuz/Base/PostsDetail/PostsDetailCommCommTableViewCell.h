//
//  PostsDetailCommCommTableViewCell.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsDetailCommCommTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentLab;

@property(nonatomic,copy) NSString * commentText;

@end
