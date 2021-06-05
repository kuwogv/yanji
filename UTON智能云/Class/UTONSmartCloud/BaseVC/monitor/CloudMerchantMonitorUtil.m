//
//  CloudMerchantMonitorUtil.m
//  CCBClientV2
//
//  Created by mac on 15-5-19.
//  Copyright (c) 2015年 llbt. All rights reserved.
//

#import "CloudMerchantMonitorUtil.h"
//#import "CloudMerchantLFCGzipUtility.h"
//#import "CloudMerchantMonitorManage.h"
#import "CloudMerchantAppinformation.h"
//#import "CCBUserData.h"
//#import "CloudMerchantSessionManage.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import "ReachabilComTechParamValifyTestity.h"
//#import "CloudMerchantMonitorViewModel.h"
//#import "CCBLocationManager.h"
#import "Reachability.h"
#import "AFNetworkReachabilityManager.h"
BOOL isSendingData = NO;  // 用于识别是否正常上送数据，避免服务端未返回重复上送。YES表示是，NO表示不是
BOOL isWaittingSentData = NO;  // 用于识别上送数据失败倒计时，避免重复计时。YES表示是，NO表示不是
@implementation CloudMerchantMonitorUtil

/**
 *  客户会话类（key: SESSION）1）客户会话生成时，客户端生成一次数据，该会话过期前不在重新生成。2）会话ID设置超时时间，作为参数可配置。3）如有字段无法采集，则在json中无需上送相关字段
 */
//会话ID
//+ (NSString *)getUDC_SESSION_ID:(NSString *)pageId
//{
//    NSString *sessionId = [[CloudMerchantSessionManage sharedInstance] getSessionId:pageId];
//    return sessionId;
//}

//页面ID
+ (NSString *)getUDC_PAGE_ID
{
    return @"";
}

//客户访问渠道
+ (NSString *)getUDC_CHANNEL_ID
{
    return @"03";
}

//会话时间戳
+ (NSString *)getUDC_SESSION_DTTM
{
    return @"";
}

//入口页面ID，会话开始的页面
+ (NSString *)getUDC_ENTER_PAGE_ID
{
    return @"";
}

//运营商类型
+ (NSString *)getUDC_TELECOM_OPER
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    
    NSString *imsi = [NSString stringWithFormat:@"%@%@", mcc, mnc];

    return imsi;
}

//IP地址
+ (NSString *)getUDC_IP
{
    return @"";
}

+ (NSString *)getUDC_GPS
{
    return @"";
}

//GPS经度
//+ (NSString *)getUDC_LONGITUDE
//{
//    CCBLocationUtil *location = [CCBLocationUtil getInstnce];
//    CCBLocationModel *locationModel = [location getLocationModel];
//    NSString *longitude = locationModel.longitude != 0 ? [NSString stringWithFormat:@"%.6f",locationModel.longitude] : @"";
//    return longitude;
//}

//GPS纬度
//+ (NSString *)getUDC_LATITUDE
//{
//    CCBLocationUtil *location = [CCBLocationUtil getInstnce];
//    CCBLocationModel *locationModel = [location getLocationModel];
//    NSString *latutide = locationModel.latutide != 0 ? [NSString stringWithFormat:@"%.6f",locationModel.latutide] : @"";
//    return latutide;
//}

//设备类型
+ (NSString *)getUDC_CLIENT_TYPE
{
    return [[UIDevice currentDevice] model];
}

//操作系统类型
+ (NSString *)getUDC_OS_TYPE
{
    return [[UIDevice currentDevice] systemName];
}

//操作系统版本
+ (NSString *)getUDC_OS_VERSION
{
    return [[UIDevice currentDevice] systemVersion];
}

//屏幕分辨率
+ (NSString *)getUDC_SCREEN_RESOLUTION
{
    NSString *screenSize = [NSString stringWithFormat:@"%d*%d",(int)([[UIScreen mainScreen] applicationFrame].size.width*[UIScreen mainScreen].scale),(int)([[UIScreen mainScreen] applicationFrame].size.height*[UIScreen mainScreen].scale)];
    return screenSize;
}

