//
//  CCBAlertView.h
//  CCBMobileBank
//
//  Created by jinhong on 16/3/30.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCBAlertView;

@protocol CCBAlertViewDelegate <NSObject>
- (void)alertViewDidClickedButtonAtIndex:(NSInteger)index
                                   title:(NSString *)title
                                 message:(NSString *)message
                            buttonTitles:(NSArray *)buttonTitles;

@end

/**
 *  弹出窗基类
 */
@interface CCBAlertView : UIView

/**
 *  弹出提示框
 *
 *  @param title        提示框标题
 *  @param message      提示信息
 *  @param buttonTitles 按钮文本数组
 *  @param tag          提示框标示
 *  @param delegate     委托
 */
+ (void)showAlertWithTitl:(NSString *)title
                  message:(NSString *)message
             buttonTitles:(NSArray *)buttonTitles
                      tag:(NSUInteger)tag
                 delegate:(id<CCBAlertViewDelegate>)delegate;


@end
