//
//  TopicListViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface TopicListViewController : BaseViewController

@property(nonatomic,assign) NSInteger currentPage;

@property (weak, nonatomic) IBOutlet UITableView *indextableview;
@property (weak, nonatomic) IBOutlet UITableView *contenttableview;
@end
