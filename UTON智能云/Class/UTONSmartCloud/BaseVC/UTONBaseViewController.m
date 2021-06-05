//
//  UTONBaseViewController.m
//  UTON智能云
//
//  Created by mac on 2021/3/2.
//

#import "UTONBaseViewController.h"
#import <objc/runtime.h>

static const NSString * CSToastTimerKey         = @"CSToastTimerKey";
static const NSString * CSToastActivityViewKey  = @"CSToastActivityViewKey";
static const NSString * CSToastTapCallbackKey   = @"CSToastTapCallbackKey";

@interface UTONBaseViewController ()<CCBAlertViewDelegate>
@property (nonatomic,strong) UIView *backGView;
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation UTONBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTintColor:kColorBlackColor];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationBack"] style:UIBarButtonItemStyleDone target:self action:@selector(navGoBack)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    [self.navigationItem.leftBarButtonItem setTintColor:kColorBlackColor];
    
    UIColor *color = kColorWhiteColor;//;
    UIImage *image = [UIImage imageWithColor:color size:CGSizeMake(2, 2)];
    [self.navigationController.navigationBar setBackgroundImage:image
                             forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setTintColor:kColorBlackColor];
    self.view.backgroundColor = kColorWhiteColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:kColorBlackColor,NSFontAttributeName:kLabelSize20}];
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = kColorBlackColor;
    self.titleLabel.font = kLabelSize15;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.titleView);
        make.width.mas_equalTo(self.titleView);
    }];
    self.navigationItem.titleView = self.titleView;
    
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {
             [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
        }else{
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    }
    self.view.backgroundColor = kColorWhiteColor;
}

- (void)navGoBack{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  显示提示框
 *
 *  @param title 提示框标题
 *  @param message 提示语
 *  @param array  按钮文本数组
 *  @param type 提示框样式类型
 */
- (void)showWithTitle:(nullable NSString *)title message:(nullable NSString *)message btnTitleArray:(nullable NSArray *)array alertType:(BaseAlertViewType)type {
    BaseAlertViewType alertType = (type == BaseAlertViewBig ? type : BaseAlertViewDefault);

    __block typeof(&*self)weakSelf = self;
    CCBBaseAlertView *commonAlert = [[CCBBaseAlertView alloc]initWithTitle:title message:message btnTitleArray:array alertType:alertType];
    commonAlert.callbackBlock = ^(NSInteger buttonIndex) {
        [weakSelf alertViewDidClickedButtonAtIndex:buttonIndex title:title message:message buttonTitles:array];
//        [weakSelf alertViewDidClickedButtonAtIndex:buttonIndex title:title message:message buttonTitles:array];
    };
    [commonAlert show];
}

#pragma - mark Delegate CCBAlertView
- (void)alertViewDidClickedButtonAtIndex:(NSInteger)index
                                   title:(NSString *)title
                                 message:(NSString *)message
                            buttonTitles:(NSArray *)buttonTitles {
    // ...
}

- (void)showProgressHud:(BOOL)lockScreen{
    [self showBackGViewWithSuperView:self.view];
    [self startProgreddHudTimer];
}

- (void)startProgreddHudTimer{
    self.hud = nil;
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.center = self.view.center;
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.margin = 10.0f;
    self.hud.animationType = MBProgressHUDAnimationZoom;
    self.hud.removeFromSuperViewOnHide = YES;
    UIImageView *loadingImage = [[UIImageView alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"utonloading" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_imageWithGIFData:data];
    loadingImage.image = image;
    self.hud.customView = loadingImage;
    self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.hud.bezelView.color = kColorClearColor;//UIColorFromRGB(0xEEEEEE);
    self.hud.bezelView.alpha = 0;
    self.hud.frame = CGRectMake(mScreenWidth/2-70, mScreenHeight/2-90, 140, 140);
    [self.hud showAnimated:YES];
}

- (void)hideProgressHud{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideBackGView];
        [self.hud hideAnimated:YES];
    });
    
}

- (UIView *)backGView{
    if (!_backGView) {
        _backGView = [[UIView alloc]init];
        [_backGView setBackgroundColor:kColorClearColor];
    }
    return _backGView;
}

- (void)showBackGViewWithSuperView:(UIView*)superView{
    [superView addSubview:self.backGView];
    self.backGView.frame = CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height);
    [superView bringSubviewToFront:self.backGView];
}

- (void)hideBackGView{
    if (_backGView) {
        [_backGView removeFromSuperview];
        _backGView = nil;
    }
    
}

- (void)showMessageView:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        CCBBaseAlertView *areatView = [[CCBBaseAlertView alloc]initWithTitle:@"" message:message btnTitleArray:@[@"确定"] alertType:BaseAlertViewDefault];
        [areatView show];
    });
    
}

- (void)makeToast:(nonnull NSString *)message {
    UIView *toast = [self viewForMessage:message];
    [self showViewToast:toast duration:2.0 position:@"center" tapCallback:nil];
}

- (void)showViewToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
      tapCallback:(void(^)(void))tapCallback
{
    toast.center = [self viewCenterPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    
    
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    
    
    [self.view addSubview:toast];
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &CSToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         objc_setAssociatedObject (toast, &CSToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}

- (CGPoint)viewCenterPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            return CGPointMake(self.view.bounds.size.width/2, (toast.frame.size.height / 2) + 10);
        } else if([point caseInsensitiveCompare:@"center"] == NSOrderedSame) {
            return CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    // default to bottom
    return CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height - (toast.frame.size.height / 2)) - 10);
}

- (void)hideToast:(UIView *)toast {
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}


- (void)toastTimerDidFinish:(NSTimer *)timer {
    [self hideToast:(UIView *)timer.userInfo];
}

- (void)handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &CSToastTimerKey);
    [timer invalidate];
    
    void (^callback)(void) = objc_getAssociatedObject(self, &CSToastTapCallbackKey);
    if (callback) {
        callback();
    }
    [self hideToast:recognizer.view];
}

- (UIView *)viewForMessage:(NSString *)message{
    // sanity
    if(message == nil) return nil;

    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = 10;
    
//    if (YES) {
    wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
    wrapperView.layer.shadowOpacity = 0.8;
    wrapperView.layer.shadowRadius = 6.0;
    wrapperView.layer.shadowOffset = CGSizeMake(4.0, 4.0);
//    }

    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    
    
    // the imageView frame values will be used to size & position the other views
    
    
    // titleLabel frame values
//    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont systemFontOfSize:15];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.view.bounds.size.width * 0.8) - 0, self.view.bounds.size.height * 0.8);
        CGSize expectedSizeMessage = [self sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = 10;
        messageTop = 10;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }

    CGFloat longerWidth = MAX(0, messageWidth);
    CGFloat longerLeft = MAX(0, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((0 + (10 * 2)), (longerLeft + longerWidth + 10));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + 10), (0 + (10 * 2)));
                         
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    
        
    return wrapperView;
}

- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
