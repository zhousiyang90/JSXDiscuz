//
//  WritingLogViewController.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/3/27.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "WritingLogViewController.h"

#import "WritingLogBodyHeaderView.h"
#import "WritingLogBodyFooterView.h"
#import "WritingLogTextView.h"
#import "WritingLogTitleView.h"
#import "WritingLogPositionView.h"
#import "WritingLogUploadImagesView.h"
#import "WritingLogUploadImagesCell.h"
#import "ExportHtmlViewController.h"
#import "WritingLogImageData.h"
#import <Photos/Photos.h>

@interface WritingLogViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate,TZImagePickerControllerDelegate>
{
    WritingLogTitleView * titleView;
    
    UIView * bodyView;
    WritingLogBodyHeaderView * bodyHeaderView;
    WritingLogBodyFooterView * bodyFooterView;
    WritingLogTextView * bodyTextView;
    UILabel *placeHolderLabel;
    NSRange _lastSelectedRange;
    
    WritingLogPositionView * positionView;
    
    UIView * imagesbgView;
    WritingLogUploadImagesView * imagesView;
    
    UIButton * publicBtn;
    
}

@property(nonatomic,strong) NSMutableArray * imagesList;
@property(nonatomic,assign) BOOL hasTitle;
@property(nonatomic,assign) BOOL hasPosition;
@property(nonatomic,assign) BOOL getPhotoFromContent;
@end

@implementation WritingLogViewController

static NSString *const cellId = @"writingLogUploadImagesCell";

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==self.bgScrollView)
    {
        [self.view endEditing:YES];
    }
}

#pragma mark - UITextViewDelegate

-(void)setPlaceHolderLabelHide
{
    if(bodyTextView.attributedText.length>0)
    {
        [placeHolderLabel setHidden:YES];
    }else
    {
        [placeHolderLabel setHidden:NO];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSUInteger location=range.location + text.length - range.length;
    if(range.location+text.length<range.length)
    {
        location=0;
    }
    _lastSelectedRange = NSMakeRange(location,0);

    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    //[self setPlaceHolderLabelHide];
    [self layoutWritingLogViews];
}


#pragma mark - 调用系统视频文件

-(void)openSystemVideoFile
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //判断当前的sourceType是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
            // 设置资源来源（相册、相机、图库之一）
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
            imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
            imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie];
            [imagePickerVC setVideoMaximumDuration:10.f];
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
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
        imagePickerVc.allowTakePicture=NO;
        imagePickerVc.allowPickingVideo=YES;
        imagePickerVc.allowPickingImage=YES;
        [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, id asset) {
            //SDLog(@"coverImage:%@-asset:%@",coverImage,asset);
        }];
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            for (int i=0; i<photos.count; i++) {
                UIImage * img1 = photos[i];
                UIImage * placeHolder = [JSXImageTool composeImg:img1 andimg2:[UIImage imageNamed:@"video_bf"]];
                [self addTextVideoPlaceHolder:placeHolder];
            }
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

#pragma mark - 调用系统相机相册

-(void)openSystemCameraAndAlbum
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
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
        imagePickerVc.allowTakePicture=NO;
        imagePickerVc.allowPickingVideo=NO;
        imagePickerVc.allowPickingImage=YES;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            if(self.getPhotoFromContent)
            {
                for (int i=0; i<photos.count; i++) {
                    UIImage * theImage = photos[i];
                    [self addTextPosition:theImage];
                }
            }else
            {
                for (int i=0; i<photos.count; i++) {
                    UIImage * theImage = photos[i];
                    [self addAlbumPosition:theImage];
                }
            }
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
        
        if(self.getPhotoFromContent)
        {
            [self addTextPosition:theImage];
        }else
        {
            [self addAlbumPosition:theImage];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 对系统相册返回的图片做处理

-(void)saveImageToLocal:(UIImage*)image
{
    
}

-(void)addAlbumPosition:(UIImage*)image
{
    WritingLogImageData * imageData = [[WritingLogImageData alloc]init];
    imageData.image=image;
    [self.imagesList addObject:imageData];
    imagesView.imagesList=self.imagesList;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 实际应用时候可以将存本地的操作改为上传到服务器，URL 也由本地路径改为服务器图片地址。
        NSURL *documentDir = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                    inDomain:NSUserDomainMask
                                                           appropriateForURL:nil
                                                                      create:NO
                                                                       error:nil];
        NSURL *filePath = [documentDir URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%u.png",[NSDate date].description,arc4random()%100]];
        NSData *originImageData = UIImagePNGRepresentation(image);
        if ([originImageData writeToFile:filePath.path atomically:YES]) {
            imageData.filePath = filePath.absoluteString;
           
        }
    });
    [self layoutWritingLogViews];
}

