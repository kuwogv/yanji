//
//  OneClickLoginViewController.h
//  UTON智能云
//
//  Created by UTON on 2021/5/27.
//

#import "UTONBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class OneClickLoginViewController;

@protocol OneClickLoginViewControllerDelegate <NSObject>

//一键登录回调
- (void)loginAppToHomePage:(OneClickLoginViewController *)loginVC;
@end

@interface OneClickLoginViewController : UTONBaseViewController
@property (nonatomic,weak)id<OneClickLoginViewControllerDelegate>loginDelegate;
@end

NS_ASSUME_NONNULL_END
