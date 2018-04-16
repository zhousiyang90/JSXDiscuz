//
//  MineLogoutTableView.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/3.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineLogoutTableViewBlock)(void);

@interface MineLogoutTableView : UITableViewCell

@property(nonatomic,copy)MineLogoutTableViewBlock block;
- (IBAction)clickLogout:(id)sender;

@end
