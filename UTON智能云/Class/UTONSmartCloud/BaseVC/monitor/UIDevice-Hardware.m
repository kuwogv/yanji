/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

// Thanks to Emanuele Vulcano, Kevin Ballard/Eridius, Ryandjohnson, Matt Brown, etc.

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "NSString+Util.h"
#import "UIDevice-Hardware.h"
//#import <CCBStorage/CCBKeychainInterface.h>
//#import "CCBLocationUtil.h"
//#import "CCBLocationConverter.h"
#define kUUID @"MBsSavedUUID"

static NSString *m_DeviceInfo = nil;

@implementation UIDevice (Hardware)

/*
 Platforms
 
 iFPGA ->		??

 iPhone1,1 ->	iPhone 1G
 iPhone1,2 ->	iPhone 3G
 iPhone2,1 ->	iPhone 3GS
 iPhone3,1 ->	iPhone 4/AT&T
 iPhone3,2 ->	iPhone 4/Other Carrier?
 iPhone3,3 ->	iPhone 4/Other Carrier?
 iPhone4,1 ->	??iPhone 5

 iPod1,1   -> iPod touch 1G 
 iPod2,1   -> iPod touch 2G 
 iPod2,2   -> ??iPod touch 2.5G
 iPod3,1   -> iPod touch 3G
 iPod4,1   -> iPod touch 4G
 iPod5,1   -> ??iPod touch 5G
 
 iPad1,1   -> iPad 1G, WiFi
 iPad1,?   -> iPad 1G, 3G <- needs 3G owner to test
 iPad2,1   -> iPad 2G (iProd 2,1)
 
 AppleTV2,1 -> AppleTV 2

 i386, x86_64 -> iPhone Simulator
*/


#pragma mark sysctlbyname utils
- (NSString *) getSysInfoByName:(char *)typeSpecifier
{
	size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
	sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
	NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
	free(answer);
	return results;
}

- (NSString *) platform
{
	return [self getSysInfoByName:"hw.machine"];
}


// Thanks, Atomicbird
- (NSString *) hwmodel
{
	return [self getSysInfoByName:"hw.model"];
}

#pragma mark sysctl utils
- (NSUInteger) getSysInfo: (uint) typeSpecifier
{
	size_t size = sizeof(int);
	int results;
	int mib[2] = {CTL_HW, typeSpecifier};
	sysctl(mib, 2, &results, &size, NULL, 0);
	return (NSUInteger) results;
}

- (NSUInteger) cpuFrequency
{
	return [self getSysInfo:HW_CPU_FREQ];
}

- (NSUInteger) busFrequency
{
	return [self getSysInfo:HW_BUS_FREQ];
}

- (NSUInteger) totalMemory
{
	return [self getSysInfo:HW_PHYSMEM];
}

- (NSUInteger) userMemory
{
	return [self getSysInfo:HW_USERMEM];
}

- (NSUInteger) maxSocketBufferSize
{
	return [self getSysInfo:KIPC_MAXSOCKBUF];
}

#pragma mark file system -- Thanks Joachim Bean!
- (NSNumber *) totalDiskSpace
{
	NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
	return [fattributes objectForKey:NSFileSystemSize];
}

- (NSNumber *) freeDiskSpace
{
	NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
	return [fattributes objectForKey:NSFileSystemFreeSize];
}

