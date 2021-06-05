//
//  NSString+Uitl.h
//  CCBMobileBank
//
//  Created by zhuqimin on 16/5/5.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Uitl)

// htmlText过滤
-(NSString*) htmlText;

+(BOOL)isEmptyString:(NSString*)string;

- (NSString *)subStringBetween:(NSString *)beginStr with:(NSString *)endStr;

@end
