//
//  UIViewController+Login.h
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/25.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PhotosBlock)(NSArray*);

@interface UIViewController (Login)<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate,TZImagePickerControllerDelegate>

-(void)showLoginView;

-(void)showSystemPhotos:(PhotosBlock)block;

@end
