//
//  UIImage+ImageGenerate.h
//  CCBMobileBankFoundation
//
//  Created by Ansonyc on 16/5/6.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageGenerate)
/**
 *  获得一个大小为size，颜色为color的图片
 *
 *  @param color 图片的颜色
 *  @param size  图片的大小
 *
 *  @return 根据color和size绘制的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  绘制渐变的图片
 *
 *  @param colors      颜色数组eg:@[(id)[[UIColor purpleColor] CGColor]...]
 *  @param locations   颜色的分布位置数组eg:{0,0.25,0.5,1.0}
 *  @param size        图片的大小
 *  @param orientation 渐变的绘制方向，暂时只支持UIImageOrientationUp(垂直)和UIImageOrientationLeft(水平)
 *
 *  @return 根据输入绘制的渐变图片
 */
+ (UIImage *)gradientImageWithColors:(NSArray *)colors
                           locations:(CGFloat [])locations
                                size:(CGSize)size
                         orientation:(UIImageOrientation)orientation;

/**
 *  绘制圆角可拉伸的颜色图片
 *
 *  @param color        填充颜色
 *  @param cornerRadius 圆角半径
 *
 *  @return 使用填充颜色绘制的带圆角的图片
 */
+ (UIImage *)roundCornerImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/**
 *  将原图片改变大小（注：使用本方法获取的图片无法根据主题切换）
 *
 *  @param size 输出图片的大小
 *
 *  @return 输出图片
 */
- (UIImage *)imageWithinSize:(CGSize)size;

@end