//尺寸大小
+ (NSString *)getUDC_SCREEN_SIZE
{
    return [CloudMerchantAppinformation GetscreenSize];
}

//机型：手机型号
+ (NSString *)getUDC_MECHINE_TYPE
{
    return [CloudMerchantAppinformation GetdeviceModel];
}

//APP版本
+ (NSString *)getUDC_APP_VERSION
{
    return [CloudMerchantAppinformation GetappVersion];
}

//网络类型
+ (NSString *)getUDC_NET_TYPE
{
    static NSString *netStr = @"1";
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                
                break;
            case 0:
                
                break;
            case 1:{//4g
//                netStr = @"1";
                netStr = @"1";
            }
                break;
            case 2:{//wifi
                netStr = @"0";
            }
                break;
            default:
                break;
        }
    }];
//    // 3.判断网络状态
//    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
//        netStr = @"0";
//    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
//        netStr = @"1";
//    } else { // 没有网络
//        netStr = @"";
//    }
    return netStr;
}

//MAC地址
+ (NSString *)getUDC_MAC_ADDRESS
{
    //框架里有API
    return @"";
}


/**
 *  页面浏览类(key: PAGE_VIEW)1）打开页面时，需采集页面访问时间 2）退出页面时，需采集页面推出时间。页面停留时间 3）页面ID：采集该页面通用的页面ID
 */
//页面名称:精确到毫秒 20160701020304567
+ (NSString *)getUDC_PAGE_NAME
{
    return @"";
}

//页面打开/退出时间:精确到毫秒，取上两者的差值
+ (NSString *)getUDC_PAGE_TIME
{
    return @"";
}

//页面停留时间
+ (NSString *)getUDC_PAGE_STAY_TIME
{
    return @"";
}

//打开/退出标志:0：打开， 1：退出
+ (NSString *)getUDC_IS_OPEN
{
    return @"";
}

//备注字段:记录产品ID或产品名称
+ (NSString *)getUDC_OTHER1
{
    return @"";
}


/**
 *  客户识别类（key: VISITOR_IDENTIFICATION）1）每次客户登录后触发采集，采集客户身份证号 2）安卓与iOS的设备标识分别采集到两个字段中
 */
//设备标志
//+ (NSString *)getUDC_DEVICE_ID
//{
//    return [[UIDevice currentDevice] macaddress];
//}

//软设备标示
+ (NSString *)getUDC_SID
{
    return @"";
}

//用户ID
+ (NSString *)getUDC_CUSTOMER_ID
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    return [CloudMerchantMonitorUtil stringEmptyHandle:userId];
}

//客户识别时间戳
+ (NSString *)getUDC_IDENT_DTTM
{
    return [CloudMerchantMonitorUtil stringEmptyHandle:[CloudMerchantMonitorUtil getTimeStamp]];
}

/**
 *  广告点击明细类（key: AD_CLICKS）
 */
//广告点击时间戳
+ (NSString *)getUDC_AD_CLICK_DTTM
{
    return @"";
}

//广告ID
+ (NSString *)getUDC_AD_ID
{
    return @"";
}

//广告栏位ID
+ (NSString *)getUDC_POS_ID
{
    return @"";
}

//广告目的URL
+ (NSString *)getUDC_AD_CURRENT_URL
{
    return @"";
}


/**
 *  点击类（key: CLICKS）
 */
//按钮ID:页面ID+按钮ID唯一确定一个按钮
+ (NSString *)getUDC_BUTTON_ID
{
    return @"";
}

//按钮名称
+ (NSString *)getUDC_BUTTON_NAME
{
    return @"";
}

//点击时间戳
+ (NSString *)getUDC_CLICK_DTTM
{
    return @"";
}

/**
 *  搜索关键词类（key: KEYWORD）
 */
//内部搜索关键词
+ (NSString *)getUDC_INTERNAL_SEARCH_KEYWORD
{
    return @"";
}

