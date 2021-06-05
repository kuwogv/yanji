//
//  CCBCallCenter.m
//  CCBWorkerMerchant
//
//  Created by lukeyuan on 2018/8/3.
//  Copyright © 2018年 ccb. All rights reserved.
//

#import "CCBCallCenter.h"

@implementation CCBCallCenter

+(CYLTabBarController *)getCurrentVc
{
    CYLTabBarController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *w in windows) {
            UIView *frontView1 = [[w subviews]objectAtIndex:0];
            if (![frontView1 isKindOfClass:NSClassFromString(@"UnityView")]) {
                if (w.windowLevel == UIWindowLevelNormal) {
                    window = w;
                    break;
                }
            }
        }
    }
    
    UIView *frontView = [[window subviews]objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[CYLTabBarController class]])
        result = nextResponder;
    else
        result = (CYLTabBarController*)window.rootViewController;
    return result;
}

+(NSString *)urlParamToString:(NSDictionary *)dic{
    NSMutableArray *tempAry = [NSMutableArray array];
    NSArray *keyary = [dic allKeys];
    for (NSString *key in keyary) {
        NSString *valueString = [dic objectForKey:key];
        NSString *formatStr = [NSString stringWithFormat:@"%@=%@",key,valueString];
        [tempAry addObject:formatStr];
    }
    NSString *finalStr = [tempAry componentsJoinedByString:@"&"];
    return finalStr;
}

//解析url字符串对name=1&version=2&test=3
+(NSDictionary*)urlParamToDict:(NSString*)url {
    if (url == nil || url.length == 0) {
        return nil;
    }
    return [CCBCallCenter parametersWithSeparator:@"=" delimiter:@"&" url:url];
}

//解析url字符串对key1[separator]value1[delimiter]key2[separator]value2[delimiter]key3[delimiter]value3
+ (NSDictionary *)parametersWithSeparator:(NSString *)separator delimiter:(NSString *)delimiter url:(NSString *)str{
    NSArray *parameterPairs =[str componentsSeparatedByString:delimiter];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:[parameterPairs count]];
    for (NSString *currentPair in parameterPairs) {
        NSRange range = [currentPair rangeOfString:separator];
        if(range.location == NSNotFound)
            continue;
        NSString *key = [currentPair substringToIndex:range.location];
        NSString *value =[currentPair substringFromIndex:range.location + 1];
        [parameters setObject:value forKey:key];
    }
    return parameters;
}

/**
 *  获取页面跳转的navigation
 */
+(UINavigationController *)navigationController {
    CYLTabBarController *sideView = (CYLTabBarController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if ([sideView isKindOfClass:[CYLTabBarController class]]) {
        UINavigationController *navigation = (UINavigationController *)sideView.parentViewController;
        return navigation;
    }
    else {
        return nil;
    }
}

@end
