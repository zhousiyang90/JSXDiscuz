//
//  PostsDetailCommentViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/23.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "PostsDetailCommentViewController.h"

@interface PostsDetailCommentViewController ()

@end

@implementation PostsDetailCommentViewController

-(void)addSubViews
{
    self.commitBtn.layer.cornerRadius=5;
    [[self.commitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        if(self.tid.length==0||self.fid.length==0)
        {
            [SVProgressHUD showErrorWithStatus:@"参数为空"];
            return;
        }
        [SVProgressHUD showWithStatus:@"回帖中..."];
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"tid"]=self.tid;
        params[@"fid"]=self.fid;
        params[@"subject"]=self.subject;
        params[@"uid"]=@"11";
        params[@"message"]=self.textview.text;
        [JSXHttpTool Get:Interface_PostsReply params:params success:^(id json) {
            NSNumber * returnCode = json[@"errcode"];
            NSString * returnMes = json[@"errmsg"];
            if([returnCode intValue]==0)
            {
                if(self.block)
                {
                    self.block();
                }
                [self.navigationController popViewControllerAnimated:YES];
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
        
    }];
}

-(void)setNavigationBar
{
    self.title=@"回帖";
}

@end