//搜索时间戳
+ (NSString *)getUDC_SEARCH_DTTM
{
    return @"";
}

/**
 *  产品浏览类（key: PRODUCT_VIEW）
 */
//产品ID：如果取不到，则送产品名称。信用卡送卡种代码
+ (NSString *)getUDC_PRODUCT_ID
{
    return @"";
}

//产品名称
+ (NSString *)getUDC_PRODUCT_NAME
{
    return @"";
}

//浏览时间戳
+ (NSString *)getUDC_VIEW_DTTM
{
    return @"";
}

//延时时间戳
+ (NSString *)getUDC_EXTRA_DTTM
{
    return @"";
}

/**
 *  产品交易类（key: PRODUCT_TRAD）【采集成功页面】与产品浏览类一样
 */

/**
 *  广告曝光类（key: AD_DISPLAY）
 */
//广告展示时间戳
+ (NSString *)getUDC_AD_DTTM
{
    return @"";
}

/**
 *  错误信息类(key: ERR_MESG)
 */
//错误代码：以新一代错误码为准
+ (NSString *)getUDC_ERR_CODE
{
    return @"";
}

//错误信息：1）弹窗提示信息内容 2）“异常退出” 3）“操作无响应
+ (NSString *)getUDC_ERR_MESG
{
    return @"";
}

+ (void)getSessionInfo:(NSDictionary *)session
{
    NSString *dicString = [CloudMerchantMonitorUtil dictionanyTransformToString:session];
    [CloudMerchantMonitorUtil writePageData:dicString];
}

//页面浏览类
+ (void)getPageViewInfo:(NSInteger)type andDict:(NSDictionary *)dict
{
    NSMutableDictionary *collectionDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
//    [collectionDict setValue:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"UDC_IS_OPEN"];//打开/退出标志,0：打开， 1：退出
//    [collectionDict setValue:[CloudMerchantMonitorUtil getUDC_OTHER1] forKey:@"UDC_OTHER1"];//备注字段,记录产品ID或产品名称
//    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:collectionDict timeStamp:@"UDC_PAGE_TIME" withType:@"PAGE"];
     [CloudMerchantMonitorUtil publicDictionaryForDataCollection:collectionDict withType:@"PAGE"];
}
//
//客户识别类
+ (void)getVisitorIdentification:(NSDictionary *)dict
{
    NSMutableDictionary *collectionDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [collectionDict setValue:[CloudMerchantMonitorUtil getUDC_CHANNEL_ID] forKey:@"UDC_CHANNEL_ID"];//客户访问渠道
//    [collectionDict setValue:[CloudMerchantMonitorUtil getUDC_DEVICE_ID] forKey:@"UDC_DEVICE_ID"];//设备标志
    [collectionDict setValue:[CloudMerchantMonitorUtil getUDC_SID] forKey:@"UDC_SID"];//设备软标识
    [collectionDict setValue:[CloudMerchantMonitorUtil getUDC_CUSTOMER_ID] forKey:@"UDC_CUSTOMER_ID"];//用户ID
    [collectionDict setValue:[CloudMerchantMonitorUtil getUDC_OS_TYPE] forKey:@"UDC_OS_TYPE"];//操作系统类型
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:collectionDict timeStamp:@"UDC_IDENT_DTTM" withType:@"VISITOR_IDENTIFICATION"];
}

//广告点击明细类
+ (void)getAdClicks:(NSDictionary *)dict
{
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:dict timeStamp:@"UDC_AD_CLICK_DTTM" withType:@"AD_CLICKS"];
}

//点击类
+ (void)getClicks:(NSDictionary *)dict
{
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:dict timeStamp:@"UDC_CLICK_DTTM" withType:@"CLICK"];
}

//搜索关键词类
+ (void)getKeyWord:(NSDictionary *)dict
{
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:dict timeStamp:@"UDC_SEARCH_DTTM" withType:@"KEYWORD"];
}

