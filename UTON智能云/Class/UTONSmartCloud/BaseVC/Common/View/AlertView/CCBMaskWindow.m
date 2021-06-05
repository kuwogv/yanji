//
//  CCBMaskWindow.m
//  CCBMobileBank
//
//  Created by lukeyuan on 16/7/4.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import "CCBMaskWindow.h"

#define kMaskColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4] //遮罩颜色，目前显示为透明

static CCBMaskWindow *m_window;

@interface CCBMaskWindow()

@property (nonatomic, assign, readwrite) NSInteger count;

@end

@implementation CCBMaskWindow

+ (instancetype)shareMaskWindow {
    if (!m_window) {
        m_window = [[CCBMaskWindow alloc] init];
        m_window.frame = [[UIScreen mainScreen] bounds];
        m_window.windowLevel = UIWindowLevelAlert - 0.1;
        m_window.rootViewController = [[UIViewController alloc] init];
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        if (keyWindow.windowLevel > m_window.windowLevel) {
            m_window.windowLevel = UIWindowLevelAlert + 100;
        }
        m_window.backgroundColor = kMaskColor;
        
        m_window.opaque = NO;
        
        m_window.count = 0;
        
        //隐藏掉最前方的view，使之后的view直接加入window时就能有响应
        m_window.rootViewController.view.hidden = YES;
        
        //添加点击事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MaskWindowClickActiondo)];
        [m_window addGestureRecognizer:tapGesture];
    }
    return m_window;
}

- (void)show {
    [self showImmediately];
}

- (void)showImmediately {
    if (!m_window.count) {
        [m_window makeKeyAndVisible];
    }
    m_window.count++;
}

//暂不外放
/**
 *  延迟展现window
 *
 *  @param delay 延迟时间
 */
- (void)showAfterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(showImmediately) withObject:nil afterDelay:delay];
}

- (void)dismiss {
    [self performSelector:@selector(dismissImmediately) withObject:nil afterDelay:0.01f];
}

- (void)dismissImmediately {
    m_window.count--;
    if (!m_window.count) {
        m_window.hidden = YES;
        m_window = nil;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
    }
}

- (void)dismissAfterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(dismissImmediately) withObject:nil afterDelay:delay];
}

//点击相应
+(void)MaskWindowClickActiondo{
    if(m_window.onClick){
        m_window.onClick(TRUE);
    }
}

@end
