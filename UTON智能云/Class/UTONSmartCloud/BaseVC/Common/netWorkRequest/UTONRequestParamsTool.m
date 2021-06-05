//
//  UTONRequestParamsTool.m
//  UTON智能云
//
//  Created by mac on 2021/3/4.
//

#import "UTONRequestParamsTool.h"
#import "UTONEncryptionAndUUIDFromServerParam.h"

@interface UTONRequestParamsTool ()
@property (nonatomic) UTONEncryptionAndUUIDFromServerParam *params;
@end

@implementation UTONRequestParamsTool
+ (instancetype)sharedRequestParamsTool
{
    static UTONRequestParamsTool *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.params = [[UTONEncryptionAndUUIDFromServerParam alloc]init];
    });
    
    return instance;
}

- (void)refreshRequestParams {
    //如果有后台返回的设备唯一码就不需要请求了
    if (self.params.deviceUUIDFromServer.length) {
        NSLog(@"存在设备唯一码了");
        return;
    }
//    @weakSelf(self);
//    [self.rsaEncryptionPublicAPI startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
//        @strongSelf(self);
//        if (!self) return;
//
//        NSLog(@"获取成功");
//
//        NSString *rsaPublicKey = [manager fetchServerRawDataWithReformer:nil];
//        NSLog(@"rsaPublicKey = %@",rsaPublicKey);
//        self.params.RSAEncryptionPublicKey = rsaPublicKey;
//
//        [self.deviceUUIDAPI startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
//                NSString *deviceUUID = [manager fetchAESDecryptDataWithReformer:nil];
//
//                self.params.deviceUUIDFromServer = deviceUUID;
//
//                NSLog(@"device aes decrypt:%@,rsaKey:%@,AesKey:%@",self.params.deviceUUIDFromServer,self.params.RSAEncryptionPublicKey,self.params.AESEncryptionKey);
//
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"getUUID" object:nil];
//
//            } failure:^(YRDAPIBaseManager *manager) {
//
//            }];
//
//
//    } failure:^(YRDAPIBaseManager *manager) {
//        NSLog(@"获取失败 %@",manager);
//    }];
}
#pragma mark - private Method

#pragma mark - getters and setters
- (NSString *)RSAEncryptionPublicKey {
    return self.params.RSAEncryptionPublicKey;
}
- (NSString *)AESEncryptionKey {
    return self.params.AESEncryptionKey;
}
- (NSString *)deviceUUIDFromServer {
    if (!self.params.deviceUUIDFromServer) {
        [self refreshRequestParams];
    }
    return self.params.deviceUUIDFromServer;
}

//- (YBGRSAEncryptionKeyAPIManager *)rsaEncryptionPublicAPI {
//    if (!_rsaEncryptionPublicAPI) {
//        _rsaEncryptionPublicAPI = [[YBGRSAEncryptionKeyAPIManager alloc]init];
//    }
//    return _rsaEncryptionPublicAPI;
//}
//- (YBGUUIDFromServerAPIManager *)deviceUUIDAPI {
//    if (!_deviceUUIDAPI) {
//        _deviceUUIDAPI = [[YBGUUIDFromServerAPIManager alloc]init];
//    }
//    return _deviceUUIDAPI;
//}

@end
