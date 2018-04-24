//
//  TopicListTableViewCell_content.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupMainData_summary.h"

@interface TopicListTableViewCell_content : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topicImgV;
@property (weak, nonatomic) IBOutlet UILabel *topicName;

@property (weak, nonatomic) IBOutlet UILabel *topicDesc;

@property(nonatomic,strong)GroupMainData_summary * groupData;

@end
