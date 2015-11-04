//
//  UploadPicsView.m
//  Primary
//
//  Created by Phil Xhc on 15/10/27.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "UploadPicsView.h"



#define DESCRIBTION_HEIGHT 160.f
#define THUMB_SPACING 15.f
#define BTNADD_WIDITH (SCREEN_WIDTH - THUMB_SPACING * 5)/4
#define LOCAVIEW_HEIGHT 44.f

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
        
        _secondBgView = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(_firstBgView.frame), self.frame.size.width, BTNADD_WIDITH + 2 * THUMB_SPACING)];
        _secondBgView.backgroundColor = COLORFORRGB(0xffffff);
        [self addSubview:_secondBgView];
        
        UIView *secondLine = [[UIView alloc]initWithFrame:CGRectMake(0.f, CGRectGetHeight(_secondBgView.frame) - 1.f,self.frame.size.width  , 1.f)];
        secondLine.backgroundColor = COLORFORRGB(0xd0d0d0);
        [_secondBgView addSubview:secondLine];
        
        _thumBgView = [[UIView alloc] initWithFrame:CGRectMake(THUMB_SPACING,THUMB_SPACING , BTNADD_WIDITH, BTNADD_WIDITH)];
        [_thumBgView setBackgroundColor:[UIColor whiteColor]];
        [_secondBgView addSubview:_thumBgView];
        
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
        [_uploadBtn.layer setCornerRadius:20.f];
        [_uploadBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_uploadBtn.titleLabel setFont:FONT(16.5f)];
        [_uploadBtn setTitle:@"确认上传" forState:0];
        [_uploadBtn addTarget:self action:@selector(clickOnUpload:) forControlEvents:1<<6];
        [_fourthBgView addSubview:_uploadBtn];
        
        

        
    }
    return self;
}
- (void)addImageClick:(UIButton *)btn{

    if ([self.delegate respondsToSelector:@selector(addPics:)]) {
        [self.delegate addPics:btn];
    }
}

