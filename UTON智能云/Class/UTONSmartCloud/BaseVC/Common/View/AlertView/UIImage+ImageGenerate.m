//
//  UIImage+ImageGenerate.m
//  CCBMobileBankFoundation
//
//  Created by Ansonyc on 16/5/6.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import "UIImage+ImageGenerate.h"

@implementation UIImage (ImageGenerate)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContext(CGSizeMake(size.width*scale, size.height*scale));
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(contextRef, scale, scale);
    [color setFill];
    CGContextFillRect(contextRef, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [UIImage imageWithCGImage:[image CGImage] scale:scale orientation:UIImageOrientationUp];
//    image.themeColorName = color.themeColorName;
//    image.themeName = color.themeName;
    return image;
}

+ (UIImage *)roundCornerImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContext(CGSizeMake(cornerRadius*scale, cornerRadius*scale));
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(contextRef, scale, scale);
    [color setFill];
    CGContextFillEllipseInRect(contextRef, CGRectMake(0, 0, 2*cornerRadius, 2*cornerRadius));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [UIImage imageWithCGImage:[image CGImage] scale:scale orientation:UIImageOrientationUp];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(scale, scale, scale, scale)];

//    image.themeColorName = color.themeColorName;
//    image.themeName = color.themeName;
    return image;
}

+ (UIImage *)gradientImageWithColors:(NSArray *)colors
                           locations:(CGFloat [])locations
                                size:(CGSize)size
                         orientation:(UIImageOrientation)orientation {
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContext(CGSizeMake(size.width*scale, size.height*scale));
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(contextRef, scale, scale);
    
    CGGradientRef gradientRef = CGGradientCreateWithColors(NULL,
                                                           (__bridge_retained CFArrayRef)colors,
                                                           locations);
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, 0);
    if (orientation == UIImageOrientationUp) {
        endPoint = CGPointMake(0, size.height);
    }
    else if (orientation == UIImageOrientationLeft) {
        endPoint = CGPointMake(0, size.width);
    }
    CGContextDrawLinearGradient(contextRef,
                                gradientRef,
                                startPoint,
                                endPoint,
                                kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradientRef);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [UIImage imageWithCGImage:[image CGImage] scale:scale orientation:UIImageOrientationUp];
    
    return image;
}

- (UIImage *)imageWithinSize:(CGSize)size {
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContext(CGSizeMake(size.width*scale, size.height*scale));
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(contextRef, scale, scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [UIImage imageWithCGImage:image.CGImage scale:scale orientation:self.imageOrientation];
    UIGraphicsEndImageContext();

    return image;
}

@end
