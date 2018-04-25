//
//  NoNetView.h
//  SOM
//
//  Created by 周思扬 on 2017/6/8.
//  Copyright © 2017年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoNetViewDelegate <NSObject>

-(void)nonetstatusGetData;

@end

@interface NoNetView : UIView

@property (weak, nonatomic) IBOutlet UILabel *refresh;

+(instancetype)getView;

@property(nonatomic,weak) id<NoNetViewDelegate> delegate;

@end
