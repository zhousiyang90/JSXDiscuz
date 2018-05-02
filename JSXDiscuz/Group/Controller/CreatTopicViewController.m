//
//  CreatTopicViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/10.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "CreatTopicViewController.h"
#import "GroupMainData.h"
#import "NSString+Hash.h"

@interface CreatTopicViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    ZSPickerView * picker;
    
    NSString * topicTitle;
    NSString * topicDesc;
    NSString * topicStr;
    NSString * topicTypeId;
    UIImage * resImg;
    
    GroupMainData * data;
}
@property(nonatomic,strong) NSMutableArray * topicArr;

@end

@implementation CreatTopicViewController

-(void)addSubViews
{
    self.topicBtn.layer.cornerRadius=5;
    [[self.topictf rac_textSignal]subscribeNext:^(id x) {
        topicTitle=x;
    }];
    [[self.desctv rac_textSignal]subscribeNext:^(id x) {
        topicDesc=x;
    }];
    [[self.topicBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self createTopic];
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

-(void)getInitData
{
    [self getTypeData];
}


#pragma mark - LazyLoad

-(NSMutableArray *)topicArr
{
    if(_topicArr==nil)
    {
        _topicArr=[NSMutableArray array];
    }
    return _topicArr;
}

-(void)clicktopicview
{
    if(self.topicArr.count==0)
    {
        [SVProgressHUD showErrorWithStatus:@"无分类数据"];
        return;
    }
    
    picker=[[ZSPickerView alloc]init];
    picker.originArray=self.topicArr;
    @weakify(self);
    @weakify(data);
    picker.block = ^(NSInteger index) {
        @strongify(self);
        @strongify(data);
        topicStr=self.topicArr[index];
        GroupMainData_summary * detailData=data.alllist[index];
        topicTypeId=detailData.fid;
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
        resImg=resultImage;
        self.topicImgV.image=resultImage;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 网络访问

-(void)getTypeData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"uid"]=[UserDataTools getUserInfo].uid;
    params[@"gcid"]=@"3";
    
    [JSXHttpTool Get:Interface_GroupAllList params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            data = [GroupMainData mj_objectWithKeyValues:json];
            for (GroupMainData_summary *detailData in data.alllist) {
                [self.topicArr addObject:detailData.name];
            }
        }else
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
    }];
}

-(void)createTopic
{
    /*
    NSData * iData = UIImageJPEGRepresentation(resImg, 0.2);
    NSString * testStr = [iData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"原始字符串:%@",testStr);
    NSString *testencryption=[LCdes lcEncryUseDES:testStr];
    NSLog(@"加密后的的字符串:%@",testencryption);
    NSString *testdecryption=[LCdes lcDecryUseDES:testencryption];
    NSLog(@"解密后的字符串:%@",testdecryption);
    NSLog(@"------------END");
    
    NSString *desa=[DES encryptUseDES:testStr key:@"636d82b614235f1bcfd08969"];
    SDLog(@"加密:%@",desa);
    NSString *desab=[DES decryptUseDES:desa key:@"636d82b614235f1bcfd08969"];
    SDLog(@"解密:%@",desab);
    NSLog(@"------------END2");
    
    NSString *encodeStr=[NSString encrypt3DES:testStr withKey:@"636d82b614235f1bcfd08969"];
    SDLog(@"3加密:%@",encodeStr);
    NSString *decodeStr=[NSString decrypt3DES:encodeStr withKey:@"636d82b614235f1bcfd08969"];
    SDLog(@"3解密:%@",decodeStr);
    NSLog(@"------------END3");
    
    return;
    */
    
    if(topicTitle.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请添加话题名称"];
        return;
    }
    
    if(topicTypeId.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择话题类别"];
        return;
    }
    
    if(topicDesc.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请添加话题简介"];
        return;
    }
    
    if(resImg==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择话题封面"];
        return;
    }
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"uid"]=[UserDataTools getUserInfo].uid;
    params[@"fid"]=topicTypeId;
    params[@"subject"]=topicTitle;
    params[@"message"]=topicDesc;
    
    NSData * imageData = UIImageJPEGRepresentation(resImg, 1.0f);
    NSString * imageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *encryptionString=[NSString encrypt3DES:imageStr withKey:@"636d82b614235f1bcfd08969"];
    params[@"imgres"]=[NSArray arrayWithObject:encryptionString];
    
    [SVProgressHUD showWithStatus:@"发布中..."];
    [JSXHttpTool Post:Interface_GroupCreate params:params success:^(id json) {
        NSNumber * returnCode = json[@"errcode"];
        NSString * message = json[@"errmsg"];
        if([returnCode intValue]==0)
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"创建话题成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    }];
}

@end
