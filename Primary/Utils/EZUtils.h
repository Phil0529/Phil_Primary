//
//  EZUtils.h
//  EZTV
//
//  Created by Sunni on 15/6/24.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZUtils : NSObject

+ (CAGradientLayer*)gradientLayerWithFrame:(CGRect)frame initColor:(UIColor *)iColor finalColor:(UIColor *)fColor;

+ (CAGradientLayer*)lightToDarkLayerWithFrame:(CGRect)frame;

+ (CAGradientLayer*)darkToLightLayerWithFrame:(CGRect)frame;

+ (NSString *)combineUrl:(NSString *)url params:(NSDictionary *)params;

+ (void)showNotifyMsg:(NSString *)msg inView:(UIView *)view dismissed:(void(^)(void))dismissed;

@end
