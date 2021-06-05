//
//  NSString+Uitl.m
//  CCBMobileBank
//
//  Created by zhuqimin on 16/5/5.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import "NSString+Uitl.h"

#pragma mark characters ===

#define kUrlHeader @"http://"
#define kHttpCharacter @"http"

#define kPercentCharacter @"%"
#define kSlashCharacter @"/"
#define kBackslashCharacter @"\\"
#define kReturnCharacter @"\r"
#define kNewLineCharacter @"\n"
#define kTabCharacter @"\t"
#define kSpaceCharacter @" "
#define kSplictHR @"<hr/>"
#define kAmpersandCharacter @"&"
#define kAmpersandUnescaped @"&amp;"
#define kAmpersandWhitespace @"&nbsp;"
#define kAmpersandDivide @"&amp;gt;"
#define kEmptyString @""                //表示空字符串
#define kDollar @"$"
#define kSomeNewLineCharacter @"\n\n\n\\n\n\n\\n\n\n\n\n\n\n"
#define kCharacterSample @"A"

#define kQUESTION_MARK @"?"
#define kEQUAL_MARK @"="
#define kCompute_EQUAL @"=="
#define kCompute_UNEQUAL @"!="

#define kSqlValueLocation_left @"${"
#define kSqlValueLocation_right @"}"
#define kSqlValueLocation_full @"${}"
#define kSqlValueLocation_variable @"${%@}"

#define kLocalValueLocation_left @"$("
#define kLocalValueLocation_right @")"
#define kLocalValueLocation_full @"$()"
#define kLocalValueLocation_variable @"$(%@)"


@implementation NSString(Uitl)

//相连的空格只留一个
- (NSString *) reduceWhiteSpace
{
    NSArray *splitStrArray = [self componentsSeparatedByString:kSpaceCharacter];
    NSMutableString *resultStr = [NSMutableString string];
    for (NSString *str in splitStrArray)
    {
        if (0 != [str length])
        {
            [resultStr appendString:str];
            [resultStr appendString:kSpaceCharacter];
        }//end if ([str length] != 0)
        
    }//end for
    
    return resultStr;
}

// 得到html格式的text
- (NSString*)htmlText
{
    NSString *s = [self reduceWhiteSpace];
    
    s = [s stringByReplacingOccurrencesOfString:kAmpersandWhitespace withString:kSpaceCharacter];
    s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    s = [s stringByReplacingOccurrencesOfString: kNewLineCharacter withString: kEmptyString];
    s = [s stringByReplacingOccurrencesOfString: kReturnCharacter withString: kEmptyString];
    s = [s stringByReplacingOccurrencesOfString: kTabCharacter withString: kEmptyString];
    
    return s;
}

+ (BOOL)isEmptyString:(NSString *)string{
    if(string==nil || 0==[string length]){
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)subStringBetween:(NSString *)beginStr with:(NSString *)endStr
{
    NSRange range1 = [self rangeOfString:beginStr options:NSCaseInsensitiveSearch];
    NSRange range2 = [self rangeOfString: endStr options:NSCaseInsensitiveSearch];
    
    if (range1.location == NSNotFound || range2.location == NSNotFound)
    {
        return nil;
    }
    
    NSRange range3 = {range1.location + range1.length, range2.location - range1.location - range1.length };
    NSString *key = [self substringWithRange: range3];
    
    return [key trim];
}

- (NSString *)trim
{
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    return str;
}

@end
