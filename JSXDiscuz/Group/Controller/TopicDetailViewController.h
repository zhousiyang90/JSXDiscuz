//
//  TopicDetailViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface TopicDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *bgview;

@property (weak, nonatomic) IBOutlet UIImageView *topicImgV;
@property (weak, nonatomic) IBOutlet UILabel *topicName;
@property (weak, nonatomic) IBOutlet UILabel *topicNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *topicMemLab;
@property (weak, nonatomic) IBOutlet UILabel *topicDescLab;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIButton *newestBtn;
@property (weak, nonatomic) IBOutlet UIButton *hotestBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property(nonatomic,copy) NSString *fid;

@end