-(void)addTextPosition:(UIImage*)image
{
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    CGRect rect = CGRectZero;
    rect.size.width = bodyTextView.width-30;
    rect.size.height = (bodyTextView.width-30)*image.size.height/image.size.width;
    textAttachment.bounds = rect;
    textAttachment.image = image;
    
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@" "];
    [attributedString insertAttributedString:attachmentString atIndex:0];

    if (_lastSelectedRange.location != 0 &&
            ![[bodyTextView.text substringWithRange:NSMakeRange(_lastSelectedRange.location-1,1)] isEqualToString:@"\n"]) {
            // 上一个字符不为"\n"则图片前添加一个换行 且 不是第一个位置
        [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] atIndex:0];
    }
    
    [attributedString addAttributes:bodyTextView.typingAttributes range:NSMakeRange(0, attributedString.length)];
    NSMutableParagraphStyle *paragraphStyle = bodyTextView.typingAttrDict[NSParagraphStyleAttributeName];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:bodyTextView.attributedText];
    [attributedText replaceCharactersInRange:_lastSelectedRange withAttributedString:attributedString];
    bodyTextView.allowsEditingTextAttributes = YES;
    bodyTextView.attributedText = attributedText;
    bodyTextView.allowsEditingTextAttributes = NO;
    [bodyTextView scrollRangeToVisible:_lastSelectedRange];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 实际应用时候可以将存本地的操作改为上传到服务器，URL 也由本地路径改为服务器图片地址。
        NSURL *documentDir = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                    inDomain:NSUserDomainMask
                                                           appropriateForURL:nil
                                                                      create:NO
                                                                       error:nil];
        NSURL *filePath = [documentDir URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%u.png",[NSDate date].description,arc4random()%100]];
        NSData *originImageData = UIImagePNGRepresentation(textAttachment.image);
        if ([originImageData writeToFile:filePath.path atomically:YES]) {
            textAttachment.attachmentType = ZSTextAttachmentTypeImage;
            textAttachment.localFilePath = filePath.absoluteString;
        }
    });
    
    [self layoutWritingLogViews];
}

-(void)addTextVideoPlaceHolder:(UIImage*)placeHolder
{
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    CGRect rect = CGRectZero;
    rect.size.width = bodyTextView.width-30;
    rect.size.height = (bodyTextView.width-30)*placeHolder.size.height/placeHolder.size.width;
    textAttachment.bounds = rect;
    textAttachment.image = placeHolder;
    
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@" "];
    [attributedString insertAttributedString:attachmentString atIndex:0];
    
    if (_lastSelectedRange.location!= 0 &&
            ![[bodyTextView.text substringWithRange:NSMakeRange(_lastSelectedRange.location-1,1)] isEqualToString:@"\n"]) {
            // 上一个字符不为"\n"则图片前添加一个换行 且 不是第一个位置
        [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] atIndex:0];
    }
    
    [attributedString addAttributes:bodyTextView.typingAttributes range:NSMakeRange(0, attributedString.length)];
    NSMutableParagraphStyle *paragraphStyle = bodyTextView.typingAttrDict[NSParagraphStyleAttributeName];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:bodyTextView.attributedText];
    [attributedText replaceCharactersInRange:_lastSelectedRange withAttributedString:attributedString];
    bodyTextView.allowsEditingTextAttributes = YES;
    bodyTextView.attributedText = attributedText;
    bodyTextView.allowsEditingTextAttributes = NO;
    [bodyTextView scrollRangeToVisible:_lastSelectedRange];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        // 实际应用时候可以将存本地的操作改为上传到服务器，URL 也由本地路径改为服务器图片地址。
