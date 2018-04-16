//
//  BaseViewController.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//是否需要无网络连接提醒
@property(nonatomic,assign) BOOL needNoNetTips;

//是否需要TableView空数据提醒
@property(nonatomic,assign) BOOL needNoTableViewDataTips;

//如果BaseView是TableView，那么传递数据给baseTableview
@property(nonatomic,weak) UITableView * baseTableview;
@property (nonatomic, copy) NSString *noDataString;
@property (nonatomic, copy) NSString *noDataImage;

//设置导航条
-(void)setNavigationBar;
//添加子页面
-(void)addSubViews;
//获取初始化的数据
-(void)getInitData;
//注册通知
-(void)registerNotification;
//无网络状态下的获取数据
-(void)nonetstatusGetData;
@end
