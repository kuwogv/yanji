//
//  NSString+AES.h
//  UTON智能云
//
//  Created by mac on 2021/3/5.
//


#import <Foundation/Foundation.h>
 
@interface NSString (AES)
/**< 加密方法 */
- (NSString*)aci_encryptWithAES;
 
/**< 解密方法 */
- (NSString*)aci_decryptWithAES;

@end
