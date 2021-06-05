//
//  CCBCallCenter.h
//  CCBWorkerMerchant
//
//  Created by lukeyuan on 2018/8/3.
//  Copyright © 2018年 ccb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCBCallCenter : NSObject

/*获取当前VC*/
+(CYLTabBarController *)getCurrentVc;

//解析url字符串对name=1&version=2&test=3
+(NSDictionary*)urlParamToDict:(NSString*)url;

+(NSString *)urlParamToString:(NSDictionary *)dic;
/**
 *  获取页面跳转的navigation
 */
+(UINavigationController *)navigationController;
@end
