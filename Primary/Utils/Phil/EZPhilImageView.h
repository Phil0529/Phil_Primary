//
//  EZPhilImageView.h
//  EZTV
//
//  Created by 肖翰程 on 15/9/16.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EZPhilImageView : UIImageView

@property (nonatomic, copy) NSURL *imgURL;
@property (nonatomic, copy) UIImage *orignalImg;


- (void)addDetailShowWithImgURL:(NSURL *)imgURL;

- (void)addDetailShowWithOrignalImage:(UIImage *)orignalImage;
@end
