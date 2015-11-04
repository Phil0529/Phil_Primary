//
//  UIImage+Function.m
//  SWMediaPlay
//
//  Created by liangliang on 12-12-4.
//  Copyright (c) 2012年 Sunniwell. All rights reserved.
//

#import "UIImage+Function.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#define DegreesToRadians(d) (d * M_PI / 180)

@implementation UIImage (Function)

+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(2.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
    return thumbImg;
}

+ (UIImage *)imageWithMaxWith:(CGFloat)width sourceImage:(UIImage *)image
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = [self CWSizeReduce:image.size limit:width];
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);
    // 创建一个 bitmap context
    
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];
    // 将图片绘制到当前的 context 上
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    // 从当前 context 中获取刚绘制的图片
    UIGraphicsEndImageContext();
    return img;
}

+ (CGSize)CWSizeReduce:(CGSize)size limit:(CGFloat)limit
{
    // 按比例减少尺寸
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }

    CGSize imgSize;
    CGFloat ratio = size.height / size.width;

    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    } else {
        imgSize = CGSizeMake(limit/ratio, limit);
    }

    return imgSize;
}

- (UIImage *)scaleToSize:(CGSize)size
{
    // Scalling selected image to targeted size
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, 1);
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    
    if(self.imageOrientation == UIImageOrientationRight)
    {
        CGContextRotateCTM(context, -M_PI_2);
        CGContextTranslateCTM(context, -size.height, 0.f);
        CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), self.CGImage);
    }
    else
        CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
    
    CGImageRef scaledImage=CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIImage *image = [UIImage imageWithCGImage: scaledImage];
    
    CGImageRelease(scaledImage);
    
//    UIGraphicsBeginImageContext(size);
//    [self drawInRect:CGRectMake(0.0, 0.0, size.width, size.height)];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scaleProportionalToSize:(CGSize)size
{
    float widthRatio = size.width/self.size.width;
    float heightRatio = size.height/self.size.height;
    
    if(widthRatio > heightRatio)
    {
        size=CGSizeMake(self.size.width*heightRatio,self.size.height*heightRatio);
    } else {
        size=CGSizeMake(self.size.width*widthRatio,self.size.height*widthRatio);
    }
    
    return [self scaleToSize:size];
}

+ (UIImage *)imageWithSize:(CGSize)size colors:(NSArray *)colors gradientType:(GradientType)gradientType
{
    NSMutableArray *arr = [NSMutableArray array];
    for(UIColor *c in colors) {
        [arr addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)arr, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case topToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        case bottomToTop:
            start = CGPointMake(0.0, size.height);
            end = CGPointMake(0.0, 0.0);
            break;
        case leftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
        case upleftTolowRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case uprightTolowLeft:
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
//    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)cropCaptureImageToSize:(CGSize)size mirroUp:(BOOL)mirroUp offset:(CGFloat)offset
{
    CGSize orignalSize = self.size;
    CGPoint cropStart = CGPointMake((orignalSize.width - size.width)/2, (orignalSize.height - size.height)/2 - offset);
    CGRect cropRect = CGRectMake(cropStart.x, cropStart.y, size.width, size.height);
    CGImageRef cropRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIImage *cropImage = [UIImage imageWithCGImage:cropRef];
    CGImageRelease(cropRef);
    if (mirroUp) {
        return [UIImage imageWithCGImage:cropImage.CGImage
                                               scale:cropImage.scale
                                         orientation:UIImageOrientationUpMirrored];
    } else {
        return cropImage;
    }
}

- (UIImage *)cropImageToSize:(CGSize)size
{
    CGSize orignalSize = self.size;
    CGPoint cropStart = CGPointMake((orignalSize.width - size.width)/2, (orignalSize.height - size.height)/2);
    CGRect cropRect = CGRectMake(cropStart.x, cropStart.y, size.width, size.height);
    CGImageRef cropRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIImage *cropImage = [UIImage imageWithCGImage:cropRef];
    CGImageRelease(cropRef);
    return cropImage;
}



@end
