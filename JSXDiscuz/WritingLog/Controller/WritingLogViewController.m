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

@interface WritingLogViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate>
{
    WritingLogTitleView * titleView;
    
    UIView * bodyView;
    WritingLogBodyHeaderView * bodyHeaderView;
    WritingLogBodyFooterView * bodyFooterView;
    WritingLogTextView * bodyTextView;
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UIScrollViewDelegate


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    _lastSelectedRange = NSMakeRange(range.location + text.length - range.length, 0);
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    [self layoutWritingLogViews];
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
        
        if(self.getPhotoFromContent)
        {
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            CGRect rect = CGRectZero;
            rect.size.width = SDScreenWidth/3*2;
            rect.size.height = SDScreenWidth/3*2*theImage.size.height/theImage.size.width;
            textAttachment.bounds = rect;
            textAttachment.image = theImage;
            
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"\n"];
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
        }else
        {
            [self.imagesList addObject:theImage];
            imagesView.imagesList=self.imagesList;
        }
    }
    
    [self layoutWritingLogViews];
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    // 选择的图片信息存储于info字典中
    NSLog(@"imagePickerController:%@", info);
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
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
    bodyTextView.delegate=self;
    [bodyView addSubview:bodyTextView];
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
        vc.htmlStr =[JSXHtmlExportTool HTMLFromAttributedString:bodyTextView.attributedText];
        SDLog(@"vc.htmlStr:%@",vc.htmlStr);
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