#pragma mark platform type and name utils
- (NSUInteger) platformType
{
	NSString *platform = [self platform];
	// if ([platform isEqualToString:@"XX"])			return UIDeviceUnknown;
	
	if ([platform isEqualToString:@"iFPGA"])		return UIDeviceIFPGA;

	if ([platform isEqualToString:@"iPhone1,1"])	return UIDevice1GiPhone;
	if ([platform isEqualToString:@"iPhone1,2"])	return UIDevice3GiPhone;
	if ([platform hasPrefix:@"iPhone2"])	return UIDevice3GSiPhone;
	if ([platform hasPrefix:@"iPhone3"])			return UIDevice4iPhone;
	if ([platform hasPrefix:@"iPhone4"])			return UIDevice5iPhone;
	
	if ([platform isEqualToString:@"iPod1,1"])   return UIDevice1GiPod;
	if ([platform isEqualToString:@"iPod2,1"])   return UIDevice2GiPod;
	if ([platform isEqualToString:@"iPod3,1"])   return UIDevice3GiPod;
	if ([platform isEqualToString:@"iPod4,1"])   return UIDevice4GiPod;
		
	if ([platform isEqualToString:@"iPad1,1"])   return UIDevice1GiPad;
	if ([platform isEqualToString:@"iPad2,1"])   return UIDevice2GiPad;
	
	if ([platform isEqualToString:@"AppleTV2,1"])	return UIDeviceAppleTV2;
	
	/*
	 MISSING A SOLUTION HERE TO DATE TO DIFFERENTIATE iPAD and iPAD 3G.... SORRY!
	 */

	if ([platform hasPrefix:@"iPhone"]) return UIDeviceUnknowniPhone;
	if ([platform hasPrefix:@"iPod"]) return UIDeviceUnknowniPod;
	if ([platform hasPrefix:@"iPad"]) return UIDeviceUnknowniPad;
	
	if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"]) // thanks Jordan Breeding
	{
		if ([[UIScreen mainScreen] bounds].size.width < 768)
			return UIDeviceiPhoneSimulatoriPhone;
		else 
			return UIDeviceiPhoneSimulatoriPad;

		return UIDeviceiPhoneSimulator;
	}
	return UIDeviceUnknown;
}

- (NSString *) platformString
{
	switch ([self platformType])
	{
		case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
		case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
		case UIDevice3GSiPhone:	return IPHONE_3GS_NAMESTRING;
		case UIDevice4iPhone:	return IPHONE_4_NAMESTRING;
		case UIDevice5iPhone:	return IPHONE_5_NAMESTRING;
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
		
		case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
		case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
		case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
		case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
			
		case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
		case UIDevice2GiPad : return IPAD_2G_NAMESTRING;
			
		case UIDeviceAppleTV2 : return APPLETV_2G_NAMESTRING;
			
		case UIDeviceiPhoneSimulator: return IPHONE_SIMULATOR_NAMESTRING;
		case UIDeviceiPhoneSimulatoriPhone: return IPHONE_SIMULATOR_IPHONE_NAMESTRING;
		case UIDeviceiPhoneSimulatoriPad: return IPHONE_SIMULATOR_IPAD_NAMESTRING;
			
		case UIDeviceIFPGA: return IFPGA_NAMESTRING;
			
		default: return IPOD_FAMILY_UNKNOWN_DEVICE;
	}
}

- (NSString *)getUUID {
    NSString *appUID = [CCBKeychainInterface valueForKey:kUUID];
    if (nil == appUID || appUID.length == 0) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        appUID = CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
        appUID = [appUID stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [CCBKeychainInterface setValue:appUID ForKey:kUUID];
    }
    return appUID;
}

