//
//  EZWriteGPSToImagePhil.h
//  EZTV
//
//  Created by 肖翰程 on 15/9/13.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>

@interface EZWriteGPSToImagePhil : NSObject

- (UIImage *)philGetOrignalImageWithURL:(NSURL *)imgAssetURL;

- (NSData *)philGetImgDataWithURL:(NSURL *)imgAssetURL andLocation:(NSDictionary *)locationDict;

+ (NSData *)philGetImgDataWithImage:(UIImage *)editedImage andLocation:(NSDictionary *)locationDict;

@end
