//
//  PostsDetailContentTableViewCell.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/20.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "PostsDetailContentTableViewCell.h"

#define TextWidth (SDScreenWidth-20)

@implementation PostsDetailContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius=20;
    self.imgV.layer.masksToBounds=YES;
    [self.imgV setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeadImg)];
    [self.imgV addGestureRecognizer:tap];
    [self.nameLab addTarget:self action:@selector(clickHeadImg) forControlEvents:UIControlEventTouchUpInside];
    
    self.focusBtn.layer.cornerRadius=5;
    
    [[self.themeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       if(_clickblock)
       {
           _clickblock();
       }
    }];
}

-(void)clickHeadImg
{
    if(_headblock)
    {
        _headblock();
    }
}

-(void)setContentData:(PostsDetailData_content *)contentData
{
    float height=0.0;
    if(_contentData==nil)
    {
        if(contentData.message.length>0)
        {
            UILabel * textView=[[UILabel alloc]initWithFrame:CGRectMake(0, height+10, TextWidth,[contentData.message heightForWidth:TextWidth])];
            textView.numberOfLines=0;
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:contentData.message attributes:self.typingAttrDict];
            textView.attributedText=attributedText;
            [self.contentBgView addSubview:textView];
            height+=[contentData.message heightForWidth:TextWidth]+20;
        }
        
        for (int i=0; i<contentData.pics.count; i++) {
            NSString * picurl=contentData.pics[i];
            UIImage * placeimage=[UIImage imageNamed:PlaceHolderImg_Post];
            UIImage * image=[UIImage imageWithData:[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:picurl]]];
            UIImageView * imgv=[[UIImageView alloc]init];
            imgv.frame=CGRectMake(0, height+10, TextWidth, TextWidth*(image.size.height/image.size.width)+10);
            [imgv sd_setImageWithURL:[NSURL URLWithString:picurl] placeholderImage:placeimage];
            [self.contentBgView addSubview:imgv];
            height+=TextWidth*(image.size.height/image.size.width)+20;
            
            [imgv setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImg:)];
            objc_setAssociatedObject(imgv,"index",[NSNumber numberWithInt:i],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [imgv addGestureRecognizer:tap];
        }
        
        self.constraintHeight.constant=height;
    }
    
    self.titleLab.text=contentData.subject;
    [self.nameLab setTitle:contentData.author forState:UIControlStateNormal];
    self.timeLab.text=contentData.linedate;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:contentData.uesicon] placeholderImage:[UIImage imageNamed:PlaceHolderImg_Head]];
    if(contentData.replies.length==0||contentData.views.length==0)
    {
        self.readNumLab.text=[NSString stringWithFormat:@"评论0 阅读0"];
    }else
    {
        self.readNumLab.text=[NSString stringWithFormat:@"评论%@ 阅读%@",contentData.replies,contentData.views];
    }
    [self.themeBtn setTitle:contentData.name forState:UIControlStateNormal];
    
    _contentData=contentData;
}

-(NSDictionary *)typingAttrDict
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 字体的行间距
    paragraphStyle.lineSpacing = 5;
    //首行缩进
    paragraphStyle.firstLineHeadIndent = 0;
    //整体缩进(首行除外)
    paragraphStyle.headIndent = 0;
    NSDictionary *attributes = @{NSFontAttributeName:SDFontOf14,NSForegroundColorAttributeName:TextColor,NSParagraphStyleAttributeName:paragraphStyle};
    return attributes;
}


-(void)clickImg:(UITapGestureRecognizer*)tap
{
    NSNumber* index = objc_getAssociatedObject(tap,"index");
    if(_block)
    {
        _block(index.intValue);
    }
}

@end
