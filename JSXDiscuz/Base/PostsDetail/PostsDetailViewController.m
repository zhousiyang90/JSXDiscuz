//
//  PostsDetailViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "PostsDetailViewController.h"
#import "PostsDetailContentTableViewCell.h"
#import "PostsDetailCommentTableViewCell.h"
#import "CommentBottomView.h"
#import "PostsDetailCommentViewController.h"
#import "PostDetailData.h"

@interface PostsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) PostDetailData * currentData;

@end

@implementation PostsDetailViewController

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentData.hpost.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        PostsDetailContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"postsDetailContentTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentData=self.currentData.pinfo;
        cell.block = ^(int imgIndex) {
            NSMutableArray * photos=[NSMutableArray array];
            for (NSString * picurl in self.currentData.pinfo.pics) {
                MWPhoto * photo=[[MWPhoto alloc]initWithURL:[NSURL URLWithString:picurl]];
                [photos addObject:photo];
            }
            MWPhotoBrowser * brower=[[MWPhotoBrowser alloc]initWithPhotos:photos];
            brower.displayActionButton=NO;
            [brower setCurrentPhotoIndex:imgIndex];
            [self.navigationController pushViewController:brower animated:YES];
        };
        return cell;
    }else
    {
        PostsDetailData_comment *cellData=self.currentData.hpost[indexPath.row-1];
        PostsDetailCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"postsDetailCommentTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.comment=cellData;
        return cell;
    }
    
}


#pragma mark - LazyLoad


#pragma mark - 生命周期

-(void)addSubViews
{
    [self.tableview registerNib:[UINib nibWithNibName:@"PostsDetailContentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"postsDetailContentTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"PostsDetailCommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"postsDetailCommentTableViewCell"];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight=200;
    self.tableview.rowHeight=UITableViewAutomaticDimension;
    
    self.needNoNetTips=YES;
    self.needNoTableViewDataTips=YES;
    self.baseTableview=self.tableview;
    
    CommentBottomView * bottom=[CommentBottomView shareView];
    bottom.frame=self.bgBottomView.bounds;
    [[bottom.commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        PostsDetailCommentViewController *vc=[[PostsDetailCommentViewController alloc]init];
        vc.tid=self.currentData.pinfo.tid;
        vc.fid=self.currentData.pinfo.fid;
        vc.subject=self.currentData.pinfo.subject;
        vc.block = ^{
            //回帖成功
            [self getInitData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[bottom.comment_likeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        bottom.comment_likeBtn.selected=!bottom.comment_likeBtn.selected;
    }];
    
    [[bottom.comment_collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        bottom.comment_collectBtn.selected=!bottom.comment_collectBtn.selected;
    }];
    
    [self.bgBottomView addSubview:bottom];
}

-(void)getInitData
{
    if(self.tid.length==0 ||self.fid.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"参数为空"];
        return;
    }
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tid"]=self.tid;
    params[@"fid"]=self.fid;
    params[@"uid"]=@"11";
    [JSXHttpTool Post:Interface_PostsDetail params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * returnMes = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.currentData=[PostDetailData mj_objectWithKeyValues:json];
            self.title=self.currentData.pinfo.subject;
            [self.tableview reloadData];
            [SVProgressHUD dismiss];
        }else
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:returnMes];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
    }];
}

-(void)nonetstatusGetData
{
    [self getInitData];
}

@end
