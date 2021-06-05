//
//  CCBBaseAlertView.h
//  Search_CustomAlert
//
//  Created by yan.panpan on 13-9-24.
//  Copyright (c) 2013年 llbt. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef enum{
//    BaseAlertViewDefault = 0,
//    BaseAlertViewBig
//}BaseAlertViewType;

@interface CCBBaseAlertView : UIView

+ (void)showErrorMessage:(NSString*)message;

+ (void)showSuccMessage:(NSString*)message;

- (instancetype)initWithTitle:(NSString*)titl message:(NSString*)mess btnTitleArray:(NSArray*)arr alertType:(BaseAlertViewType)type;

// 提示框种类
@property (nonatomic,assign) BaseAlertViewType alertType;
// 标题
@property (nonatomic,copy) NSString *title;
@property(nonatomic,strong)UIFont *titleFont;
// 信息
@property (nonatomic,copy) NSString *message;
@property(nonatomic,strong)UIFont *messageFont;
// 与信息相关的错误码
@property (nonatomic,copy) NSString *messageCode;
// 按键文本数组
@property (nonatomic,copy) NSArray *buttonTitleArr;
@property(nonatomic,strong)UIFont *buttonTitleFont;

/**
 按钮点击回调，当前只支持最多两个按键。
 */
@property (nonatomic, copy) void (^callbackBlock)(NSInteger buttonIndex);

//弹出提示框
- (void)show;

//外部改变标题和内容的字体
- (void)setTitleFont:(UIFont *)titleSize messageFont:(UIFont *)messageSize DEPRECATED_MSG_ATTRIBUTE("此方法废弃，请使用属性titleFont, messageFont, buttonTitleFont");
@end
