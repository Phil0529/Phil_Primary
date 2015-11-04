//
//  UIImage+Function.h
//  SWMediaPlay
//
//  Created by liangliang on 12-12-4.
//  Copyright (c) 2012年 Sunniwell. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    topToBottom = 0,//从上到下
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
    bottomToTop = 4, //从下到上
}GradientType;


@interface UIImage (Function)
/**
 *  获取视频的首帧图片
 *
 *  @param videoURL 视频的资源URL
 *
 *  @return UIimage实例
 */
+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL;

/**
 *  等比缩小图片
 *
 *  @param width 目标图片宽度
 *  @param image 原图片
 *
 *  @return 裁剪好的图片
 */
+ (UIImage *)imageWithMaxWith:(CGFloat)width sourceImage:(UIImage *)image;

/**
 *  生成渐变色的矩形方块图像
 *
 *  @param colors       渐变的起始颜色
 *  @param gradientType 渐变方向
 *
 *  @return 图像
 */
+ (UIImage*)imageWithSize:(CGSize)size colors:(NSArray *)colors gradientType:(GradientType)gradientType;

/**
 *  图像缩放
 *
 *  @param size 缩放大小
 *
 *  @return 图像
 */
- (UIImage *)scaleToSize:(CGSize)size;

- (UIImage *)scaleProportionalToSize:(CGSize)size;

/**
 *  图像旋转
 *
 *  @param degrees 旋转角度
 *
 *  @return UIImage图像
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  裁剪截图
 *
 *  @param size    目标尺寸
 *  @param mirroUp 前置摄像头需要上下翻转
 *  @param offset  Y轴位移
 *
 *  @return 图像
 */
- (UIImage *)cropCaptureImageToSize:(CGSize)size mirroUp:(BOOL)mirroUp offset:(CGFloat)offset;

/**
 *  简单裁剪图像
 *
 *  @param size 目标尺寸
 *
 *  @return 裁剪后的图像
 */
- (UIImage *)cropImageToSize:(CGSize)size;

@end
