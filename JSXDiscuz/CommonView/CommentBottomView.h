//
//  CommentBottomView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentBottomView : CommonViewFromXib
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *comment_likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *comment_collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *comment_shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;

@end
