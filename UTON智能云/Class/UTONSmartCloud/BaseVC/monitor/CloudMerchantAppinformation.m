//
//  CloudMerchantAppinformation.m
//  AppModel
//
//  Created by pim on 14-10-17.
//  Copyright (c) 2014年 pim. All rights reserved.
//

#import "CloudMerchantAppinformation.h"
#import <sys/sysctl.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation CloudMerchantAppinformation





+(NSString *)GetappName
{
    NSString *String;
    
    String=[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    
    return String;
}

+(NSString *)GetappProdectsName
{
    NSString *String;
    
    String=[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]];
    
    return String;
}

+(NSString *)GetappVersion;
{
    //2015.3.23
        NSString *WhichVersion =[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
    
        return WhichVersion;
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    return [CCBGlobalVersionHelper getTechFullVersion];
}
+(NSString *)GetosVersion;
{
    NSString *String;
    
    String=[NSString stringWithFormat:@"%0.1f",[[[UIDevice currentDevice] systemVersion] floatValue]];
    
    return String;
}
+(NSString *)GetdeviceModel;
{
    // Gets a string with the device model
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    /*
     size_t size;
     sysctlbyname("hw.machine", NULL, &size, NULL, 0);
     char *machine = malloc(size);
     sysctlbyname("hw.machine", machine, &size, NULL, 0);
     NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
     free(machine);
     */
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c(GSM)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])    return @"iPhone 8 Global";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus Global";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"iPhone X Global";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8 GSM";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus GSM";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"iPhone X GSM";
    if ([platform isEqualToString:@"iPhone11,2"])    return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])    return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"])    return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone13,1"])   return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"])   return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"])   return @"iPhone 12 Pro Max";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad MIni 2";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad MIni 2";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad MIni 2";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad MIni 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad MIni 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad MIni 3";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";




    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    
    return platform;
}


+(NSString *)GetdeviceType
{
    NSString *String;
    
    String=[NSString stringWithFormat:@"%@",[[UIDevice currentDevice] model]];
    if([String isEqualToString:@"iPhone"])
        String=@"1";
    else if([String isEqualToString:@"iPad"])
        String=@"2";
    else
        String=@"0";
    
    return String;
}
+(NSString *)GetdevicePix
{
    NSString *String;
    
    CGFloat scale_screen=[[UIScreen mainScreen]scale];
    
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat width=size.width;
    CGFloat height=size.height;
    
    String=[NSString stringWithFormat:@"%0.0f*%0.0f",height*scale_screen,width*scale_screen];
    return String;
}

+(NSString *)GetindentifierNumber//手机序列号
{
    NSString *String;
    
    String=[NSString stringWithFormat:@"%@",[[[UIDevice currentDevice]identifierForVendor] UUIDString]];
    
    return String;
}
+(NSString *)GetuserPhoneName//手机别名

{
    NSString *String;
    
    
    String=[NSString stringWithFormat:@"%@",[[UIDevice currentDevice] name]];
    
    return String;
}

+(NSString *)GetscreenSize//屏幕尺寸
{
    NSString *String;
    
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat width=size.width;
    CGFloat height=size.height;
    
    String=[NSString stringWithFormat:@"%0.0f*%0.0f",height,width];
    
    return String;
    
}

+(NSString *)isSIMInstalled{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];

    CTCarrier *carrier = [networkInfo subscriberCellularProvider];

    if (!carrier.isoCountryCode) {

         NSLog(@"请安装好手机SIM卡后在拨打电话.");

         return @"0";

      }else{

           NSLog(@"存在SIM卡");

           return @"1";

      }
}


@end