//产品浏览类、产品交易类
+ (void)getProductView:(NSDictionary *)dict andType:(NSInteger)type
{
    NSString *typeValue = type == 0 ? @"PRODUCT_VIEW" : @"PRODUCT_TRAD";
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:dict timeStamp:@"UDC_VIEW_DTTM" withType:typeValue];
}

//广告曝光类
+ (void)getAdDisplay:(NSDictionary *)dict
{
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:dict timeStamp:@"UDC_AD_DTTM" withType:@"AD"];
}

//错误信息类
+ (void)getErrMESG:(NSDictionary *)dict
{
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:dict timeStamp:@"" withType:@"ERR_MESG"];
}

//风控位置采集信息
+ (void)getCFRM:(NSDictionary *)dict
{
    NSMutableDictionary *collectionDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
//    [collectionDict setValue:[CCBUserData get_BindMobileNO] forKey:@"UDC_CUSTOMER_ID"];//用户ID
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:collectionDict timeStamp:@"" withType:@"CFRM"];
}


// 移动经理风险信息类
+ (void)getEmpRisk:(NSDictionary *)dict
{
    NSMutableDictionary *collectionDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [collectionDict setValue:[CloudMerchantMonitorUtil getUDC_IP] forKey:@"IP_ADDR"]; //   获取IP地址
//    [collectionDict setValue:[UIDevice getDeviceUUID] forKey:@"TERM_INF"];//获取UUID
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:collectionDict timeStamp:@"" withType:@"EMP_RISK"];
}

//延时采集类
+ (void)getEXTRA:(NSDictionary *)dict{
    [CloudMerchantMonitorUtil publicDictionaryForDataCollection:dict withType:@"EXTRA"];
}


//对数据采集信息处理，dict:公共字典，time：本类时间戳，type：采集信息类型
+ (void)publicDictionaryForDataCollection:(NSDictionary *)dict timeStamp:(NSString *)time withType:(NSString *)type
{
    //UDC_SESSION_ID：会话id；UDC_DTTM：新增上送公共时间戳字段
    NSMutableDictionary *publicDict = [[NSMutableDictionary alloc] init];
    [publicDict addEntriesFromDictionary:dict];
    //风控位置采集信息,CFRM，移动经理风险信息类：EMP_RISK不需要上送UDC_SESSION_ID
//    if (![@"CFRM" isEqualToString:type] && ![@"EMP_RISK" isEqualToString:type] && ![@"APPID" isEqualToString:type]) {
//        [publicDict setValue:[CloudMerchantMonitorUtil getUDC_SESSION_ID:dict[@"UDC_PAGE_ID"]] forKey:@"SESSION_ID"];
//    }
    //判断原数据是否包含会员编号，没有就增加上送会员编号
//    if(![[publicDict allKeys] containsObject:@"MEB_ID"]){
//        [publicDict setValue:[CloudMerchantMonitorUtil                                                        stringEmptyHandle:[[CCBUserDefaults standardUserDefaults] valueForKey:@"Usr_ID"]] forKey:@"MEB_ID"];
//    }
    //错误信息类：ERR_MESG，风控位置采集信息：CFRM，移动经理风险信息类：EMP_RISK不需要上送本类时间戳
//    if (![@"CFRM" isEqualToString:type] && ![@"ERR_MESG" isEqualToString:type] && ![@"EMP_RISK" isEqualToString:type] && ![@"APPID" isEqualToString:type] && ![@"CLICK" isEqualToString:type]) {
//        [publicDict setValue:[CloudMerchantMonitorUtil getTimeStamp] forKey:time];
//    }
    
    //新增上送公共时间戳字段
    [publicDict setValue:[CloudMerchantMonitorUtil getTimeStampNewFormart] forKey:@"DTM"];
//    CCBLogDebug(@"------->>publicDict:%@---\ndict%@",publicDict,dict);
    NSDictionary *finalDict = @{@"TYPE":type,@"VALUE":publicDict};
    NSString *dicString = [CloudMerchantMonitorUtil dictionanyTransformToString:finalDict];
    NSRange redirectRange = [dicString rangeOfString:@"DTM"];
    NSMutableString *mutableDicString = [NSMutableString stringWithString:dicString];
    [mutableDicString insertString:@" " atIndex:redirectRange.location+16];
    [CloudMerchantMonitorUtil writePageData:(NSString*)mutableDicString];
}