//        NSURL *documentDir = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
//                                                                    inDomain:NSUserDomainMask
//                                                           appropriateForURL:nil
//                                                                      create:NO
//                                                                       error:nil];
//        NSURL *filePath = [documentDir URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%u.png",[NSDate date].description,arc4random()%100]];
//        NSData *originImageData = UIImagePNGRepresentation(textAttachment.image);
//        if ([originImageData writeToFile:filePath.path atomically:YES]) {
//            textAttachment.attachmentType = ZSTextAttachmentTypeVideo;
//            textAttachment.localFilePath = filePath.absoluteString;
//        }
//    });
    
    [self layoutWritingLogViews];
}

#pragma mark - Lazy

-(NSMutableArray *)imagesList
{
    if(_imagesList==nil)
    {
        _imagesList=[NSMutableArray array];
    }
    return _imagesList;
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)layoutWritingLogViews
{
    CGFloat bodyViewY=0.0;
    if(self.hasTitle)
    {
        titleView.height=40;
        bodyViewY=50;

    }else
    {
        titleView.height=0;
        bodyViewY=0;
    }
    
    CGFloat textViewHeight = [bodyTextView getArrtTextHeight];
    if(textViewHeight<200)
    {
        textViewHeight=200;
    }
    
    bodyView.frame=CGRectMake(0, bodyViewY, SDScreenWidth, textViewHeight+100);
    bodyHeaderView.frame=CGRectMake(0, 0, SDScreenWidth, 40);
    bodyFooterView.frame=CGRectMake(0, textViewHeight+40, SDScreenWidth, 60);
    bodyTextView.frame=CGRectMake(0, 40, SDScreenWidth, textViewHeight);
    
    CGFloat imgesViewHeight=((self.imagesList.count+1)/5+1)*imagesView.hangHeight+50;
    
    if(self.hasPosition)
    {
        positionView.frame=CGRectMake(0, bodyViewY+textViewHeight+100+1, SDScreenWidth, 40);
        imagesbgView.frame=CGRectMake(0, bodyViewY+textViewHeight+100+1+40+10, SDScreenWidth, imgesViewHeight);
        imagesView.width=SDScreenWidth;
        imagesView.height=imgesViewHeight;
        publicBtn.frame=CGRectMake(10, bodyViewY+textViewHeight+100+1+40+10+imgesViewHeight+10, SDScreenWidth-20, 50);
    }else
    {
        positionView.frame=CGRectMake(0, bodyViewY+textViewHeight+100, SDScreenWidth, 0);
        imagesbgView.frame=CGRectMake(0, bodyViewY+textViewHeight+100+10, SDScreenWidth, imgesViewHeight);
        imagesView.width=SDScreenWidth;;
        imagesView.height=imgesViewHeight;
        publicBtn.frame=CGRectMake(10, bodyViewY+textViewHeight+100+10+imgesViewHeight+10, SDScreenWidth-20, 50);
    }
    
    self.bgScrollView.contentSize=CGSizeMake(SDScreenWidth, bodyViewY+textViewHeight+100+10+imgesViewHeight+10+50+50);
}


