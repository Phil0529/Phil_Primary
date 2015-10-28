//
//  UploadPicsView.h
//  Primary
//
//  Created by Phil Xhc on 15/10/27.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;
@interface UploadPicsView : UIView

@property (nonatomic, strong) UIView *firstBgView;
@property (nonatomic, strong) UIView *secondBgView;

@property (nonatomic, strong) MBProgressHUD *mbProgressView;
@property (nonatomic, strong) UIView *textBgView;
@property (nonatomic, strong) UITextView *textDescView;
@property (nonatomic, strong) UILabel *textPlaceholderLabel;
@property (nonatomic, strong) UIView *lineFirst;
@property (nonatomic, strong) UIView *thumBgView;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIView *locaBgView;
@property (nonatomic, strong) UIView *locaImgView;
@property (nonatomic, strong) UILabel *locaLabel;
@property (nonatomic, strong) UIView *lineThird;
@property (nonatomic, strong) UIView *lineFourth;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) UILabel *agreementLabel;
@property (nonatomic, strong) UILabel *checkAgreementLabel;
@property (nonatomic, strong) UIButton *uploadBtn;
@property (nonatomic, strong) UIView *statementView;


@property (nonatomic, strong) void (^addImgBlock)();


- (instancetype)initWithFrame:(CGRect)frame;

- (void)refreshView;








@end