+ (void)publicDictionaryForDataCollection:(NSDictionary *)dict withType:(NSString *)type{
//    NSDictionary *collectionDict = [CCBComTechParamManager getComTechDictByName:@"DataCollection"];
//    NSArray *typeDic = [collectionDict valueForKey:@"types"];
//    NSMutableArray *typeAry = [NSMutableArray array];
//    if (typeDic) {
//        typeAry = [typeDic mutableCopy];
//        if (typeAry.count==0) {
//            [typeAry addObjectsFromArray:@[@"AD",@"SECCION",@"PAGE",@"CLICK",@"EXTRA"]];
//        }
//
//    }else{
//        [typeAry addObjectsFromArray:@[@"AD",@"SECCION",@"PAGE",@"CLICK",@"EXTRA"]];
//    }
//    BOOL isType = [typeAry containsObject:type];
//    if (isType==NO) {
//        return;
//    }
//    NSMutableDictionary *publicDict = [[NSMutableDictionary alloc] init];
//    [publicDict addEntriesFromDictionary:dict];
//    [publicDict setValue:[CloudMerchantMonitorUtil getUDC_SESSION_ID:dict[@"UDC_PAGE_ID"]] forKey:@"SESSION_ID"];
//    [publicDict setValue:[CloudMerchantMonitorUtil getTimeStampNewFormart] forKey:@"DTM"];
    //延时采集要有经纬度
//    if ([@"EXTRA" isEqualToString:type] ) {
//        if(![[publicDict allKeys] containsObject:@"LONGITUDE"]||![[publicDict allKeys] containsObject:@"LATITUDE"]){
//            NSDictionary *cityInfo = [[CCBLocationManager sharedLocationManager] cityDict];
//            if (cityInfo) {
//            }else{
//                cityInfo = @{@"cityName":@"北京市",@"ltt":@"39.9",@"lgt":@"116.4"};
//            }
//            [publicDict setValue:cityInfo[@"lgt"] forKey:@"LONGITUDE"];
//            [publicDict setValue:cityInfo[@"ltt"] forKey:@"LATITUDE"];
//        }
//
//    }
//    //判断原数据是否包含会员编号，没有就增加上送会员编号
//    if(![[publicDict allKeys] containsObject:@"MEB_ID"]){
//        [publicDict setValue:[CloudMerchantMonitorUtil                                                        stringEmptyHandle:[[CCBUserDefaults standardUserDefaults] valueForKey:@"Usr_ID"]] forKey:@"MEB_ID"];
//    }
//    CCBLogDebug(@"------->>publicDict:%@---\ndict%@",publicDict,dict);
//    NSDictionary *finalDict = @{@"TYPE":type,@"VALUE":publicDict};
//    NSString *dicString = [CloudMerchantMonitorUtil dictionanyTransformToString:finalDict];
//    NSRange redirectRange = [dicString rangeOfString:@"DTM"];
//    NSMutableString *mutableDicString = [NSMutableString stringWithString:dicString];
//    [mutableDicString insertString:@" " atIndex:redirectRange.location+16];
//    [CloudMerchantMonitorUtil writePageData:(NSString*)mutableDicString];
}

//判空
+ (NSString *)stringEmptyHandle:(NSString *)string
{
    if (!string || [string isEqual:[NSNull null]]) {
        return @"";
    }
    return string;
}


//字典转换json格式字符串
+ (NSString *)dictionanyTransformToString:(NSDictionary *)dict
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}


