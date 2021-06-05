//
//  UTONPlusButton.h
//  UTON智能云
//
//  Created by mac on 2021/3/10.
//

#import "CYLPlusButton.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^UTONPlusButtonCallBack)(NSInteger btnTag);



@interface UTONPlusButton : CYLPlusButton<CYLPlusButtonSubclassing>



@end

NS_ASSUME_NONNULL_END
