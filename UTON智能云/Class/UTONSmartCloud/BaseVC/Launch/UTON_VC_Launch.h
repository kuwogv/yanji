//
//  UTON_VC_Launch.h
//  UTON智能云
//
//  Created by mac on 2021/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class UTON_VC_Launch;

/***
 启动页回调
 */
@protocol UTONLaunchViewDelegate <NSObject>
/**
 
 完成启动
 *@param launchView 启动页VC
 */
- (void)launchViewDidFinishLaunch:(UTON_VC_Launch *)launchView;

@end

@interface UTON_VC_Launch : UTONBaseViewController
@property (nonatomic, weak) id<UTONLaunchViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