//页面访问时间
+(NSString *)getTimeStamp
{
    
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    [nsdf setDateStyle:NSDateFormatterShortStyle];
    [nsdf setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *dateString=[nsdf stringFromDate:[NSDate date]];
//    CCBLogDebug(@"===================dateString=%@",dateString);
    return dateString;
}

//页面访问时间新
+(NSString *)getTimeStampNewFormart
{
    
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    [nsdf setDateStyle:NSDateFormatterShortStyle];
    [nsdf setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *dateString=[nsdf stringFromDate:[NSDate date]];
//    CCBLogDebug(@"===================dateStringNew=%@",dateString);
    return dateString;
}

//用于算时间差
+ (NSString *)getDttm
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval sec=[date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", sec];//转为字符型
//    CCBLogDebug(@"===================timeString=%@",timeString);
    return timeString;
}

//压缩
//+(NSData *)stringForZip:(NSString *)unZipString
//{
//    NSData *resultData = [unZipString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
////    resultData = [CloudMerchantLFCGzipUtility gzipData:resultData];
//    return resultData;
//}

//获取页面元素 并组装采集数据串并保存
+(void)writePageData:(NSString *)pageString
{
//    BOOL onlyWhiteList = NO; // 默认所有都进行采集
//    NSDictionary *collectionDict = [MbsUserDefault dictionaryForKey:@"DataCollectDict"];
    // 采集用户处理
//    NSString *whiteListStr = [collectionDict objectForKey:@"WhiteList"];
//    if (whiteListStr) { // 如果有值
//        onlyWhiteList = [whiteListStr boolValue];
//    }
    
    // 获取当前用户是否为白名单
//    NSString * secureString=[CheckVersionIsLegal getFuncVersion];
//    BOOL iswhite = [FunctionUtil isWhiteClient:secureString location:2];  // 判断当前用户状态
//    if (iswhite && onlyWhiteList == YES) return;  // 当前是不是白名单用户而且采集的只是白名单时直接返回
    
//    BOOL CCBDatacollection = [[CCBUserDefaults standardUserDefaults] objectForKey:@"CCBDatacollection"];
//    if (!CCBDatacollection) return;
    // 创建一个表
//    if (![MbsSqlManager isTableExists:@"cloudMerchant_shujucaiji"]) { // 如果不存在创建一个表
//        [MbsSqlManager executeSqlWithTableString:@"create table if not exists cloudMerchant_shujucaiji(id integer primary key,pagestring text)"];
//    }
    

//    pageString = [self stringReplaceStr:pageString];
    
//    [[LoginDataManager getMonitorArray] addObject:pageString]; // 将采集到的信息添加到数组中，准备需要时使用
    
    // 将采集的信息添加到数据库表中
    // 插入一条数据到数据库表中
    NSString *insertStr = [NSString stringWithFormat:@"insert into cloudMerchant_shujucaiji(pagestring) values('%@')",pageString]; // 先暂时不加密
//    [MbsSqlManager executeSqlWithTableString:insertStr];
//    [self checkAndUpdateToSever];
}


// 将采集到的数据放到服务器，每次上送几条数据
//+(void)checkAndUpdateToSever
//{
//    if (isSendingData) {
//        if (!isWaittingSentData) {
//            isWaittingSentData = YES;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    isSendingData = NO;
//                isWaittingSentData = NO;
//            });
//        }
//        return;//上一次上送服务端没返回，不上送。
//    }
//    BOOL CCBDatacollection = [[CCBUserDefaults standardUserDefaults] boolForKey:@"CCBDatacollection"];
//    if (!CCBDatacollection) return;
//    
//    PolicyAllowType whiteType = [CCBFunctionUtil whiteCustPolicy:@"whitelist_datacollection"];
//    if (whiteType != AllowType) return;
    
    //在规则采集时将信息放到UserDefaults中，在此从其中取出值既可  包括地址，是否wifi，
    //BOOL onlyWifi = YES; // 是否只在wifi下提交
//    NSInteger localMinCount = 10; //本地超过几条开始上送
//    NSInteger uploadMaxConts = 100; // 默认最多一次上传五条
//    NSDictionary *collectionDict = [CCBComTechParamManager getComTechDictByName:@"DataCollection"];
//
//    if (collectionDict) {
//        BOOL dataCollectionSwitch = [[collectionDict valueForKey:@"OnOff"] boolValue];
//        if (!dataCollectionSwitch) return; // 如果总开关为关闭状态则直接不进行数据上送
//
//       NSDictionary *sendDic = (NSDictionary *)[collectionDict valueForKey:@"Send"];
//
////        NSString *wifiSwitchStr = [sendDic valueForKey:@"OnlyWifi"];
////        if (wifiSwitchStr) { // 如果有值
////            onlyWifi = [wifiSwitchStr boolValue];
////        }
//
//        NSInteger localMin = [[sendDic valueForKey:@"Count_Local_Min"] integerValue];
//        if (localMin > 0 && localMin) { // 如果有值
//            localMinCount = localMin;
//        }
//
//        NSInteger uploadMax = [[sendDic valueForKey:@"Num_Send_Max"] integerValue];
//        if (uploadMax && uploadMax > 0) {
//            uploadMaxConts = uploadMax;
//        }
//
//    }
    
//    BOOL currentWifiState = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWiFi; // 当前网络状态
////    if (onlyWifi) {
//        if (!currentWifiState) return; // 如果要求是wifi但是当前状态不是wifi就直接返回，不再执行
////    }

 // 从数据库表中查询所有信息，并将其转化 为数组
//    if (![MbsSqlManager isTableExists:@"cloudMerchant_shujucaiji"]) return; // 没有数据表则返回
//    NSString *sjcj_query = [NSString stringWithFormat:@"select pagestring from cloudMerchant_shujucaiji order by id asc limit '%ld'",(long)uploadMaxConts];
//
//    //将数据存储供下面block使用
//    [[CCBUserDefaults standardUserDefaults] setInteger:uploadMaxConts forKey:@"uploadMaxCounts"];
//
//    NSArray *sjcjArr = [SqlOperation executeSql:sjcj_query keyArray:@[@"pagestring"] isEncrypt:NO];
//    NSInteger count = [sjcjArr count];  // 数据表中取出的数据有多少条
//    if (count > localMinCount) {
//        NSString *updateStr = @"";
//        for (NSInteger i = 0; i<count; i++) { // 数据拼接
//            updateStr = [updateStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[sjcjArr objectAtIndex:i][@"pagestring"]]];
//        }
//        isSendingData = YES;
//        CloudMerchantMonitorViewModel *viewModel = [[CloudMerchantMonitorViewModel alloc] init];
//        [viewModel collectDataUpToServiceReq:[NSString stringWithFormat:@"[%@]",[updateStr substringToIndex:[updateStr length]-1]] withCallBack:^(BOOL isSuccess) {
//            if (isSuccess) {
//                CCBLogDebug(@"采集通讯成功__YSCJ01");
//                NSInteger count = [[CCBUserDefaults standardUserDefaults] integerForKey:@"uploadMaxCounts"];
//                NSString *deleteSql = [NSString stringWithFormat:@"delete from cloudMerchant_shujucaiji where id in (select id from cloudMerchant_shujucaiji order by id asc limit '%ld')",(long)count]; // 删除count条数据
//                BOOL deleteOK = [MbsSqlManager executeSqlWithTableString:deleteSql];
//                if (deleteOK) {
//                    CCBLogDebug(@"删除数据成功");
//                }
//            }
//            isSendingData = NO;
//        }];
//    }
//}
//        NSDictionary *dataDic=@{@"DATA_LIST":updateStr};
//        NSString *updateDicStr =[NSString stringWithFormat:@"{\"DATA_LIST\":[%@]}",[updateStr substringToIndex:[updateStr length]-1]];
//        if (![CloudMerchantMonitorManage Monitor].isRequest) {
//            CCBLogDebug(@"数据采集上送的数据为：%@",updateDicStr);
//            [[CloudMerchantMonitorManage Monitor] collectDataUpToServiceReq:[CloudMerchantMonitorUtil stringForZip:updateDicStr] success:^(id responseObject){
//                [CloudMerchantMonitorManage Monitor].isRequest = NO;
//                CCBLogDebug(@"==================responseObject=%@",[responseObject description]);
//                NSString * status = [[responseObject lastObject] objectForKey:@"status"];
//                if ([status isEqualToString:@"01"]) {
//                    CCBLogDebug(@"采集通讯成功__YSCJ01---MBCC0001");
//                    NSInteger count = [[CCBUserDefaults standardUserDefaults] integerForKey:@"uploadMaxCounts"];
//                    NSString *deleteSql = [NSString stringWithFormat:@"delete from cloudMerchant_shujucaiji where id in (select id from cloudMerchant_shujucaiji order by id asc limit '%ld')",(long)count]; // 删除count条数据
//                    BOOL deleteOK = [MbsSqlManager executeSqlWithTableString:deleteSql];
//                    if (deleteOK) {
//                        CCBLogDebug(@"删除数据成功");
//                    }
//                }
//            }];
//        }
//    }
    
    
//    NSInteger count = [[LoginDataManager getMonitorArray] count];
//    NSInteger pageCount = 2;
//
//    if (nil != [MbsUserDefault objectForKey:@"PAGEINTERVAL"] && ![@"" isEqualToString:[MbsUserDefault objectForKey:@"PAGEINTERVAL"]]) {
//        pageCount = [[MbsUserDefault objectForKey:@"PAGEINTERVAL"] integerValue];
//
//    }
//    if (count > pageCount) {//上送采集数据到服务端 并将上送的数据清除
//        NSString *updateStr = @"";
//        for (NSInteger i = 0; i<count; i++) {
//            updateStr = [updateStr stringByAppendingString:[NSString stringWithFormat:@"%@\n",[[LoginDataManager getMonitorArray] objectAtIndex:i]]];
//        }
//        [[MonitorManage Monitor] collectDataUpToServiceReq:[CloudMerchantMonitorUtil stringForZip:updateStr] success:^(id responseObject){
//            CCBLogDebug(@"==================responseObject=%@",[responseObject description]);
//            
//        }];
//        
//        [[LoginDataManager getMonitorArray] removeAllObjects];
//    }
//}

+ (NSString *)stringReplaceStr:(NSString *)str//去掉字符串中的空格和换行符
{
    NSString *contentStr = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return contentStr;
}

+ (NSDateComponents *)getNowYearsTime{
    NSCalendar *gregorian = [[NSCalendar alloc]
    initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
      // 获取当前日期
    NSDate* dt = [NSDate date];
      // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
       NSCalendarUnitMonth |  NSCalendarUnitDay |
       NSCalendarUnitHour |  NSCalendarUnitMinute |
       NSCalendarUnitSecond | NSCalendarUnitWeekday;
      // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
       fromDate:dt];
    return comp;
}

+ (NSString *)getRequestHttpApi{
    NSString *publicApiUrlStr = @"";
    NSDictionary *deviceDic = [[NSUserDefaults standardUserDefaults] valueForKey:@"deviceInfo"];
    if (!deviceDic) {
        NSDictionary *deviceDicTwo = [[NSUserDefaults standardUserDefaults] valueForKey:@"UseingDevice"];
        deviceDic = deviceDicTwo;
    }
    if (deviceDic) {
        NSString *netType = [NSString stringWithFormat:@"%@",[CloudMerchantMonitorUtil getUDC_NET_TYPE]];
        if ([netType isEqualToString:@"0"]) {
            //wifi
            publicApiUrlStr = [NSString stringWithFormat:@"http://%@", deviceDic[@"ip"]];
        }
        if ([netType isEqualToString:@"1"]) {
            //4G
            publicApiUrlStr = deviceDic[@"remote"];
        }
    }
    return publicApiUrlStr;
}

@end
