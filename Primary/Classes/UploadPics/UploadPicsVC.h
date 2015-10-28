//
//  UploadPicsVC.h
//  Primary
//
//  Created by Phil Xhc on 15/10/27.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class EZColumnItem;
#define BTNADD_WIDITH (SCREEN_WIDTH - 60)/4
#define DESCRIBTION_Height 150.f
#define THUMBSPACING 12.f

@interface UploadPicsVC : UIViewController

- (instancetype)initWithColumnItem:(EZColumnItem *)columnItem;

@end
