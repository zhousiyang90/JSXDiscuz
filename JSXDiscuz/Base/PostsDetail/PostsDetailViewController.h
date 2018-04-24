//
//  PostsDetailViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface PostsDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *bgBottomView;

@property(nonatomic,copy) NSString * tid;
@property(nonatomic,copy) NSString * fid;

@end
