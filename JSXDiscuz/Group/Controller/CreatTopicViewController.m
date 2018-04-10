//
//  CreatTopicViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CreatTopicViewController.h"

@interface CreatTopicViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    ZSPickerView * picker;
    
    NSString * topicStr;
}
@property(nonatomic,strong) NSMutableArray * topicArr;

@end

@implementation CreatTopicViewController

-(void)addSubViews
{
    self.topicBtn.layer.cornerRadius=5;
    [[self.topictf rac_textSignal]subscribeNext:^(id x) {
        
    }];
    [[self.desctv rac_textSignal]subscribeNext:^(id x) {
        
    }];
    [[self.topicBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
    }];
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktopicview)];
    [self.toppicview setUserInteractionEnabled:YES];
    [self.toppicview addGestureRecognizer:tap];
    
    UITapGestureRecognizer * tapimg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktopicimage)];
    [self.topicImgV setUserInteractionEnabled:YES];
    [self.topicImgV addGestureRecognizer:tapimg];
}

-(void)setNavigationBar
{
    self.title=@"创建话题";
}


#pragma mark - LazyLoad

-(NSMutableArray *)topicArr
{
    if(_topicArr==nil)
    {
        _topicArr=[NSMutableArray array];
        [_topicArr addObject:@"科学技术"];
        [_topicArr addObject:@"数码"];
        [_topicArr addObject:@"情感"];
        [_topicArr addObject:@"人文自然"];
        [_topicArr addObject:@"地区"];
        [_topicArr addObject:@"学校"];
        [_topicArr addObject:@"兴趣"];
        [_topicArr addObject:@"休闲"];
        [_topicArr addObject:@"游戏"];
        [_topicArr addObject:@"动漫"];
        [_topicArr addObject:@"小说"];
    }
    return _topicArr;
}

-(void)clicktopicview
{
    picker=[[ZSPickerView alloc]init];
    picker.originArray=self.topicArr;
    @weakify(self);
    picker.block = ^(NSInteger index) {
        @strongify(self);
        topicStr=self.topicArr[index];
        self.topicLab.text=self.topicArr[index];
    };
}

-(void)clicktopicimage
{
    [self openSystemCameraAndAlbum];
}

#pragma mark - 调用系统相机相册

-(void)openSystemCameraAndAlbum
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertAction * alBumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 判断当前的sourceType是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
            // 设置资源来源（相册、相机、图库之一）
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
            // 如果选择的是视屏，允许的视屏时长为20秒
            imagePickerVC.videoMaximumDuration = 20;
            // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
            imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
            imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
            // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
            imagePickerVC.delegate = self;
            // 是否允许编辑（YES：图片选择完成进入编辑模式）
            imagePickerVC.allowsEditing = NO;
            // model出控制器
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }
        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cameraAction];
    [alertController addAction:alBumAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        //压缩图片
        NSData *data = UIImageJPEGRepresentation(theImage, 0.2);
        UIImage *resultImage = [UIImage imageWithData:data];
        self.topicImgV.image=resultImage;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
