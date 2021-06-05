//
//  NSString+ui.h
//  CCBMobileBankFoundation
//
//  Created by jinhong on 16/5/9.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ui)

/**
 *  计算字符串实际需要多大区域
 *
 *  @param string          需要计算的字符串内容
 *  @param font            字体大小
 *  @param constrainedSize 预设的大小
 *  @param lineBreakMode   换行模式
 *
 *  @return 返回实际大小
 */
+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