- (void)clickOnCheckStatement:(UIButton *)btn{
    _checkBtn.selected = !_checkBtn.selected;
    if ([self.delegate respondsToSelector:@selector(selectAgreement:)]) {
        [self.delegate selectAgreement:btn];
    }
}
- (void)clickOnUpload:(UIButton *)btn{
    if ([_uploadBtn respondsToSelector:@selector(uploadPics:)]) {
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
    [policy setOpaque:NO];//使网页透明
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


- (void)refreshView:(NSInteger )imageCount{
    [_addBtn setHidden:NO];
    if (imageCount ==0) {
        [_statementView setHidden:NO];
        [_secondBgView addSubview:_statementView];
    }
    else if(imageCount <= 3){
        [_statementView setHidden:YES];
        [_secondBgView setFrame:CGRectMake(0.f, CGRectGetMaxY(_firstBgView.frame), SCREEN_WIDTH, 2*THUMB_SPACING + BTNADD_WIDITH)];
        [_addBtn setFrame:CGRectMake(THUMB_SPACING+imageCount * (BTNADD_WIDITH + THUMB_SPACING),THUMB_SPACING,BTNADD_WIDITH, BTNADD_WIDITH)];
        
        
        [self addSubview:_secondBgView];
        [self addSubview:_thirdBgView];
        [self addSubview:_fourthBgView];
        
    }
    else{
        
    }
}


//- (void)createThumbView{
//    [_addBtn setHidden:NO];
//    if (_imagesArr.count == 0) {
//        [_statementView setHidden:NO];
//        [_thumbBgView addSubview:_statementView];
//    }
//    if (_imagesArr.count != 0) {
//        [_statementView setHidden:YES];
//    }
//    if (_imagesArr.count <= 3) {
//        _thumbBgView.frame = CGRectMake(0.f, CGRectGetMaxY(_lineTop.frame) , SCREEN_WIDTH, 24.f+_BTNADD_WIDITH);
//        _addBtn.frame = CGRectMake(12.f + _imagesArr.count * (_BTNADD_WIDITH + 12.f), 12.f, _BTNADD_WIDITH, _BTNADD_WIDITH);
//        [_thumbBgView addSubview:_addBtn];
//        _mainViewBg.frame = CGRectMake(0.f, 0.f, SCREEN_WIDTH, _BTNADD_WIDITH + _DESCRIBTION_Height + _THUMBSPACING * 2 + 20.f);
//        _subViewBg.frame = CGRectMake(0.f, CGRectGetMaxY(_mainViewBg.frame) - 1.f, SCREEN_WIDTH, 200.f);
//        _lineViewThumBgBottom.frame = CGRectMake(0.f, CGRectGetHeight(_thumbBgView.frame), SCREEN_WIDTH, 1.f);
//        [_thumbBgView addSubview:_lineViewThumBgBottom];
//        [_mainViewBg addSubview:_thumbBgView];
//        [self.view addSubview:_mainViewBg];
//        [self.view addSubview:_subViewBg];
//    }
//    if(_imagesArr.count >3)
//    {
//        _addBtn.frame = CGRectMake(12.f + (_imagesArr.count - 4)*(_BTNADD_WIDITH + 12.f), 24.f+_BTNADD_WIDITH, _BTNADD_WIDITH, _BTNADD_WIDITH);
//        _mainViewBg.frame = CGRectMake(0.f, 0.f, SCREEN_WIDTH, 2 * _BTNADD_WIDITH + _DESCRIBTION_Height + _THUMBSPACING * 3 + 20.f);
//        _thumbBgView.frame = CGRectMake(0.f,  CGRectGetMaxY(_lineTop.frame), SCREEN_WIDTH, 36.f+_BTNADD_WIDITH*2);
//        _subViewBg.frame = CGRectMake(0.f, CGRectGetMaxY(_mainViewBg.frame) - 1.f, SCREEN_WIDTH, 200.f);
//        [_thumbBgView addSubview:_addBtn];
//        
//        _lineViewThumBgBottom.frame = CGRectMake(0.f, CGRectGetHeight(_thumbBgView.frame), SCREEN_WIDTH, 1.f);
//        [_thumbBgView addSubview:_lineViewThumBgBottom];
//        [_mainViewBg addSubview:_thumbBgView];
//        [self.view addSubview:_mainViewBg];
//        [self.view addSubview:_subViewBg];
//    }
//    for (NSInteger i = 0;i < _imagesArr.count; i++) {
//        NSDictionary *dict = _imagesArr[i];
//        UIImage *thumbImage = [dict objectForKey:@"thumbImage"];
//        if ([dict objectForKey:@"imageURL"]) {
//            NSURL *imageURL = [dict objectForKey:@"imageURL"];
//            EZPhilImageView *thumbImageView = [[EZPhilImageView alloc]init];
//            if (i <= 3) {
//                thumbImageView.frame =CGRectMake(12.f + i*(_BTNADD_WIDITH+12.f), 12.f, _BTNADD_WIDITH, _BTNADD_WIDITH);
//            }
//            else{
//                thumbImageView.frame = CGRectMake(12.f + (i-4)*(_BTNADD_WIDITH+12.f), 24.f + _BTNADD_WIDITH, _BTNADD_WIDITH, _BTNADD_WIDITH);
//            }
//            thumbImageView.image = thumbImage;
//            thumbImageView.tag = i + 200;
//            [_thumbBgView addSubview:thumbImageView];
//            [thumbImageView addDetailShowWithImgURL:imageURL];
//            thumbImageView.userInteractionEnabled = YES;
//            [self addRemoveButtonOnThumbImage:thumbImageView andTag:i];
//            
//        }
//        if([dict objectForKey:@"originalImage"]){
//            EZPhilImageView *thumbImageView = [[EZPhilImageView alloc]init];
//            if (i <= 3) {
//                thumbImageView.frame =CGRectMake(12.f + i*(_BTNADD_WIDITH+12.f), 12.f, _BTNADD_WIDITH, _BTNADD_WIDITH);
//            }
//            else{
//                thumbImageView.frame = CGRectMake(12.f + (i-4)*(_BTNADD_WIDITH+12.f), 24.f + _BTNADD_WIDITH, _BTNADD_WIDITH, _BTNADD_WIDITH);
//            }
//            
//            thumbImageView.image = thumbImage;
//            thumbImageView.tag = i + 200;
//            [_thumbBgView addSubview:thumbImageView];
//            [thumbImageView addDetailShowWithOrignalImage:[dict objectForKey:@"originalImage"]];
//            thumbImageView.userInteractionEnabled = YES;
//            [self addRemoveButtonOnThumbImage:thumbImageView andTag:i];
//        }
//        if([dict objectForKey:@"videoURL"]){
//            EZPhilImageView *thumbImageView = [[EZPhilImageView alloc]init];
//            if (i <= 3) {
//                thumbImageView.frame =CGRectMake(12.f + i*(_BTNADD_WIDITH+12.f), 12.f, _BTNADD_WIDITH, _BTNADD_WIDITH);
//            }
//            else{
//                thumbImageView.frame = CGRectMake(12.f + (i-4)*(_BTNADD_WIDITH+12.f), 24.f + _BTNADD_WIDITH, _BTNADD_WIDITH, _BTNADD_WIDITH);
//            }
//            [_addBtn setHidden:YES];
//            UIImageView *playIcon = [[UIImageView alloc] initWithImage:IMAGE(@"video_icon")];
//            [playIcon setCenter:CGPointMake(CGRectGetWidth(thumbImageView.frame)/2, CGRectGetHeight(thumbImageView.frame)/2)];
//            thumbImageView.image = thumbImage;
//            [thumbImageView addSubview:playIcon];
//            thumbImageView.tag = i + 200;
//            [_thumbBgView addSubview:thumbImageView];
//            //            [thumbImageView addDetailShowWithOrignalImage:[dict objectForKey:@"originalImage"]];
//            thumbImageView.userInteractionEnabled = YES;
//            [self addRemoveButtonOnThumbImage:thumbImageView andTag:i];
//        }
//    }
//}
//


@end
