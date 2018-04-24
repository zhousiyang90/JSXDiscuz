//
//  CommunityDetailViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/11.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIImageView *topicImgV;
@property (weak, nonatomic) IBOutlet UILabel *topicName;
@property (weak, nonatomic) IBOutlet UILabel *topicNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *topicMemLab;
@property (weak, nonatomic) IBOutlet UILabel *topicDescLab;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *indexscrollview;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property(nonatomic,copy) NSString * fid;

@end
