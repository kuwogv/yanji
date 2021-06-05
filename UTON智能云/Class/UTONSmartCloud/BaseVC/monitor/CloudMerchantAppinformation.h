//
//  CloudMerchantAppinformation.h
//  AppModel
//
//  Created by pim on 14-10-17.
//  Copyright (c) 2014年 pim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CloudMerchantAppinformation : NSObject



+(NSString *)GetappName;//客户端名称
+(NSString *)GetappVersion;//应用版本号
+(NSString *)GetosVersion;//操作系统版本
+(NSString *)GetdeviceModel;//设备型号
+(NSString *)GetdeviceType;//设备类型，0未分类;1手机;2 pad;
+(NSString *)GetdevicePix;//屏幕分辨率


+(NSString *)GetscreenSize;//屏幕尺寸
+(NSString *)GetindentifierNumber;//手机序列号
+(NSString *)GetuserPhoneName;//手机别名
+(NSString *)GetappProdectsName;//工程名称
+(NSString *)isSIMInstalled;//是否插卡

//APP信息字典


@end
