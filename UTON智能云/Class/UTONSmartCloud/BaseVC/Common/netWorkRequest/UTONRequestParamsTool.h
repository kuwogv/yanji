//
//  UTONRequestParamsTool.h
//  UTON智能云
//
//  Created by mac on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UTONRequestParamsTool : NSObject
+ (instancetype)sharedRequestParamsTool;
@property (nonatomic, readonly) NSString *RSAEncryptionPublicKey;/**< RSA非对称加密的公钥*/
@property (nonatomic, readonly) NSString *AESEncryptionKey;/**< AES加密的密钥*/
@property (nonatomic, readonly) NSString *deviceUUIDFromServer;/**< 从后台获取得到的deviceUUID,没有这个id其他的接口无法正常工作*/

/**
 *  更新后台的RSA公钥，更新设备在后台的唯一UUID
 */
- (void)refreshRequestParams;
@end

NS_ASSUME_NONNULL_END
