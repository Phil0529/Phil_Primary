//
//  UploadPicsView.m
//  Primary
//
//  Created by Phil Xhc on 15/10/27.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "UploadPicsView.h"
#import "EZPhilImageView.h"
#import "FSMediaPicker.h"
#import "UIImage+Color.h"

@class FSMediaPicker;

#define DESCRIBTION_HEIGHT 160.f
#define THUMB_SPACING 15.f
#define BTNADD_WIDITH (SCREEN_WIDTH - THUMB_SPACING * 5)/4
#define LOCAVIEW_HEIGHT 44.f

#define UPLOAD_IMAGE_THUMBIMAGE_TAG 3100
#define UPLOAD_IMAGE_REMOVEBTN_TAG 3200

@interface UploadPicsView ()<UITextViewDelegate>
{
    UILabel *_textPlaceholderLabel;
}

@end

@implementation UploadPicsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _firstBgView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width,DESCRIBTION_HEIGHT)];
        _firstBgView.backgroundColor = COLORFORRGB(0xffffff);
        [self addSubview:_firstBgView];
        
        _textDescView = [[UITextView alloc]initWithFrame:CGRectMake(2 * THUMB_SPACING, 0.f, self.frame.size.width - 40.f,CGRectGetHeight(_firstBgView.frame) - THUMB_SPACING)];
        _textDescView.font = FONT(14.5);
        _textDescView.backgroundColor = COLORFORRGB(0xffffff);
        _textDescView.returnKeyType = UIReturnKeyDone;
        _textDescView.textAlignment = NSTextAlignmentJustified;
        _textDescView.selectedRange = NSMakeRange(0, 0);
        _textDescView.delegate = self;
        [_firstBgView addSubview:_textDescView];
        
        _textPlaceholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_textDescView.frame) + 3.f, CGRectGetMinY(_textDescView.frame) + THUMB_SPACING, _textDescView.frame.size.width, 14.5f)];
        _textPlaceholderLabel.text = @"简介内容不少于五个字";
        _textPlaceholderLabel.font = FONT(14.5);
        
        _textPlaceholderLabel.textColor = COLORFORRGB(0x949494);
        [_firstBgView addSubview:_textPlaceholderLabel];
        
        
        
        UIView *firstLine = [[UIView alloc]initWithFrame:CGRectMake(THUMB_SPACING, CGRectGetMaxY(_firstBgView.frame) - 1.f,self.frame.size.width - 2 * THUMB_SPACING , 1.f)];
        firstLine.backgroundColor = COLORFORRGB(0xd0d0d0);
        [_firstBgView addSubview:firstLine];
        
        _secondBgView = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(_firstBgView.frame), self.frame.size.width, BTNADD_WIDITH + 2 * THUMB_SPACING - 1.f)];
        _secondBgView.backgroundColor = COLORFORRGB(0xffffff);
        [self addSubview:_secondBgView];
        
        _addBtn = [UIButton buttonWithType:0];
        _addBtn.frame = CGRectMake(THUMB_SPACING, THUMB_SPACING, BTNADD_WIDITH, BTNADD_WIDITH);
        [_addBtn setBackgroundImage:IMAGE(@"add_upvc") forState:0];
        [_addBtn addTarget:self action:@selector(addImageClick:) forControlEvents:1<<6];
        [_secondBgView addSubview:_addBtn];
        
        _statementView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_addBtn.frame) + 5.f, CGRectGetHeight(_addBtn.frame)/2 + THUMB_SPACING - THUMB_SPACING*3/2, 240.f, THUMB_SPACING * 3)];
        [_secondBgView addSubview:_statementView];
        
        UILabel *statementLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0.f,0.f,240.f, THUMB_SPACING)];
        statementLabel1.text = @"您可以添加照片(最多8张)";
        statementLabel1.textColor = COLORFORRGB(0x747474);
        [statementLabel1 setFont:[UIFont systemFontOfSize:12.f]];
        [_statementView addSubview:statementLabel1];
        
        UILabel *statementLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0.f,THUMB_SPACING,240.f, 12.f)];
        statementLabel2.text = @"或者添加一段视频(最多1段)";
        statementLabel2.textColor = COLORFORRGB(0x747474);
        [statementLabel2 setFont:[UIFont systemFontOfSize:12.f]];
        [_statementView addSubview:statementLabel2];
        
        UILabel *statementLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0.f,THUMB_SPACING * 2,240.f, THUMB_SPACING)];
        statementLabel3.text = @"照片和视频一次上传只能有一种类型。";
        statementLabel3.textColor = COLORFORRGB(0x747474);
        [statementLabel3 setFont:[UIFont systemFontOfSize:12.f]];
        [_statementView addSubview:statementLabel3];
        
        
        _thirdBgView = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(_secondBgView.frame), self.frame.size.width, LOCAVIEW_HEIGHT)];
        _thirdBgView.backgroundColor = COLORFORRGB(0xffffff);
        [self addSubview:_thirdBgView];
        
        UIView *secondLine = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f,self.frame.size.width  , 1.f)];
        secondLine.backgroundColor = COLORFORRGB(0xd0d0d0);
        [_thirdBgView addSubview:secondLine];
        
        UIView *thirdLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetHeight(_thirdBgView.frame) - 1.f, CGRectGetWidth(_thirdBgView.frame), 1.f)];
        thirdLine.backgroundColor = COLORFORRGB(0xd0d0d0);
        [_thirdBgView addSubview:thirdLine];
        //
        _locaImgView = [[UIImageView alloc] initWithImage:IMAGE(@"locationlogo_upvc")];
        _locaImgView.center = CGPointMake(THUMB_SPACING + 8.f, LOCAVIEW_HEIGHT/2);
        [_thirdBgView addSubview:_locaImgView];
        //
        _locaLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_locaImgView.frame) + THUMB_SPACING, 0.f, _thirdBgView.frame.size.width - CGRectGetMaxX(_locaImgView.frame) - THUMB_SPACING , _thirdBgView.frame.size.height)];
        _locaLabel.text = @"正在加载";
        _locaLabel.font = FONT(14.5);
        [_thirdBgView addSubview:_locaLabel];
        //
        //
        //
        _fourthBgView = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(_thirdBgView.frame), SCREEN_WIDTH, 200.f)];
        [_fourthBgView setBackgroundColor:BACKGROUND_COLOR];
        [self addSubview:_fourthBgView];
        //
        _checkBtn = [UIButton buttonWithType:0];
        _checkBtn.frame = CGRectMake(5.f, 0.f, 40.f, 40.f);
        [_checkBtn setImage:IMAGE(@"check_upload_upvc") forState:0];
        [_checkBtn setImage:IMAGE(@"check_upload_ok_upvc") forState:1<<2];
        [_checkBtn addTarget:self action:@selector(clickOnCheckStatement:) forControlEvents:1<<6];
        [_fourthBgView addSubview:_checkBtn];
        //
        //
        //
        _agreementLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_checkBtn.frame), CGRectGetMinY(_checkBtn.frame), 101.5f, 40.f)];
        _agreementLabel.font = FONT(14.5f);
        [_agreementLabel setTextColor:COLORFORRGB(0x949494)];
        _agreementLabel.text = @"我已阅读并接受";
        [_fourthBgView addSubview:_agreementLabel];
        //
        _showAgreementLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_agreementLabel.frame), CGRectGetMinY(_checkBtn.frame), SCREEN_WIDTH - 160.f, 40.f)];
        _showAgreementLabel.text = @"《上传协议》。";
        _showAgreementLabel.font = FONT(14.5f);
        [_showAgreementLabel setTextColor: COLORFORRGB(0x212121)];
        [self setUserInteractionEnabled:YES];
        [_fourthBgView addSubview:_showAgreementLabel];
        //
        UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShowProtocol)];
        [_showAgreementLabel addGestureRecognizer:tap];
        //
        _uploadBtn = [UIButton buttonWithType:0];
        _uploadBtn.frame = CGRectMake(27.5f, CGRectGetMaxY(_showAgreementLabel.frame), SCREEN_WIDTH - 55.f, 40.f);
        [_uploadBtn setBackgroundColor:FOREGROUND_COLOR];

