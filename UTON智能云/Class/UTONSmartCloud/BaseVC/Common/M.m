//
//  M.m
//  CCBMobileBankFoundation
//
//  Created by ios zixin on 6/9/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "M.h"
//#import <CCBMobileBankFoundation/CCBThemeManager.h>
//#import "CCBGlobalStringHelper.h"


@implementation M


+(double) A{
    return [UIScreen mainScreen].bounds.size.width/375.0;
}

+(double) B{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"KEY_fontsize"] doubleValue];
}

//+(UIImage*) C:(NSString*)name{
//    return [[CCBThemeManager shareInstance] getImageByName:name];
//}

+(NSString *) D:(NSString*)string{
    return [self globalStringWithKey:(string)];
}

+(UIFont *) F:(CGFloat)size{
    return [UIFont systemFontOfSize:(size)*WScale*kLabelFontRate];
}

//+(NSString*) E:(NSString*)string{
//    return [CCBGlobalStringHelper englishStringWithKey:string];
//}

+ (nullable NSString *)globalStringWithKey:(nonnull NSString *)key {
    static dispatch_once_t onceToken;
    static NSMutableDictionary *_strings = nil;
    dispatch_once(&onceToken, ^{
        _strings = [NSMutableDictionary dictionary];
        NSArray *fileList =
        [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSBundle mainBundle] resourcePath]
                                                            error:NULL];
        
        // 遍历所有的.strings文件，把里面的键值对都取出，保存在_strings里以供使用
        for (NSString *fileName in fileList) {
            //
            if ([fileName hasSuffix:@".strings"] && ![fileName hasSuffix:@"EN.strings"]) {
                
                NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName
                                                                                              ofType:@""]];
                NSDictionary *dictionary = [NSPropertyListSerialization propertyListFromData:data
                                                                            mutabilityOption:NSPropertyListImmutable
                                                                                      format:NULL
                                                                            errorDescription:NULL];
                [_strings addEntriesFromDictionary:dictionary];
            }
        }
    });

    NSString *string = [_strings objectForKey:key];
    if (string) {
        return string;
    }
    else {
        return key;
    }
}

+(double) G{
    return [UIScreen mainScreen].bounds.size.height/812.0;
}

@end
