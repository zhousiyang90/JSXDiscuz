//
//  TableViewOfRefreshFooterView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewOfRefreshFooterView : CommonViewFromXib

@property (weak, nonatomic) IBOutlet UIView *bgview;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadview;

@end
