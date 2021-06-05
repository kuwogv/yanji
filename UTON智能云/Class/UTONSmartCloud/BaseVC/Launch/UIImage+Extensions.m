//
//  UIImage+Extensions.m
//  CCBMobileBank
//
//  Created by MikeWang on 16/6/29.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import "UIImage+Extensions.h"

@implementation UIImage (Extensions)


//通过颜色来生成一个纯色图片
+ (UIImage *)ImageFromColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//改变图片颜色
- (UIImage *)changeImageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//颜色生成图片方法
+(UIImage *)circularImageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    CGContextFillEllipseInRect(context, rect);
    CGContextClip(context);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

// 获取设备对应分辨率的引导图
+ (UIImage *)ccb_guideImageNamed:(NSString *)name {
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGFloat height = UIScreen.mainScreen.bounds.size.height;
    CGFloat scale = UIScreen.mainScreen.scale;
    
    // 获取对应分辨率图片，没有对应分辨率图片的话使用 iPhone X 分辨率图。
    NSString *imageFileName = [NSString stringWithFormat:@"%@_%.0f-%.0f", name, width * scale, height * scale];
    NSString *imageFilePath = [NSBundle.mainBundle pathForResource:imageFileName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
    if (!image) {
        image = [UIImage imageWithContentsOfFile:[NSBundle.mainBundle pathForResource:[NSString stringWithFormat:@"%@_1125-2436", name] ofType:@"png"]];
    }
    
    return image;
}

@end
