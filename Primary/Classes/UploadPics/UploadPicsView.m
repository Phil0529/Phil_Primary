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

@end

@implementation UploadPicsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.firstBgView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width,DESCRIBTION_HEIGHT)];
        self.firstBgView.backgroundColor = COLORFORRGB(0xffffff);
        [self addSubview:self.firstBgView];
        
        self.textDescView = [[UITextView alloc]initWithFrame:CGRectMake(2 * THUMB_SPACING, 0.f, self.frame.size.width - 40.f,CGRectGetHeight(self.firstBgView.frame) - THUMB_SPACING)];
        self.textDescView.font = FONT(14.5);
        self.textDescView.backgroundColor = COLORFORRGB(0xffffff);
        self.textDescView.returnKeyType = UIReturnKeyDone;
        self.textDescView.textAlignment = NSTextAlignmentJustified;
        self.textDescView.selectedRange = NSMakeRange(0, 0);
        self.textDescView.delegate = self;
        [self.firstBgView addSubview:self.textDescView];
        
        UILabel *textPlaceholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textDescView.frame) + 3.f, CGRectGetMinY(self.textDescView.frame) + THUMB_SPACING, self.textDescView.frame.size.width, 14.5f)];
        textPlaceholderLabel.text = @"简介内容不少于五个字";
        textPlaceholderLabel.font = FONT(14.5);

        textPlaceholderLabel.textColor = COLORFORRGB(0x949494);
        [self.firstBgView addSubview:textPlaceholderLabel];
        
        
        
        UIView *firstLine = [[UIView alloc]initWithFrame:CGRectMake(THUMB_SPACING, CGRectGetMaxY(self.firstBgView.frame) - 1.f,self.frame.size.width - 2 * THUMB_SPACING , 1.f)];
        firstLine.backgroundColor = COLORFORRGB(0xd0d0d0);
        [self.firstBgView addSubview:firstLine];
        
        self.secondBgView = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.firstBgView.frame), self.frame.size.width, BTNADD_WIDITH + 2 * THUMB_SPACING)];
        self.secondBgView.backgroundColor = COLORFORRGB(0xffffff);
        [self addSubview:self.secondBgView];
        
        UIView *secondLine = [[UIView alloc]initWithFrame:CGRectMake(0.f, CGRectGetHeight(self.secondBgView.frame) - 1.f,self.frame.size.width  , 1.f)];
        secondLine.backgroundColor = COLORFORRGB(0xd0d0d0);
        [self.secondBgView addSubview:secondLine];
        
        self.addBtn = [UIButton buttonWithType:0];
        self.addBtn.frame = CGRectMake(THUMB_SPACING, THUMB_SPACING, BTNADD_WIDITH, BTNADD_WIDITH);
        [self.addBtn setBackgroundImage:IMAGE(@"add_upvc") forState:0];
        [self.addBtn addTarget:self action:@selector(addImage :) forControlEvents:1<<6];
        [self.secondBgView addSubview:self.addBtn];
        
        self.locaBgView = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.secondBgView.frame), self.frame.size.width, LOCAVIEW_HEIGHT)];
        self.locaBgView.backgroundColor = COLORFORRGB(0xffffff);
        [self addSubview:self.locaBgView];

        UIView *thirdLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetHeight(self.locaBgView.frame) - 1.f, CGRectGetWidth(self.locaBgView.frame), 1.f)];
        thirdLine.backgroundColor = COLORFORRGB(0xd0d0d0);
        [self.locaBgView addSubview:thirdLine];
        
        self.locaImgView = [[UIImageView alloc] initWithImage:IMAGE(@"locationlogo_upvc")];
        self.locaImgView.center = CGPointMake(THUMB_SPACING + 8.f, LOCAVIEW_HEIGHT/2);
        [self.locaBgView addSubview:self.locaImgView];
        
        self.locaLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.locaImgView.frame) + THUMB_SPACING, 0.f, self.locaBgView.frame.size.width - CGRectGetMaxX(self.locaImgView.frame) - THUMB_SPACING , self.locaBgView.frame.size.height)];
        self.locaLabel.text = @"正在加载";
        self.locaLabel.font = FONT(14.5);
        [self.locaBgView addSubview:self.locaLabel];
        
        
    }
    return self;
}
- (void)addImage:(UIButton *)btn{
    if (self.addImgBlock) {
        self.addImgBlock();
    }
}






- (void)refreshView{
    
}

@end
