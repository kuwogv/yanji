//
//  UIView+HideKeyboard.m
//  YBGMobileCampus
//
//  Created by yurongde on 16/5/30.
//  Copyright © 2016年 com.ly. All rights reserved.
//

#import "UIView+HideKeyboard.h"

@implementation UIView (HideKeyboard)
/**
 *  全局隐藏键盘
 */
- (void)hideKeyBoard
{
    for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
        for (UIView* view in window.subviews)
        {
            [self dismissAllKeyBoardInView:view];
        }
    }
}

-(BOOL) dismissAllKeyBoardInView:(UIView *)view
{
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoardInView:subView])
        {
            return YES;
        }
    }
    return NO;
}
@end
