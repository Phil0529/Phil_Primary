//
//  EZUtils.m
//  EZTV
//
//  Created by Sunni on 15/6/24.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "EZUtils.h"
#import <CVKHierarchySearcher/CVKHierarchySearcher.h>
#import <MBProgressHUD.h>

@implementation EZUtils

+ (CAGradientLayer *)gradientLayerWithFrame:(CGRect)frame initColor:(UIColor *)iColor finalColor:(UIColor *)fColor
{
    // Create gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)iColor.CGColor,
                       (id)fColor.CGColor,
                       nil];
    
    [gradient setFrame:frame];
    
    return gradient;
}

+ (CAGradientLayer*)lightToDarkLayerWithFrame:(CGRect)frame
{
    // Create colors
    UIColor *darkOp = [UIColor colorWithWhite:0.f alpha:0.9];
    UIColor *lightOp = [UIColor colorWithWhite:0.f alpha:0.0];
    
    // Create gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)lightOp.CGColor,
                       (id)darkOp.CGColor,
                       nil];
    
    [gradient setFrame:frame];
    
    // Shadow
//    gradient.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    gradient.shadowColor = [UIColor blackColor].CGColor;
//    gradient.shadowOpacity = 0.4;
//    gradient.shadowRadius = 2;
    
    //    // Other options
    //    gradient.borderWidth = 0.5f;
    //    gradient.borderColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0].CGColor;
    //    gradient.cornerRadius = 10;
    
    return gradient;
}

+ (CAGradientLayer*)darkToLightLayerWithFrame:(CGRect)frame
{
    // Create colors
    UIColor *darkOp = [UIColor colorWithWhite:0.f alpha:0.9];
    UIColor *lightOp = [UIColor colorWithWhite:0.f alpha:0.0];
    
    // Create gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)darkOp.CGColor,
                       (id)lightOp.CGColor,
                       nil];
    [gradient setFrame:frame];
    
    // Shadow
//    gradient.shadowOffset = CGSizeMake(0.0f, -2.0f);
//    gradient.shadowColor = [UIColor blackColor].CGColor;
//    gradient.shadowOpacity = 0.4;
//    gradient.shadowRadius = 2;
    
    //    // Other options
    //    gradient.borderWidth = 0.5f;
    //    gradient.borderColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0].CGColor;
    //    gradient.cornerRadius = 10;
    
    return gradient;
}

+ (NSString *)combineUrl:(NSString *)url params:(NSDictionary *)params
{
    NSRange queryRange = [url rangeOfString:@"?"];
    if (queryRange.length > 0) {
        NSMutableString *result = [[NSMutableString alloc] initWithString:url];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [result appendFormat:@"&%@=%@", (NSString *)key, (NSString *)obj];
        }];
        return result;
    } else {
        NSMutableString *result = [[NSMutableString alloc] initWithFormat:@"%@?",url];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [result appendFormat:@"%@=%@&", (NSString *)key, (NSString *)obj];
        }];
        return [result substringToIndex:result.length - 1];
    }
}

+ (void)showNotifyMsg:(NSString *)msg inView:(UIView *)view dismissed:(void (^)(void))dismissed
{
    CVKHierarchySearcher *searcher = [[CVKHierarchySearcher alloc] init];
    UIView *displayView = view;
    if (searcher.topmostViewController.view) {
        displayView = searcher.topmostViewController.view;
    }
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:displayView animated:YES];
    [HUD setMode:MBProgressHUDModeText];
    [HUD setDimBackground:YES];
    [HUD setDetailsLabelFont:[UIFont boldSystemFontOfSize:14.f]];
    [HUD setDetailsLabelText:msg];
    [HUD setCompletionBlock:dismissed];
    [HUD hide:YES afterDelay:1.2f];
}

@end
