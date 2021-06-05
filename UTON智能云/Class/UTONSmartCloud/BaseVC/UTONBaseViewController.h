//
//  UTONBaseViewController.h
//  UTON智能云
//
//  Created by mac on 2021/3/2.
//

#import <UIKit/UIKit.h>
typedef enum{
    BaseAlertViewDefault = 0,
    BaseAlertViewBig
}BaseAlertViewType;
NS_ASSUME_NONNULL_BEGIN
/*
 
 基类控制器
 **/
@interface UTONBaseViewController : UIViewController
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UILabel *titleLabel;
/**
 *  显示提示框
 *
 *  @param title 提示框标题
 *  @param message 提示语
 *  @param arr  按钮文本数组
 *  @param type 提示框样式类型
 */
- (void)showWithTitle:(nullable NSString *)title
              message:(nullable NSString *)message
        btnTitleArray:(nullable NSArray *)array
            alertType:(BaseAlertViewType)type;

/**
 *  点击弹出框的按钮后会调用本方法
 *
 *  @param index        点击的按钮的index
 *  @param title        弹出框标题
 *  @param message      弹出框的消息
 *  @param buttonTitles 弹出框的按钮文本数组
 */
- (void)alertViewDidClickedButtonAtIndex:(NSInteger)index
                                   title:(nullable NSString *)title
                                 message:(nullable NSString *)message
                            buttonTitles:(nullable NSArray *)buttonTitles;

/**
 在当前页面中间显示loading图标
 lockScreen 是否锁屏
 **/
- (void)showProgressHud:(BOOL)lockScreen;

- (void)hideProgressHud;

/* 显示只有提示语的提示框**/
- (void)showMessageView:(NSString *)message;

- (void)navGoBack;

/**
 *  显示toast文本信息，显示2秒后消失
 *
 *  @param message 文字信息
 */
- (void)makeToast:(nonnull NSString *)message;

@end

NS_ASSUME_NONNULL_END
