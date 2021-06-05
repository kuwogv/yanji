//
//  NSString+Util.m
//  CCBClient
//
//  Created by Xie Wei on 10-9-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "NSString+Util.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMCCBBase64.h"

@implementation NSString (Util)
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key {
    
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData *EncryptData = [GTMCCBBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    NSString *initVec = @"init Vec";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey, 
                       kCCKeySize3DES,
                       vinitVec, //"init Vec", //iv,
                       vplainText, //"Your Name", //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
//    CCBLogDebug(@"___________________%i",ccStatus);
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                length:(NSUInteger)movedBytes]
                                        encoding:NSUTF8StringEncoding] ;
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMCCBBase64 stringByEncodingData:myData];
    }
    free(bufferPtr);
    
    return result;
    
} 


//kCCEncrypt加密 kCCDecrypt解密
+ (NSData*)TripleDESForData:(NSData*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key initVec:(NSString *)initVec
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        plainTextBufferSize = [plainText length];
        vplainText = [plainText bytes];
    }
    else
    {
        plainTextBufferSize = [plainText length];
        vplainText = (const void *)[plainText bytes];
    }
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    CCCrypt(encryptOrDecrypt,
            kCCAlgorithm3DES,
            kCCOptionPKCS7Padding,
            vkey,
            kCCKeySize3DES,
            vinitVec, //"init Vec", //iv,
            vplainText, //"Your Name", //plainText,
            plainTextBufferSize,
            (void *)bufferPtr,
            bufferPtrSize,
            &movedBytes);
    
    //        DebugLog(@"___________________%i",ccStatus);
    NSData *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [NSData dataWithBytes:(const void *)bufferPtr
                                length:(NSUInteger)movedBytes];
    }
    else
    {
        result = [NSData dataWithBytes:(const void *)bufferPtr
                                length:(NSUInteger)movedBytes];
    }
    
    return result;
    
}


//kCCEncrypt加密 kCCDecrypt解密
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key initVec:(NSString *)initVec
{
    
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData *EncryptData = [GTMCCBBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    

    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    CCCrypt(encryptOrDecrypt,
            kCCAlgorithm3DES,
            kCCOptionPKCS7Padding,
            vkey,
            kCCKeySize3DES,
            vinitVec, //"init Vec", //iv,
            vplainText, //"Your Name", //plainText,
            plainTextBufferSize,
            (void *)bufferPtr,
            bufferPtrSize,
            &movedBytes);
    
    //        DebugLog(@"___________________%i",ccStatus);
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                length:(NSUInteger)movedBytes]
                                        encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMCCBBase64 stringByEncodingData:myData];
    }
    
    return result;
    
}

-(BOOL) isEqualToIgnoreCaseString: (NSString *)aString
{
    return (NSOrderedSame == [self caseInsensitiveCompare: aString]);
}


- (NSString *)trim
{
	NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	return str;
}

+ (NSString *)trimUtil:(NSString *)str
{
    NSString *resultStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return resultStr;
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

- (NSArray *)subStringArrayBetween:(NSString *)beginStr with:(NSString *)endStr
{
	NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:2];
	NSArray *sectionArray = [self componentsSeparatedByString:beginStr];
	
	for (NSString *str in sectionArray) 
	{
		NSRange rang1 = [str rangeOfString:endStr];

		if (rang1.location != NSNotFound && (0 !=  rang1.location)) 
		{
			[resultArray addObject:[[str substringToIndex:rang1.location] trim]];
		}
	}

	return resultArray;
}


//加密字符串
+(NSString *)isEncryptStr:(NSString *)str
{
    NSString *result = [NSString TripleDES:str encryptOrDecrypt:kCCEncrypt key:menuPriavteKey];
    return result;
}

- (BOOL)isEmpty
{
	if (0 == [self length]) 
	{
		return YES;
	}

	return NO;
}

+ (BOOL)isEmptyString:(NSString *)string
{
	if (([string length] == 0) || string == nil ||[string isEqual:[NSNull null]])
	{
		return YES;
	}
	return NO;
}

- (NSString *) urlEncodeValue
{
    NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, 
                                                                            CFSTR(":/?#[]@!$&’()*+,;=\""), kCFStringEncodingUTF8));
    return result;
}

+(NSString *)accountFormat:(NSString *)accNO
{
    NSString *format = @"";
    if (accNO.length > 4) {
        NSString *before = [accNO substringToIndex:4];
        NSString *after = [accNO substringFromIndex:accNO.length-4];
        format = [NSString stringWithFormat:@"%@***%@",before,after];
    }else {
        format = accNO;
    }
    return format;
}

//将账号每4位加一个空格
+(NSString *)accountFillSpace:(NSString *)accStr
{
    NSInteger index = accStr.length/4+(accStr.length%4==0?0:1);
    NSString *resultStr = @"";
    for (NSInteger i=0; i<index; i++) {
        NSString *tmpStr = @"";
        if (accStr.length > 4) {
            tmpStr = [accStr substringToIndex:4];
            accStr = [accStr substringFromIndex:4];
        }else {
            tmpStr = accStr;
        }
        if (resultStr.length > 0) {
            resultStr = [NSString stringWithFormat:@"%@ %@",resultStr,tmpStr];
        }else {
            resultStr = [NSString stringWithFormat:@"%@",tmpStr];
        }
    }
    return resultStr;
}

//过滤字符串中的空格
+(NSString *)filterSpaceOfString:(NSString *)currentStr
{
    NSString *resultStr = [currentStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    return resultStr;
}


- (BOOL)containsString:(NSString *)str
{
    if (str == nil) {
        return NO;
    }
    
    if ([str isEqualToString:@""] ||
        [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
        return NO;
    }
    if ([self rangeOfString:str].location != NSNotFound) {
        return YES;
    }
    return NO;
}

//将楼层ID转化成int
-(NSInteger)flooridConversion
{
    if (self.length < 6) {//排错
        return 0;
    }
    
    NSString *preStr = [self substringToIndex:4];
    NSString *sufStr = [self substringFromIndex:4];
    
    return [preStr integerValue]*100 + [sufStr integerValue];
}

+ (BOOL)isBlankString:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]] || ([string length] == 0))
    {
        return YES;
    }
    return NO;
}

@end



