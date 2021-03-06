//
//  UploadPicsView.h
//  Primary
//
//  Created by Phil Xhc on 15/10/27.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UploadPicsVCDelegate <NSObject>

- (void)addPics:(UIButton *)btn;
- (void)uploadPics:(UIButton *)btn;
- (void)selectAgreement:(UIButton *)btn;
- (void)removeImage:(NSInteger )imageTag;
@end


@class MBProgressHUD;
@interface UploadPicsView : UIView

@property (nonatomic, strong) UIView *firstBgView;
@property (nonatomic, strong) UIView *secondBgView;
@property (nonatomic, strong) UIView *thirdBgView;
@property (nonatomic, strong) UIView *fourthBgView;


@property (nonatomic, strong) MBProgressHUD *mbProgressView;
@property (nonatomic, strong) UIView *textBgView;
@property (nonatomic, strong) UITextView *textDescView;
@property (nonatomic, strong) UILabel *textPlaceholderLabel;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIView *locaImgView;
@property (nonatomic, strong) UILabel *locaLabel;
@property (nonatomic, strong) UIView *lineThird;

@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) UILabel *agreementLabel;
@property (nonatomic, strong) UILabel *showAgreementLabel;
@property (nonatomic, strong) UIView *statementView;

@property (nonatomic, strong) UIButton *uploadBtn;


@property (nonatomic, weak) id<UploadPicsVCDelegate> delegate;




- (instancetype)initWithFrame:(CGRect)frame;

- (void)refreshView:(NSInteger )imageCount andImageData:(NSArray *)imagesArr;

//- (void)refreshViewByRemoveImageView:(NSInteger)imageCount;








@end
