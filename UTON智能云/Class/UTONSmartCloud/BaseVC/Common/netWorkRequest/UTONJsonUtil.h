//
//  YBGJsonUtil.h
//  YBGMobileCampus
//
//  Created by Xiaobing@MacMini on 16/11/10.
//  Copyright © 2016年 YBG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTONJsonUtil : NSObject
/**
 *  获取单例
 *
 *
 */
+ (UTONJsonUtil *)sharedInstance;

///json转化数组
- (NSArray *)stringToJSON:(NSString *)jsonStr;
///json转化字典
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
///字典转json
-(NSString*)dictionaryToJson:(NSDictionary *)dic;
///MD5加密
- (NSString *) md5:(NSString *)string;
@end
