//
//  PostsDetailCommentTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "PostsDetailCommentTableViewCell.h"
#import "PostsDetailCommCommTableViewCell.h"

@interface PostsDetailCommentTableViewCell()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PostsDetailCommentTableViewCell

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(void)configCell:(PostsDetailCommCommTableViewCell*)cell andIndexPath:(NSIndexPath*)indexpath
{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostsDetailCommCommTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"postsDetailCommCommTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [self configCell:cell andIndexPath:indexPath];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imgV.layer.cornerRadius=15;
    self.imgV.layer.masksToBounds=YES;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"PostsDetailCommCommTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"postsDetailCommCommTableViewCell"];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight=40;
    self.tableview.rowHeight=UITableViewAutomaticDimension;
    self.tableview.layer.cornerRadius=5;
   
}

-(void)setComment:(PostsDetailData_comment *)comment
{
    //暂时关闭子评论
    self.constrainHeight.constant=0.0;
    //[self.tableview reloadData];
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:comment.uesicon] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Head]];
    
    [self.nameBtn setTitle:comment.author forState:UIControlStateNormal];
    self.commentLab.text=comment.message;
    self.timeLab.text=comment.linedate;
}

@end
