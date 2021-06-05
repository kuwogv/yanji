//
//  UTONBaseHttpRequest.h
//  UTON智能云
//
//  Created by mac on 2021/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UTONBaseHttpRequestDelegate <NSObject>

- (void)uploadFileProcess:(float)process;

@end

@interface UTONBaseHttpRequest : NSObject

+ (UTONBaseHttpRequest *)sharedInstance;

@property (nonatomic,assign) id<UTONBaseHttpRequestDelegate>delegate;

- (void)UTONForRequestWithUrl:(NSString *)urlStr HttpRequestBody:(NSString *)bodyStr HttpHeader:(NSDictionary *_Nullable)headerDic completionHandler:(void(^)(NSDictionary * _Nullable successDic,BOOL isSuccess,NSString *errorMsg)) callBack;

/* 文件上传**/
- (void)utonAddLoadFileWithFileArg:(NSString *)filePath completionHandler:(void(^)(NSDictionary * _Nullable successDic,BOOL isSuccess,NSString *errorMsg)) callBack;

//表单方式请求接口
- (void)UTONForRequestWithBiaodanUrl:(NSString *)urlStr HttpRequestBody:(NSString *)bodyStr filePath:(NSString *)filePath HttpHeader:(NSDictionary *_Nullable)headerDic completionHandler:(void (^)(NSDictionary * _Nullable, BOOL, NSString * _Nonnull))callBack;
@end

NS_ASSUME_NONNULL_END