//        [_uploadBtn setBackgroundImage:[UIImage imageWithColor:FOREGROUND_COLOR size:_uploadBtn.frame.size] forState:0];
//        [_uploadBtn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:_uploadBtn.frame.size] forState:1 << 1];
        
        [_uploadBtn setTitle:@"确认上传" forState:0];
        [_uploadBtn.layer setCornerRadius:CGRectGetHeight(_uploadBtn.frame)/2];

        [_uploadBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_uploadBtn.titleLabel setFont:FONT(16.5f)];

        [_uploadBtn addTarget:self action:@selector(clickOnUpload:) forControlEvents:1<<6];
        [_fourthBgView addSubview:_uploadBtn];
        
        
        
        
    }
    return self;
}
- (void)addImageClick:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPics:)]) {
        [self.delegate addPics:btn];
    }
}

- (void)clickOnCheckStatement:(UIButton *)btn{
    _checkBtn.selected = !_checkBtn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAgreement:)]) {
        [self.delegate selectAgreement:btn];
    }
}
- (void)clickOnUpload:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(uploadPics:)]) {
        [self.delegate uploadPics:btn];
    }
}

- (void)refreshView{
    
}



- (void)tapShowProtocol{
    UIWebView *policy = [[UIWebView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH - 20.f, SCREEN_HEIGHT - 80.f)];
    [policy setUserInteractionEnabled:YES];
    [policy.scrollView setShowsHorizontalScrollIndicator:NO];
    [policy.scrollView setShowsVerticalScrollIndicator:NO];
    [policy setOpaque:NO];
    
    //使网页透明
    //    NSURL *reqURL = [NSURL URLWithString:[[ConfigManger sharedManager] getConfigByKey:cfgkeyagreement]];
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:reqURL];
    //    [policy loadRequest:request];
    //    [self lew_presentPopupView:policy animation:[LewPopupViewAnimationFade new]];
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    _textPlaceholderLabel.hidden = YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    _textPlaceholderLabel.hidden = textView.text.length > 0 ?YES: NO;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)refreshViewByRemoveImageView:(NSInteger)imageCount{
    // to do improve.
    [_addBtn setHidden:NO];
    if (imageCount ==0) {
        [_statementView setHidden:NO];
        [_secondBgView addSubview:_statementView];
    }
    [_addBtn setFrame:CGRectMake(THUMB_SPACING+imageCount%4 * (BTNADD_WIDITH + THUMB_SPACING),imageCount/4 * (BTNADD_WIDITH + THUMB_SPACING) + THUMB_SPACING,BTNADD_WIDITH, BTNADD_WIDITH)];
    [_secondBgView setFrame:CGRectMake(0.f, CGRectGetMaxY(_firstBgView.frame), SCREEN_WIDTH,THUMB_SPACING + (1+imageCount/4) * (BTNADD_WIDITH +THUMB_SPACING))];
    [_thirdBgView setFrame:CGRectMake(0.f, CGRectGetMaxY(_secondBgView.frame), self.frame.size.width, LOCAVIEW_HEIGHT)];
    [_fourthBgView setFrame:CGRectMake(0.f, CGRectGetMaxY(_thirdBgView.frame), SCREEN_WIDTH, 200.f)];
}


