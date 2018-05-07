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
#import "CommunityDetailViewController.h"
#import "TopicDetailViewController.h"

@interface PostsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL hasRead;
    
    CommentBottomView * bottom;
}
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
        //点击图片
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
        //点击主题
        cell.clickblock = ^{
            TopicDetailViewController *vc=[[TopicDetailViewController alloc]init];
            vc.fid=self.currentData.pinfo.fid;
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        //点击头像和名称
        cell.headblock = ^{
            [self pushToOtherPersonalCenter:self.currentData.pinfo.authorid];
        };
        return cell;
    }else
    {
        PostsDetailData_comment *cellData=self.currentData.hpost[indexPath.row-1];
        PostsDetailCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"postsDetailCommentTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.comment=cellData;
        //评论头像和姓名
        cell.block = ^{
            [self pushToOtherPersonalCenter:self.currentData.pinfo.authorid];
        };
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
    
    bottom=[CommentBottomView shareView];
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
        [self likeInterface];
    }];
    
    [[bottom.comment_collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if([self.currentData.shoucsun isEqualToString:@"0"])
        {
            [self collectionInterface];
        }else
        {
            [self decollectionInterface];
        }
    }];
    
    [[bottom.comment_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self hasReadPost];
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
    
    [self getPostData];
    [self verifyHasReadPost];
}

-(void)nonetstatusGetData
{
    [self getInitData];
}

#pragma mark - 网络访问

-(void)getPostData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tid"]=self.tid;
    params[@"fid"]=self.fid;
    if([UserDataTools getUserInfo].uid.length==0)
    {
        [self showLoginView];
        return;
    }else
    {
        params[@"uid"]=[UserDataTools getUserInfo].uid;
    }
    [SVProgressHUD showWithStatus:@"加载中..."];
    [JSXHttpTool Post:Interface_PostsDetail params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * returnMes = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            self.currentData=[PostDetailData mj_objectWithKeyValues:json];
            self.title=self.currentData.pinfo.subject;
            
            //点赞
            if([self.currentData.usezan isEqualToString:@"0"])
            {
                bottom.likeLab.hidden=YES;
                bottom.comment_likeBtn.selected=NO;
            }else
            {
                bottom.likeLab.hidden=NO;
                bottom.likeLab.text=self.currentData.zan;
                bottom.comment_likeBtn.selected=YES;
            }
            
            //收藏
            if([self.currentData.shoucsun isEqualToString:@"0"])
            {
                bottom.comment_collectBtn.selected=NO;
            }else
            {
                bottom.comment_collectBtn.selected=YES;
            }
            
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

-(void)likeInterface
{
    if(self.tid.length==0 ||self.fid.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"参数为空"];
        return;
    }
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tid"]=self.tid;
    params[@"uid"]=[UserDataTools getUserInfo].uid;
    
    [JSXHttpTool Post:Interface_PostsLike params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * returnMes = json[@"errmsg"];
        
        if([self.currentData.usezan isEqualToString:@"0"])
        {
            if([returnCode intValue]==0)
            {
                bottom.comment_likeBtn.selected=YES;
                [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
                [self getPostData];
            }else
            {
                bottom.comment_likeBtn.selected=NO;
                [SVProgressHUD showErrorWithStatus:returnMes];
            }
        }else
        {
            if([returnCode intValue]==0)
            {
                bottom.comment_likeBtn.selected=NO;
                [SVProgressHUD showSuccessWithStatus:@"取消点赞成功"];
                [self getPostData];
            }else
            {
                bottom.comment_likeBtn.selected=YES;
                [SVProgressHUD showErrorWithStatus:returnMes];
            }
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
    }];
}

-(void)collectionInterface
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tid"]=self.tid;
    params[@"uid"]=[UserDataTools getUserInfo].uid;
    
    [JSXHttpTool Post:Interface_PostsCollection params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * errmsg = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            bottom.comment_collectBtn.selected=YES;
            [self getPostData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:errmsg];
            bottom.comment_collectBtn.selected=NO;
        }
    } failure:^(NSError *error) {
    }];
}

-(void)decollectionInterface
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tid"]=self.tid;
    params[@"uid"]=[UserDataTools getUserInfo].uid;
    
    [JSXHttpTool Post:Interface_PostsDeCollection params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * errmsg = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
            bottom.comment_collectBtn.selected=NO;
            [self getPostData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:errmsg];
            bottom.comment_collectBtn.selected=YES;
        }
    } failure:^(NSError *error) {
    }];
}

-(void)verifyHasReadPost
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tid"]=self.tid;
    params[@"uid"]=[UserDataTools getUserInfo].uid;
    
    [JSXHttpTool Post:Interface_PostsHasRead params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * errmsg = json[@"errmsg"];
        NSString * sun = json[@"sun"];
        if([returnCode intValue]==0)
        {
            if([sun isEqualToString:@"0"])
            {
                hasRead=NO;
                bottom.comment_shareBtn.selected=NO;
            }else
            {
                hasRead=YES;
                bottom.comment_shareBtn.selected=YES;
            }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:errmsg];
        }
        } failure:^(NSError *error) {
        }];
}

-(void)hasReadPost
{
    if(!hasRead)
    {
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"tid"]=self.tid;
        params[@"fid"]=self.fid;
        params[@"uid"]=[UserDataTools getUserInfo].uid;
        params[@"subject"]=@" ";
        params[@"message"]=@"已阅";
    
        [JSXHttpTool Post:Interface_PostsRead params:params success:^(id json) {
            NSNumber * returnCode = json[@"errcode"];
            NSString * errmsg = json[@"errmsg"];
            if([returnCode intValue]==0)
            {
                [self getInitData];
                [self.tableview reloadData];
            }else
            {
                [SVProgressHUD showErrorWithStatus:errmsg];
            }
        } failure:^(NSError *error) {
        }];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"已阅该帖子"];
    }
}

@end
