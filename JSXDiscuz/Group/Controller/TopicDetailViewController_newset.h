//
//  TopicDetailViewController_newset.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface TopicDetailViewController_newset : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,strong) NSMutableArray * dataList;
@property(nonatomic,copy) NSString * fid;

@end
