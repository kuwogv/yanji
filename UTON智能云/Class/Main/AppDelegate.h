//
//  AppDelegate.h
//  UTON智能云
//
//  Created by mac on 2021/3/2.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,strong) UIWindow *window;

@property (nonatomic, retain) CYLTabBarController * tabBarController;
+ (AppDelegate *)delegate;

@end

