//
//  FeedBackViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface FeedBackViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *bgview1;
@property (weak, nonatomic) IBOutlet UIView *bgview2;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;

@property (weak, nonatomic) IBOutlet UITextView *textview;

- (IBAction)clickCommit:(id)sender;

@end