-(void)addSubViews
{
    titleView=[WritingLogTitleView shareView];
    titleView.frame=CGRectMake(0, 10, SDScreenWidth, 40);
    [[titleView.titleField rac_textSignal]subscribeNext:^(id x) {
        
    }];
    [self.bgScrollView addSubview:titleView];
    
    bodyView=[[UIView alloc]init];
    bodyView.backgroundColor=[UIColor whiteColor];
    
    bodyTextView=[[WritingLogTextView alloc]init];
    bodyTextView.bounces=NO;
    bodyTextView.delegate=self;
    bodyTextView.scrollEnabled=NO;
    [bodyView addSubview:bodyTextView];
    
    placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
    placeHolderLabel.text = @"请输入帖子内容";
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    placeHolderLabel.font = SDFontOf15;
    //[bodyTextView addSubview:placeHolderLabel];
    
    bodyHeaderView=[WritingLogBodyHeaderView shareView];
    [bodyView addSubview:bodyHeaderView];
    bodyFooterView=[WritingLogBodyFooterView shareView];
    [bodyView addSubview:bodyFooterView];
    [self.bgScrollView addSubview:bodyView];
    
    positionView=[WritingLogPositionView shareView];
    [self.bgScrollView addSubview:positionView];
    
    imagesbgView=[[UIView alloc]init];
    [self.bgScrollView addSubview:imagesbgView];
    
  
    imagesView=[WritingLogUploadImagesView shareView];
    imagesView.imagesList=self.imagesList;
    [imagesbgView addSubview:imagesView];
    @weakify(self)
    @weakify(imagesView)
    imagesView.block = ^(NSIndexPath * indexPath) {
        @strongify(self)
        @strongify(imagesView)
        if(indexPath.row==self.imagesList.count)
        {
            if(self.imagesList.count>=9)
            {
                [SVProgressHUD showErrorWithStatus:@"最多添加9张"];
                return;
            }
            self.getPhotoFromContent=NO;
            [self openSystemCameraAndAlbum];
        }else
        {
            [self.imagesList removeObjectAtIndex:indexPath.row];
            imagesView.imagesList=self.imagesList;
            [self layoutWritingLogViews];
        }
    };
    
    publicBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [publicBtn setTitle:@"发表帖子" forState:UIControlStateNormal];
    publicBtn.layer.cornerRadius=8;
    publicBtn.titleLabel.font=SDFontOf17;
    [publicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publicBtn.backgroundColor=ThemeColor;
    [[publicBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        ExportHtmlViewController * vc = [[ExportHtmlViewController alloc]init];
        NSMutableString * htmlStr1 =[JSXHtmlExportTool HTMLFromAttributedString:bodyTextView.attributedText];
        NSMutableString * htmlStr2 =[JSXHtmlExportTool HTMLFromImageDatas:self.imagesList];
        [htmlStr1 appendString:htmlStr2];
        vc.htmlStr=htmlStr1;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.bgScrollView addSubview:publicBtn];
    
    [[bodyFooterView rac_signalForSelector:@selector(clickAddTitleBtn:)]subscribeNext:^(id x) {
        @strongify(self)
        bodyFooterView.addTitleBtn.selected=!bodyFooterView.addTitleBtn.selected;
        self.hasTitle=bodyFooterView.addTitleBtn.selected;
        [self layoutWritingLogViews];
    }];
    [[bodyFooterView rac_signalForSelector:@selector(clickAddImageBtn:)]subscribeNext:^(id x) {
        self.getPhotoFromContent=YES;
        [self openSystemCameraAndAlbum];
    }];
    [[bodyFooterView rac_signalForSelector:@selector(clickAddVideoBtn:)]subscribeNext:^(id x) {
        [self openSystemVideoFile];
    }];
    
    [[bodyFooterView rac_signalForSelector:@selector(clickAddPositionBtn:)]subscribeNext:^(id x) {
        @strongify(self)
        bodyFooterView.addPositionBtn.selected=!bodyFooterView.addPositionBtn.selected;
        self.hasPosition=bodyFooterView.addPositionBtn.selected;
        [self layoutWritingLogViews];
    }];
    
    [self layoutWritingLogViews];
    
    self.needNoNetTips=NO;
    self.needNoTableViewDataTips=NO;
}


-(void)setNavigationBar
{
    self.navigationController.navigationBar.hidden=NO;
    self.title=@"发表";
}

@end
