//
//  PhilWriteGPSToImage.h
//  Primary
//
//  Created by Phil Xhc on 15/11/16.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhilWriteGPSToImage : NSObject

/**
    Create Orignal Image With ImageAssetURL.
 */

+ (UIImage *)getOrignalImageWithURL:(NSURL *)imgAssetURL;

+ (NSData *)getImgDataWithURL:(NSURL *)imgAssetURL andLocation:(NSDictionary *)locationDict;

+ (NSData *)getImgDataWithImage:(UIImage *)sourceImage andLocation:(NSDictionary *)locationDict;

@end