- (void)refreshView:(NSInteger )imageCount andImageData:(NSArray *)imagesArr{
    [_secondBgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[EZPhilImageView class]]) {
            [obj removeFromSuperview];
        }
    }];
    [_addBtn setHidden:NO];

    [_statementView setHidden:YES];
    [_addBtn setFrame:CGRectMake(THUMB_SPACING+imageCount%4 * (BTNADD_WIDITH + THUMB_SPACING),imageCount/4 * (BTNADD_WIDITH + THUMB_SPACING) + THUMB_SPACING,BTNADD_WIDITH, BTNADD_WIDITH)];
    [_secondBgView setFrame:CGRectMake(0.f, CGRectGetMaxY(_firstBgView.frame), SCREEN_WIDTH,THUMB_SPACING + (1+imageCount/4) * (BTNADD_WIDITH +THUMB_SPACING))];
    [_thirdBgView setFrame:CGRectMake(0.f, CGRectGetMaxY(_secondBgView.frame), self.frame.size.width, LOCAVIEW_HEIGHT)];
    [_fourthBgView setFrame:CGRectMake(0.f, CGRectGetMaxY(_thirdBgView.frame), SCREEN_WIDTH, 200.f)];
    
    for (NSInteger i = 0; i < imageCount; i ++) {
        NSDictionary *dict = imagesArr[i];
        EZPhilImageView *thumbImageView = [[EZPhilImageView alloc] init];
        [thumbImageView setFrame:CGRectMake(THUMB_SPACING + i%4 * (BTNADD_WIDITH + THUMB_SPACING),i/4 * (BTNADD_WIDITH + THUMB_SPACING) + THUMB_SPACING, BTNADD_WIDITH, BTNADD_WIDITH)];
        [thumbImageView setImage:dict[@"thumbImage"]];
        thumbImageView.userInteractionEnabled = YES;
        thumbImageView.tag = i + UPLOAD_IMAGE_THUMBIMAGE_TAG;
        [_secondBgView addSubview:thumbImageView];
        
        
        if (dict[@"mediaInfoType"] == FSMediaInfoTypePhotoAlbum) {
            [thumbImageView addDetailShowWithImgURL:dict[@"imageURL"]];
        }
        else if(dict[@"mediaInfoType"] == FSMediaInfoTakePhoto){
            [thumbImageView addDetailShowWithOrignalImage:dict[@"originalImage"]];
        }
        else if(dict[@"mediaInfoType"] == FSMediaInfoTypeVedio){
            [_addBtn setHidden:YES];
        }
        [self addRemoveButtonOnThumbImage:thumbImageView andTag:i];
    }
    if (imageCount ==0) {
        [_statementView setHidden:NO];
    }
}

#pragma mark AddRemoveButton
-(void)addRemoveButtonOnThumbImage:(UIImageView *)removeButtonView andTag:(NSInteger)index{
    
    UIButton * offButton = [UIButton buttonWithType:UIButtonTypeCustom];
    offButton.frame = CGRectMake(removeButtonView.bounds.size.width - 22, -3, 25, 25);
    [offButton setImage:IMAGE(@"delete_btn_upvc") forState:UIControlStateNormal];
    [offButton addTarget:self action:@selector(clickOffButton:) forControlEvents:UIControlEventTouchUpInside];
    offButton.tag = index + UPLOAD_IMAGE_REMOVEBTN_TAG;
    [removeButtonView addSubview:offButton];
}

-(void)clickOffButton:(UIButton *)button{

    NSInteger imgTag = button.tag - UPLOAD_IMAGE_REMOVEBTN_TAG;
    [[_secondBgView viewWithTag:UPLOAD_IMAGE_THUMBIMAGE_TAG + imgTag] removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(removeImage:)]) {
        [self.delegate removeImage:imgTag];
    }
}

@end