#pragma mark MAC addy
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
- (NSString *) macaddress
{
    double version = [[[UIDevice currentDevice] systemVersion] doubleValue];
    
    if (version>=7.0)
    {
        //内测包及有标志位时使用新的uuid方法
        if((![CCBFunctionUtil isPublicIPA]) && [CCBKeychainInterface shouldUseNewServiceName]){
            NSString *uuid = [CCBKeychainInterface valueForKey:@"ccb_new_uuid"];
            if([NSString isEmptyString:uuid]){
                uuid = [[NSUUID UUID] UUIDString];
                [CCBKeychainInterface setValue:uuid ForKey:@"ccb_new_uuid"];
            }
            return uuid;
        }
        
        NSString *appUID = [CCBKeychainInterface valueForKey:@"k_ccb_uuid"];
        
        if (nil == appUID || appUID.length == 0) {
            appUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            [CCBKeychainInterface setValue:appUID ForKey:@"k_ccb_uuid"];
            
            CCBLogDebug(@"里面%@",appUID);
        }
        CCBLogDebug(@"外面%@",appUID);
        
        return appUID;
        
    }
    
    
    
	int					mib[6];
	size_t				len;
	char				*buf;
	unsigned char		*ptr;
	struct if_msghdr	*ifm;
	struct sockaddr_dl	*sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error\n");
		return [self getUUID];
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1\n");
		return [self getUUID];
	}
	
	if ((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. error!\n");
		return [self getUUID];
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return [self getUUID];
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	// NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
}

- (NSString *) macaddressWithColon
{
    double version = [[[UIDevice currentDevice] systemVersion] doubleValue];
    
    if (version>=7.0)
    {
        
        NSString *appUID = [CCBKeychainInterface valueForKey:@"k_ccb_uuid"];
        
        if (nil == appUID || appUID.length == 0) {
            
            appUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            [CCBKeychainInterface setValue:appUID ForKey:@"k_ccb_uuid"];
            
            CCBLogDebug(@"里面%@",appUID);
        }
        CCBLogDebug(@"外面%@",appUID);
        
        return appUID;
        
        
    }
    
    
    
	int					mib[6];
	size_t				len;
	char				*buf;
	unsigned char		*ptr;
	struct if_msghdr	*ifm;
	struct sockaddr_dl	*sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error\n");
		return [self getUUID];
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1\n");
		return [self getUUID];
	}
	
	if ((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. error!\n");
		return [self getUUID];
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return [self getUUID];
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
}

- (NSString *) platformCode
{
	switch ([self platformType])
	{
		case UIDevice1GiPhone: return @"M68";
		case UIDevice3GiPhone: return @"N82";
		case UIDevice3GSiPhone:	return @"N88";
		case UIDevice4iPhone: return @"N89";
		case UIDevice5iPhone: return IPHONE_UNKNOWN_NAMESTRING;
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
			
		case UIDevice1GiPod: return @"N45";
		case UIDevice2GiPod: return @"N72";
		case UIDevice3GiPod: return @"N18"; 
		case UIDevice4GiPod: return @"N80";
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
			
		case UIDevice1GiPad: return @"K48";
		case UIDevice2GiPad: return IPAD_UNKNOWN_NAMESTRING;
		case UIDeviceUnknowniPad: return IPAD_UNKNOWN_NAMESTRING;
			
		case UIDeviceAppleTV2:	return @"K66";

		case UIDeviceiPhoneSimulator: return IPHONE_SIMULATOR_NAMESTRING;
			
		default: return IPOD_FAMILY_UNKNOWN_DEVICE;
	}
}

// Illicit Bluetooth check -- cannot be used in App Store
/* 
Class  btclass = NSClassFromString(@"GKBluetoothSupport");
if ([btclass respondsToSelector:@selector(bluetoothStatus)])
{
	printf("BTStatus %d\n", ((int)[btclass performSelector:@selector(bluetoothStatus)] & 1) != 0);
	bluetooth = ((int)[btclass performSelector:@selector(bluetoothStatus)] & 1) != 0;
	printf("Bluetooth %s enabled\n", bluetooth ? "is" : "isn't");
}
*/

+ (NSString *) getMBC_User_Info
{
    //modify by db 3.20
    
    NSString *mbsUserInfo = @"";
    NSString *latitudeStr = @"";
    NSString *longitudeStr = @"";
    
    
    if (nil == m_DeviceInfo || [m_DeviceInfo length] == 0)
    {
        [UIDevice  getDeviceInfo];
    }
    
    NSString *userToken = @"";
    NSString *GPSFlag = @"0";
    
    @try {
        userToken = [[CCBKeychainInterface valueForKey:@"UserToken" ] isEmpty] ? @"" :[CCBKeychainInterface valueForKey:@"UserToken"];
        
    }
    @catch (NSException *exception) {
        CCBLogDebug(@"exception:%@",exception);
    }
    @finally {
        
    }
    
    @try {
        
        CCBLocationUtil *locationUtil = [CCBLocationUtil getInstnce];
        
        CLLocationCoordinate2D bankCoordinate;
        bankCoordinate.longitude = locationUtil.locationModel.longitude;
        bankCoordinate.latitude =  locationUtil.locationModel.latutide;
        const double MAX = 0.0000001;
        const double MIN = -0.0000001;
        BOOL isZero = (bankCoordinate.latitude < MAX && bankCoordinate.latitude > MIN) &&
        (bankCoordinate.longitude < MAX && bankCoordinate.longitude > MIN);
        
        if(!isZero){
            bankCoordinate = [CCBLocationConverter gcj02ToBd09:bankCoordinate];
        }
        
        latitudeStr = [NSString stringWithFormat:@"%f",bankCoordinate.latitude];
        latitudeStr = ([@"" isEqualToString:latitudeStr]?@"0":latitudeStr);
        longitudeStr = [NSString stringWithFormat:@"%f",bankCoordinate.longitude];
        longitudeStr = ([@"" isEqualToString:longitudeStr]?@"0":longitudeStr);
        
        NSInteger flag = [locationUtil GPSFlag];
        GPSFlag = [NSString stringWithFormat:@"%ld",flag];
//        GPSFlag = @"0";
    }
    @catch (NSException *exception) {
        CCBLogDebug(@"exception:%@",exception);
    }
    @finally {
        
    }
     //根据最新安全措施的要求，需要客户端增加上送GPS服务是否打开标识，请在原字段MBC-User-Info字段后面增加一个新字段，用户存放GPS服务是否打开标识，即新MBC-User-Info内容如下：（蓝色部分为本次增加的字段，0表示关闭，1表示打开）
    NSString *mbsUserInfoStr = [NSString stringWithFormat:@"MBCCB/*/%@/*/%@/*/%@/*/%@/*/%@",userToken,m_DeviceInfo,longitudeStr,latitudeStr, GPSFlag];
    CCBLogDebug(@"mbsUserInfoStr = %@",mbsUserInfoStr);
    mbsUserInfo = [[NSString alloc]initWithFormat:@"%@",[GTMCCBBase64 stringByEncodingData:[mbsUserInfoStr dataUsingEncoding:NSUTF8StringEncoding]]];
    
    return mbsUserInfo;
    
}

+(void *)getDeviceInfo
{
    
    //国际移动设备身份码(IMEI)
    NSString *IMEI = @"00000000000000";
    
    //客户自定义的手机设备名称
    NSString *deviceName = @"";
    //操作系统
    NSString *deviceSystemName = @"";
    //内核版本号
    NSString *devicesystemVersion = @"";
    //设备型号
    NSString *deviceModel = @"";
    //分辨率
    NSString* screenSize = @"";
    //无线硬件位址(WIFI MAC)
    NSString *mac = @"0";
    
    //无线网络上报终端所处的小区号(CellId)
    NSString *cellID = @"";
    //某位置区域码或GSM网络内基站或者基站扇区的CID
    NSString *CID = @"";
    @try {
        
        //客户自定义的手机设备名称
        deviceName = [NSString isEmptyString:[[UIDevice currentDevice] name]] ? @"" : [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] name]];
        
    }
    @catch (NSException *exception) {
        CCBLogDebug(@"exception:%@",exception);
    }
    @finally {
        
    }
    @try {

        //操作系统
        deviceSystemName = [NSString isEmptyString:[[UIDevice currentDevice] systemName]] ? @"" : [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemName]];

    }
    @catch (NSException *exception) {
        CCBLogDebug(@"exception:%@",exception);
    }
    @finally {
        
    }
    @try {
        //内核版本号
        devicesystemVersion = [NSString isEmptyString:[[UIDevice currentDevice] systemVersion]] ? @"" : [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];

    }
    @catch (NSException *exception) {
        CCBLogDebug(@"exception:%@",exception);
    }
    @finally {
        
    }
    @try {
        //设备型号
        deviceModel = [NSString isEmptyString:[[UIDevice currentDevice] model]] ? @"" : [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] model]];

    }
    @catch (NSException *exception) {
        CCBLogDebug(@"exception:%@",exception);
    }
    @finally {
        
    }
    @try {
 
        //分辨率
        screenSize = [NSString stringWithFormat:@"%d*%d",(int)([[UIScreen mainScreen] applicationFrame].size.width*[UIScreen mainScreen].scale),(int)([[UIScreen mainScreen] applicationFrame].size.height*[UIScreen mainScreen].scale)];
        
    }
    @catch (NSException *exception) {
        CCBLogDebug(@"exception:%@",exception);
    }
    @finally {
        
    }
    @try {
        //无线硬件位址(WIFI MAC)
        mac = [NSString isEmptyString:[[UIDevice currentDevice]macaddress]] ? @"0" : [NSString stringWithFormat:@"%@",[[UIDevice currentDevice]macaddressWithColon]];
        
        
        
    }
    @catch (NSException *exception) {
        CCBLogDebug(@"exception:%@",exception);
    }
    @finally {
        
    }
    
    m_DeviceInfo = [[NSString stringWithFormat:@"%@/*/%@/*/%@/*/%@/*/%@/*/%@/*/%@/*/%@/*/%@",IMEI,deviceName,deviceSystemName,devicesystemVersion,deviceModel,screenSize,mac,cellID,CID]copy];
    
}

+ (NSString*)getDeviceUUID{
//    return [[UIDevice currentDevice] getUUID];
    return [[UIDevice currentDevice] macaddress];
}

@end
