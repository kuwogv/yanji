//
//  CloudMerchantMonitorUtil.h
//  CCBClientV2
//
//  Created by mac on 15-5-19.
//  Copyright (c) 2015年 llbt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CloudMerchantMonitorUtil : NSObject

////会话ID
//+ (NSString *)getUDC_SESSION_ID:(NSString *)pageId;
//客户访问渠道
+ (NSString *)getUDC_CHANNEL_ID;

//会话时间戳
+ (NSString *)getUDC_SESSION_DTTM;

//入口页面ID，会话开始的页面
+ (NSString *)getUDC_ENTER_PAGE_ID;

//运营商类型
+ (NSString *)getUDC_TELECOM_OPER;

//IP地址
+ (NSString *)getUDC_IP;

//GPS经度
+ (NSString *)getUDC_LONGITUDE;

//GPS纬度
+ (NSString *)getUDC_LATITUDE;

//设备类型
+ (NSString *)getUDC_CLIENT_TYPE;

//操作系统类型
+ (NSString *)getUDC_OS_TYPE;

//操作系统版本
+ (NSString *)getUDC_OS_VERSION;

//屏幕分辨率
+ (NSString *)getUDC_SCREEN_RESOLUTION;

//尺寸大小
+ (NSString *)getUDC_SCREEN_SIZE;

//机型：手机型号
+ (NSString *)getUDC_MECHINE_TYPE;

//APP版本
+ (NSString *)getUDC_APP_VERSION;

//网络类型
+ (NSString *)getUDC_NET_TYPE;

//MAC地址
+ (NSString *)getUDC_MAC_ADDRESS;

//字典转换json格式字符串
+ (NSString *)dictionanyTransformToString:(NSDictionary *)dict;

//判空
+ (NSString *)stringEmptyHandle:(NSString *)string;

//获取页面元素 并组装采集数据串并保存
+(void)writePageData:(NSString *)pageString;

/**
 *  获取当前时间
 */
+ (NSString *)getTimeStamp;
/**
 *  获取当前时间新格式
 */
+(NSString *)getTimeStampNewFormart;
/**
 *  用于算时间差
 */
+ (NSString *)getDttm;

/**
 *  上送采集数据到服务端
 */
//+ (void)checkAndUpdateToSever;


/**
 *  会话类
 *
 *  @param
 *
 */
+ (void)getSessionInfo:(NSDictionary *)session;

/**
 *  页面浏览类(key: PAGE_VIEW):type为0进入页面，1退出页面,传入dict包含UDC_PAGE_ID(页面ID)、UDC_PAGE_NAME（页面名称）、UDC_IS_OPEN（UDC_IS_OPEN）、UDC_OTHER1（备注字段）,UDC_PAGE_STAY_TIME(停留时间)
 */
+ (void)getPageViewInfo:(NSInteger)type andDict:(NSDictionary *)dict;

/**
 *  客户识别类
 */
+ (void)getVisitorIdentification:(NSDictionary *)dict;

/**
 *  广告点击明细类
 *
 *  @param ,传入dict包含key:UDC_PAGE_ID(页面ID)、UDC_AD_ID（广告ID）、UDC_POS_ID（广告栏位ID）、UDC_AD_CURRENT_URL（广告目的URL）
 *
 */
+ (void)getAdClicks:(NSDictionary *)dict;

/**
 *  点击类
 *
 *  @param ,传入dict包含key:UDC_PAGE_ID(页面ID)、UDC_BUTTON_ID、UDC_BUTTON_NAME
 *
 */
+ (void)getClicks:(NSDictionary *)dict;

/**
 *  搜索关键字类
 *
 *  @param 传入dict包含key:UDC_PAGE_ID(页面ID)、UDC_INTERNAL_SEARCH_KEYWORD
 *
 */
+ (void)getKeyWord:(NSDictionary *)dict;

/**
 *  产品浏览类
 *
 *  @param 传入dict包含key:UDC_PAGE_ID(页面ID)、UDC_PRODUCT_ID（产品ID：如果取不到，则送产品名称。信用卡送卡种代码）、UDC_PRODUCT_NAME（产品名称）;
           type:0为产品浏览类，1产品交易类采集成功页面
 *
 */
+ (void)getProductView:(NSDictionary *)dict andType:(NSInteger)type;

/**
 *  广告曝光类
 *
 *  @param 传入dict包含key:UDC_PAGE_ID(页面ID)、UDC_AD_ID（广告ID）、UDC_POS_ID（广告栏位编码）
 *
 */
+ (void)getAdDisplay:(NSDictionary *)dict;

/**
 *  错误信息类
 *
 *  @param 传入dict包含key:UDC_PAGE_ID(页面ID)、UDC_ERR_CODE（错误代码）、UDC_ERR_MESG（错误信息）
 *
 */
+ (void)getErrMESG:(NSDictionary *)dict;

/**
 *  错误信息类
 *
 *  @param 传入dict包含key:PST_CFRM(允许采集位置信息标志，0或空：不允许，1：允许)
 *
 */
+ (void)getCFRM:(NSDictionary *)dict;

/**
 *  移动经理风险信息类
 *
 *  @param 传入dict包含key:CST_ID(新一代客户编号)、EMP_ID(员工编号)、UDC_PAGE_ID(页面ID)、RISK_DESC(风险信息描述，固定送@“截屏”)
 *
 */
+ (void)getEmpRisk:(NSDictionary *)dict;

/**
 *  延时采集类
 *
 *  @param 传入dict包含key:UDC_PAGE_ID(页面ID)、UDC_ERR_CODE（错误代码）、UDC_ERR_MESG（错误信息）
 *
 */
+ (void)getEXTRA:(NSDictionary *)dict;

/**
 *  对数据采集信息处理
 *  @param dict 公共字典
 *  @param time 本类时间戳
 *  @param type 采集信息类型
 */
+ (void)publicDictionaryForDataCollection:(NSDictionary *)dict timeStamp:(NSString *)time withType:(NSString *)type;
+ (void)publicDictionaryForDataCollection:(NSDictionary *)dict withType:(NSString *)type;

+ (NSDateComponents *)getNowYearsTime;

+ (NSString *)getRequestHttpApi;
@end
