//
//  AppDelegate.m
//  UTON智能云
//
//  Created by mac on 2021/3/2.
//

#import "AppDelegate.h"
#import "UTON_VC_Launch.h"
#import "OneClickLoginViewController.h"
#import "CYLMainRootViewController.h"
@interface AppDelegate ()<UTONLaunchViewDelegate,OneClickLoginViewControllerDelegate>
@property (nonatomic,strong) CYLMainRootViewController *rootViewController;
@end

@implementation AppDelegate

+ (AppDelegate *)delegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [NSThread sleepForTimeInterval:0.3];//设置启动页面时间
    //第一次登录
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    BOOL isLaunchApp = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLaunchApp"];
//    if (isLaunchApp) {
        self.rootViewController = [[CYLMainRootViewController alloc] init];
//        [self.window setRootViewController:rootViewController];
        [self setUpNavigationBarAppearance];
//        [self.window makeKeyAndVisible];
//    }else{
        UTON_VC_Launch *launchVC = [[UTON_VC_Launch alloc]init];
        launchVC.delegate = self;
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:launchVC];
//        nav.navigationBarHidden = YES;
        self.window.rootViewController = launchVC;
        [self.window makeKeyAndVisible];
//    }
        
    return YES;
}

/**
 完成启动
 **/
- (void)launchViewDidFinishLaunch:(UTON_VC_Launch *)launchView{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLaunchApp"];
//    OneClickLoginViewController *rootViewController = [[OneClickLoginViewController alloc]init];
//    CYLMainRootViewController *rootViewController = [[CYLMainRootViewController alloc] init];
//    rootViewController.loginDelegate = self;
    
    [self.window setRootViewController:self.rootViewController];
//    [self setUpNavigationBarAppearance];
    [self.window makeKeyAndVisible];
}

- (void)loginAppToHomePage:(OneClickLoginViewController *)loginVC{
        CYLMainRootViewController *rootViewController = [[CYLMainRootViewController alloc] init];
        [self.window setRootViewController:rootViewController];
        [self setUpNavigationBarAppearance];
        [self.window makeKeyAndVisible];
}

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIColor *backgroundColor = UIColorFromRGB(0xFF6D00);//[UIColor cyl_systemBackgroundColor];
    NSDictionary *textAttributes = nil;
    UIColor *labelColor =   UIColorFromRGB(0xFF6D00);

    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : labelColor,
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : labelColor,
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navigationBarAppearance setBarTintColor:backgroundColor];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}


@end
