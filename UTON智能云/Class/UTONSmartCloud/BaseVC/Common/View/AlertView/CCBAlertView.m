//
//  CCBAlertView.m
//  CCBMobileBank
//
//  Created by jinhong on 16/3/30.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import "CCBAlertView.h"
#import "CCBMaskWindow.h"

@interface CCBAlertView ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, weak) id<CCBAlertViewDelegate> delegate;
@property (nonatomic, weak) CCBMaskWindow *window;
@end

@implementation CCBAlertView

+ (void)showAlertWithTitl:(NSString *)title
                  message:(NSString *)message
             buttonTitles:(NSArray *)buttonTitles
                      tag:(NSUInteger)tag
                 delegate:(id<CCBAlertViewDelegate>)delegate{
    CCBAlertView *alert = [[CCBAlertView alloc] init];
    alert.title = title;
    alert.message = message;
    alert.buttonTitles = buttonTitles;
    alert.delegate = delegate;
    alert.tag = tag;
    [alert show];
}

- (void)CCB_initMiddleText:(CGSize)textSize
              maxTextWidth:(CGFloat)maxTextWidth
                 topHeight:(CGFloat)topHeight
              bottomHeight:(CGFloat)bottomHeight
               alertHeight:(CGFloat)alertHeight
               messageFont:(UIFont *)messageFont {
    // 中间文字
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:
                                 CGRectMake(kSizeMarginToSuperView45,
                                            0,
                                            maxTextWidth,
                                            MIN(alertHeight-bottomHeight-topHeight,
                                                textSize.height))];
    scrollView.contentSize = CGSizeMake(maxTextWidth, textSize.height+1);
//    scrollView.centerY = topHeight+(alertHeight-topHeight-bottomHeight)*.5;
    
    //
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     maxTextWidth,
                                                                     textSize.height+1)];
    textLabel.numberOfLines = 0;
    textLabel.font = messageFont;
    textLabel.text = self.message;
    textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    // 小于1行，文字居中
    if (textSize.height < 25) {
        textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else {
        // 多于1行，文字左对齐，并根据宽度移动label的位置，避免文字太偏
        textLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    [scrollView addSubview:textLabel];
    [self addSubview:scrollView];
}

- (void)CCB_initButtons:(CGFloat)maxTextWidth alertHeight:(CGFloat)alertHeight {
    // 按钮平分宽度
    CGFloat buttonWidth = (maxTextWidth-(self.buttonTitles.count-1)*kSizeMarginWithItemInSameLine20)/self.buttonTitles.count;
    
    // 底部按钮
    for (int i = 0; i < self.buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(buttonWidth+kSizeMarginWithItemInSameLine20)+kSizeMarginToSuperView45,
                                  alertHeight-kSizeMarginWithItemInSameLine20-kSizeButtonHeight30,
                                  buttonWidth,
                                  kSizeButtonHeight30);
        button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [button setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)CCB_show {

//    [self.window.rootViewController.view addSubview:self];
    [self.window addSubview:self];
    self.center = self.superview.center;

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(.3, .3, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(.75, .75, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.15, 1.15, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    animation.keyTimes = @[@0.05, @.4, @.65, @.85 ,@1];
    animation.duration = .5;
    [self.layer addAnimation:animation forKey:@"show"];

}

- (void)CCB_hide {
    NSLog(@"CCB_hide");
//    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
//    self.window.hidden = YES;
//    [self setWindow:nil];
    [self.window dismiss];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)show {
    UIFont *messageFont = kLabelSize17;
    CGSize mainScreenSize = [[UIScreen mainScreen] bounds].size;
    
    // 弹出框顶部蓝色条的高度
    CGFloat topHeight = kSizeButtonHeight30*1.5;
    
    // 弹出框底部按钮部分的高度
    CGFloat bottomHeight = kSizeButtonHeight30+kSizeMarginWithItemInSameLine20*2;

    // 弹出框的最大高度
    CGFloat maxAlertHeight = mainScreenSize.height - kSizeMarginToSuperView45*2;
    // 弹出框最小高度
    CGFloat minAlertHeight = 150;

    // 弹出框的最大宽度
    CGFloat alertWidth = mainScreenSize.width - kSizeMarginToSuperView45*2;
    // 弹出框的文字的最大宽度
    CGFloat maxTextWidth = alertWidth - kSizeMarginToSuperView45*2;

    // 计算message的绘制大小
    CGSize textSize = [NSString sizeForString:self.message
                                         font:messageFont
                            constrainedToSize:CGSizeMake(maxTextWidth, CGFLOAT_MAX)
                                lineBreakMode:NSLineBreakByCharWrapping];
    // 弹出框的高度
    CGFloat alertHeight = topHeight+bottomHeight+textSize.height+1;
    alertHeight = MIN(alertHeight, maxAlertHeight);
    alertHeight = MAX(alertHeight, minAlertHeight);
    
    
    // 设置背景色、圆角和大小
    self.backgroundColor = kColorWhiteColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.frame = CGRectMake(0, 0, alertWidth, alertHeight);

    // 顶部标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertWidth, topHeight)];
    titleLabel.backgroundColor = kColorWhiteColor;
    titleLabel.textColor = kColorWhiteColor;
    titleLabel.font = kLabelSize20;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    [self addSubview:titleLabel];

    // 创建中间文字
    [self CCB_initMiddleText:textSize
                maxTextWidth:maxTextWidth
                   topHeight:topHeight
                bottomHeight:bottomHeight
                 alertHeight:alertHeight
                 messageFont:messageFont];

    // 创建底部按钮
    [self CCB_initButtons:maxTextWidth alertHeight:alertHeight];

//    [self.window makeKeyAndVisible];
    [self.window show];

    // 动画弹出
    [self CCB_show];
}

#pragma - mark UI Event Handler
- (void)clickButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(alertViewDidClickedButtonAtIndex:title:message:buttonTitles:tag:)]){
        [self.delegate alertViewDidClickedButtonAtIndex:sender.tag
                                                  title:self.title
                                                message:self.message
                                           buttonTitles:self.buttonTitles];
    }
    [self CCB_hide];
}

#pragma - mark Property
- (UIWindow *)window {
    if (!_window) {
//        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        // 避免遮挡住系统的alert?
//        _window.windowLevel = UIWindowLevelAlert - 0.1;
//        
//        _window.rootViewController = [[CCBViewController alloc] init];
//        _window.rootViewController.view.backgroundColor = RGBACOLOR(0, 0, 0, .3);
//        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//        if (keyWindow.windowLevel > _window.windowLevel) {
//            _window.windowLevel = keyWindow.windowLevel + 0.1;
//        }
        _window = [CCBMaskWindow shareMaskWindow];
    }
    
    return _window;
}

@end
