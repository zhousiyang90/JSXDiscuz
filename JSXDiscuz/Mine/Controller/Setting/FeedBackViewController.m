//
//  FeedBackViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/9.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

-(void)addSubViews
{
    UITapGestureRecognizer * tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview1)];
    [self.bgview1 setUserInteractionEnabled:YES];
    [self.bgview1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbgview2)];
    [self.bgview2 setUserInteractionEnabled:YES];
    [self.bgview2 addGestureRecognizer:tap2];
    
    self.img1.hidden=YES;
    self.img2.hidden=YES;
}

-(void)setNavigationBar
{
    self.title=@"反馈";
}

-(void)clickbgview1
{
    self.img1.hidden=NO;
    self.img2.hidden=YES;
}

-(void)clickbgview2
{
    self.img1.hidden=YES;
    self.img2.hidden=NO;
}

- (IBAction)clickCommit:(id)sender {
}
@end
