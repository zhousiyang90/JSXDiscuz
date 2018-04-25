//
//  UIViewController+Login.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/25.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "UIViewController+Login.h"

@implementation UIViewController (Login)

-(void)showLoginView
{
    if([UserDataTools getUserInfo].uid.length==0)
    {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"登录"message:@"登录后才能查看"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController * vc=[LoginViewController shareLoginViewController];
            [self presentViewController:vc animated:vc completion:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:sureAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

-(void)showSystemPhotos:(PhotosBlock)block
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //判断当前的sourceType是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
            // 设置资源来源（相册、相机、图库之一）
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
            imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
            imagePickerVC.mediaTypes = @[(NSString *)kUTTypeImage];
            // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
            imagePickerVC.delegate = self;
            // 是否允许编辑（YES：图片选择完成进入编辑模式）
            imagePickerVC.allowsEditing = NO;
            // model出控制器
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"相机不可用"];
        }
    }];
    
    UIAlertAction * alBumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        imagePickerVc.allowTakePicture=NO;
        imagePickerVc.allowPickingVideo=NO;
        imagePickerVc.allowPickingImage=YES;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            block(photos);
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cameraAction];
    [alertController addAction:alBumAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
