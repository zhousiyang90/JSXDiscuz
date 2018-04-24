//
//  PostsDetailCommentViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^PostsDetailCommentViewControllerBlock)(void);

@interface PostsDetailCommentViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property(nonatomic,copy) NSString * tid;
@property(nonatomic,copy) NSString * fid;
@property(nonatomic,copy) NSString * subject;

@property(nonatomic,copy) PostsDetailCommentViewControllerBlock block;

@end
