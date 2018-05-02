//
//  NearByPersonViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "BaseViewController.h"

@interface NearByPersonViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,copy) NSString* username;
@property(nonatomic,copy) NSString* gender;
@property(nonatomic,copy) NSString* affectivestatus;
@property(nonatomic,copy) NSString* lookingfor;
@property(nonatomic,copy) NSString* education;
@property(nonatomic,copy) NSString* revenue;
@property(nonatomic,copy) NSString* age;

@property(nonatomic,copy) NSString* navTitle;

@end
