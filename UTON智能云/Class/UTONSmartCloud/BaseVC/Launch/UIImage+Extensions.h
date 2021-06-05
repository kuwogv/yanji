//
//  UIImage+Extensions.h
//  CCBMobileBank
//
//  Created by MikeWang on 16/6/29.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

/**
 *  //通过颜色来生成一个纯色图片
 */
+ (UIImage *)ImageFromColor:(UIColor *)color size:(CGSize)size;
+(UIImage *)circularImageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

//改变图片颜色
- (UIImage *)changeImageWithColor:(UIColor *)color;

// 获取设备对应分辨率的引导图
+ (UIImage *)ccb_guideImageNamed:(NSString *)name;

@end
