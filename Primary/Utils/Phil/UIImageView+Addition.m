//
//  UIImageView+Addition.m
//  PhotoLookTest
//
//  Created by 肖翰程 on 15/9/15.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#define kCoverViewTag           1234
#define kImageViewTag           1235
#define kAnimationDuration      0.3f
#define kImageViewWidth         ([UIScreen mainScreen].bounds.size.width)
#define kBackViewColor          [UIColor blackColor]

#import "UIImageView+Addition.h"
#import <objc/runtime.h>
#import "EZWriteGPSToImagePhil.h"

//static char imgURLKey;

@implementation UIImageView (Addition)

//-(void)setImgURL:(NSURL *)imgURL
//{
//    objc_setAssociatedObject(self, &imgURLKey, imgURL, OBJC_ASSOCIATION_COPY);
//}
//
//-(NSURL *)imgURL
//{
//    return objc_getAssociatedObject(self, &imgURLKey);
//}
//- (void)hiddenView
//{
//    UIView *coverView = (UIView *)[[self window] viewWithTag:kCoverViewTag];
//    [coverView removeFromSuperview];
//}
//
//- (void)hiddenViewAnimation
//{    
//    UIImageView *imageView = (UIImageView *)[[self window] viewWithTag:kImageViewTag];
//    
//    [UIView beginAnimations:nil context:nil];    
//    [UIView setAnimationDuration:kAnimationDuration]; //动画时长
//    CGRect rect = [self convertRect:self.bounds toView:self.window];
//    imageView.frame = rect;
//    
//    [UIView commitAnimations];
//    [self performSelector:@selector(hiddenView) withObject:nil afterDelay:kAnimationDuration];
//    
//}
//- (CGRect)adjustFrame:(UIImage *)orignalImg{
//    float width = kImageViewWidth;
//    //    float targeHeight = (width*orignalImgView.frame.size.height)/orignalImgView.frame.size.width;
//    float targeHeight = orignalImg.size.height/orignalImg.size.width *width;
//    UIView *coverView = (UIView *)[[self window] viewWithTag:kCoverViewTag];
//    CGRect targeRect = CGRectMake(0.f, coverView.frame.size.height/2 - targeHeight/2, width, targeHeight);
//    return targeRect;
//}
//- (void)imageTap
//{
//    UIView *coverView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    coverView.backgroundColor = kBackViewColor;
//    coverView.tag = kCoverViewTag;
//    UITapGestureRecognizer *hiddenViewGecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenViewAnimation)];
//    [coverView addGestureRecognizer:hiddenViewGecognizer];
//
//    EZWriteGPSToImagePhil *obj = [[EZWriteGPSToImagePhil alloc]init];
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[obj philGetOrignalImageWithURL:[self imgURL]]];
//    
//    imageView.tag = kImageViewTag;
//    imageView.userInteractionEnabled = YES;
//    imageView.contentMode = self.contentMode;
//    CGRect rect = [self convertRect:self.bounds toView:self.window];
//    imageView.frame = rect;
//       
//    [coverView addSubview:imageView];
//    [[self window] addSubview:coverView];
//
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:kAnimationDuration];
//    imageView.frame = [self adjustFrame:imageView.image];
//    [UIView commitAnimations];
//     
//}
//
//- (void)addDetailShow
//{
//    self.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
//    [self addGestureRecognizer:tapGestureRecognizer];
//}
//- (void)addDetailShowWithImgURL:(NSURL *)imgURL{
//    
//    self.userInteractionEnabled = YES;
//    [self setImgURL:imgURL];
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
//    [self addGestureRecognizer:tapGestureRecognizer];
//    
//}

@end