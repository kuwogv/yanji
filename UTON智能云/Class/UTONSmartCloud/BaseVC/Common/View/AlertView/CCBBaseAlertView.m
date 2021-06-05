//
//  CCBBaseAlertView.m
//  Search_CustomAlert
//
//  Created by yan.panpan on 13-9-24.
//  Copyright (c) 2013年 llbt. All rights reserved.
//

#import "CCBBaseAlertView.h"
//#import <QuartzCore/QuartzCore.h>
#import "CCBMaskWindow.h"

#define kButtonHeight WS(40)
#define kMarginFifteen WS(15)
#define kAlertSmallHeight WS((150+80+70)/2)
#define kAlertBigHeight WS((650+80+70)/2)


@interface CCBBaseAlertView ()

@property (nonatomic,weak) CCBMaskWindow *m_window;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UITextView *messageTextView;
@property (nonatomic,copy) NSArray *buttonsArray;
@property (nonatomic,copy) NSArray *devidinglinesArray;
@end

@implementation CCBBaseAlertView

+ (void)showErrorMessage:(NSString*)message {
    [self showSuccMessage:message];
}

+ (void)showSuccMessage:(NSString*)message {
    CCBBaseAlertView *errorAlert = [[CCBBaseAlertView alloc]initWithTitle:@"" message:message btnTitleArray:@[@"确定"] alertType:BaseAlertViewDefault];
    [errorAlert show];
}

- (instancetype)initWithTitle:(NSString*)titl message:(NSString*)mess btnTitleArray:(NSArray*)arr alertType:(BaseAlertViewType)type {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.alertType = type;
        self.title = titl;
        self.message = mess;
        self.messageCode = nil;
        self.buttonTitleArr = arr;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorClearColor;
        _m_window = [CCBMaskWindow shareMaskWindow];
    }
    return self;
}

- (void)show {
    [_m_window addSubview:self];
    [_m_window show];
    
    //弹出动画
    self.alpha = 0.;
    
    self.transform = CGAffineTransformScale(self.transform, 0.2, 0.2);
    [UIView animateWithDuration:0.17 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0f;
    } completion:^(BOOL finished){
        //
    }];
}

- (void)setTitleFont:(UIFont *)titleSize messageFont:(UIFont *)messageSizes {
    _titleLabel.font = titleSize;
    _messageTextView.font = messageSizes;
}

- (void)buttonClick:(UIButton *)btn {
    if (_callbackBlock) {
        switch (btn.tag) {
            case 1:
                _callbackBlock(1);
                break;
            case 2:
                _callbackBlock(2);
                break;
            case 3:
                _callbackBlock(3);
                break;
            default:
                break;
        }
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [_m_window dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CCBAlertViewDidDismiss" object:nil];
    }];
}

#pragma mark Cocoa Origin Methods
- (void)drawRect:(CGRect)rect {
    self.layer.cornerRadius = 6;
    CGFloat max_X = rect.size.width;
    CGFloat max_Y = rect.size.height;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, WS(20), 0);
    CGContextAddArcToPoint(ctx, max_X, 0, max_X, max_Y - WS(20), WS(6));
    CGContextAddArcToPoint(ctx, max_X, max_Y, WS(20), max_Y, WS(6));
    CGContextAddArcToPoint(ctx, 0, max_Y, 0, WS(20), WS(6));
    CGContextAddArcToPoint(ctx, 0, 0, WS(20), 0, WS(6));
    
    CGContextSetFillColorWithColor(ctx, kColorWhiteColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.alertType == BaseAlertViewBig) {
        [self alertTypeBigLayout];
    } else {
        [self alertTypeDefaultLayout];
    }
}

- (void)alertTypeBigLayout {
    CGSize alertViewSize = CGSizeMake([self alertViewWidth], kAlertBigHeight);
    
    // 设定标题的frame
    [self locationTitleLabelPostionAndFrame:alertViewSize.width];
    
    // 设定中间信息的frame
    CGFloat x = kSizeMarginToSuperView45;
    CGFloat y = [self calcMessageTextViewOriginY];
    CGFloat width = alertViewSize.width -2*kSizeMarginToSuperView45;
    CGFloat height = alertViewSize.height -y -WS(20) -kButtonHeight;
    self.messageTextView.frame = CGRectMake(x, y, width, height);
    
    // 设定alert自身的大小和位置.
    self.frame = CGRectMake(0, 0, alertViewSize.width, alertViewSize.height);
    self.center = _m_window.center;
    
    // 设定按键及其分割线的frame
    [self locationButtonsAndDivideLinesCoordinate:alertViewSize];
}

- (void)alertTypeDefaultLayout {
    // 设定view自身的frame
    CGFloat alertViewSizeHeight = ([self titleLabelIsVisiable] ? kAlertSmallHeight : kAlertSmallHeight-WS(70/2));
    CGSize alertViewSize = CGSizeMake([self alertViewWidth], alertViewSizeHeight);
    
    // 设定标题的frame
    [self locationTitleLabelPostionAndFrame:alertViewSize.width];
    
    // 设定中间信息的frame
    /*
     1. x: 固定为 kSizeMarginToSuperView45,
     2. y: 有title, 则与title间隔kMarginFifteen; 无title, 则与边距间隔kMarginFifteen.
     3. width: 固定为 alertViewSize.width -2*kSizeMarginToSuperView45
     4. height: 整体高度超过kAlertBigHeight, 则height固定, 内容默认显示，且可滚动.
     整体高度低于kAlertSmallHeight, 则height固定, 内容垂直居中显示，不可滚动.
     介于以上两者之间，则height固定，内容默认显示，且可滚动
     */
    CGFloat x = kSizeMarginToSuperView45;
    CGFloat y = [self calcMessageTextViewOriginY];
    CGFloat width = alertViewSize.width -2*kSizeMarginToSuperView45;
    if ([self messageViewTextOnlyOneLine:[self widthForCalcMessageTextViewStringHeight:width] forMessage:self.message]) {
        self.frame = CGRectMake(0, 0, alertViewSize.width, alertViewSize.height);
        self.center = _m_window.center;
        
        // 设定中间信息的frame
        CGFloat height = self.bounds.size.height -y -WS(20) -kButtonHeight;
        self.messageTextView.frame = CGRectMake(x, y, width, height);
        
        if ([self titleLabelIsVisiable]) {
            CGFloat textHeight = [self calcStringHeight:[self widthForCalcMessageTextViewStringHeight:width] forAttrsString:self.messageTextView.attributedText];
            CGFloat height = self.messageTextView.bounds.size.height;
            CGFloat padding = (height - textHeight) /2.0;
            self.messageTextView.contentInset = UIEdgeInsetsMake(padding, 0, padding, 0);
        } else {
            CGFloat textHeight = [self calcStringHeight:[self widthForCalcMessageTextViewStringHeight:width] forAttrsString:self.messageTextView.attributedText];
            CGPoint center = CGPointMake(self.messageTextView.center.x, (CGRectGetMaxY(self.messageTextView.frame)+WS(20))/2.0f);
            if (self.messageCode.length == 0) {//如果是没有错误码的提示框，文字居中
                center = CGPointMake(self.messageTextView.center.x, (CGRectGetMaxY(self.messageTextView.frame)+WS(20)+WS(15))/2.0f);
            }
            self.messageTextView.bounds = CGRectMake(0, 0, self.messageTextView.frame.size.width, textHeight);
            self.messageTextView.center = CGPointMake(center.x, center.y);
        }
        
        if (self.messageCode.length == 0) {
            self.messageTextView.textAlignment = NSTextAlignmentCenter;
        } else {
            self.messageTextView.textAlignment = NSTextAlignmentLeft;
        }
    } else {
        CGFloat height = [self calcMessageTextViewSizeHeight:[self widthForCalcMessageTextViewStringHeight:width] withViewOriginY:y];
        self.messageTextView.frame = CGRectMake(x, y, width, height);
        self.messageTextView.textAlignment = NSTextAlignmentLeft;
        
        // 设定alert自身的大小和位置.
        CGFloat bHeight = CGRectGetMaxY(self.messageTextView.frame) +WS(20) +kButtonHeight;
        if (bHeight > kAlertBigHeight) {
            bHeight = kAlertBigHeight;
        } else {
            // ...
        }
        self.frame = CGRectMake(0, 0, alertViewSize.width, ceil(bHeight));
        self.center = _m_window.center;
    }
    
    // 设定按键及其分割线的frame
    [self locationButtonsAndDivideLinesCoordinate:self.frame.size];
}

- (CGFloat)widthForCalcMessageTextViewStringHeight:(CGFloat)width {
    return (width-2*self.messageTextView.textContainer.lineFragmentPadding);
}

- (CGFloat)alertViewWidth {
    return _m_window.bounds.size.width - 2*kSizeMarginToSuperView45;
}

- (BOOL)titleLabelIsVisiable {
    return (self.title.length > 0);
}

- (void)locationTitleLabelPostionAndFrame:(CGFloat)width {
    if ([self titleLabelIsVisiable]) {
        self.titleLabel.frame = CGRectMake(0, WS(35/2), width, WS(18));
        self.titleLabel.hidden = false;
    } else {
        self.titleLabel.frame = CGRectMake(0, WS(35/2), 0, 0);
        self.titleLabel.hidden = true;
    }
}

- (CGFloat)calcMessageTextViewOriginY {
    if ([self titleLabelIsVisiable]) {
        return CGRectGetMaxY(self.titleLabel.frame)+kMarginFifteen;
    } else {
        return CGRectGetMinY(self.titleLabel.frame);
    }
}

- (CGFloat)calcMessageTextViewSizeHeight:(CGFloat)width withViewOriginY:(CGFloat)originY {
    CGFloat textHeight = [self calcStringHeight:width forAttrsString:self.messageTextView.attributedText];
    CGFloat totalHeight = originY +textHeight +WS(20) +kButtonHeight;
    if (totalHeight > kAlertBigHeight) {
        CGFloat height = kAlertBigHeight -originY -WS(20) -kButtonHeight;
        return ceil(height);
    } else {
        return ceil(textHeight);
    }
}

- (CGFloat)calcStringHeight:(CGFloat)width forAttrsString:(NSAttributedString *)attrsString {
    if (attrsString == nil) {
        return 0.0;
    }
    
    NSStringDrawingOptions options = (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading);
    CGRect rect = [attrsString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options context:NULL];
    return rect.size.height;
}

- (BOOL)messageViewTextOnlyOneLine:(CGFloat)viewWidth forMessage:(NSString *)aMessage {
    if (aMessage == nil) {
        return true;
    }
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:aMessage attributes:[self messageStringAttributes]];
    CGFloat messageHeight = [self calcStringHeight:viewWidth forAttrsString:attrString];
    NSAttributedString *baseString = [[NSAttributedString alloc] initWithString:@"基准" attributes:[self messageStringAttributes]];
    CGFloat baseHeight = [self calcStringHeight:viewWidth forAttrsString:baseString];
    return (messageHeight <= baseHeight);
}

- (void)locationButtonsAndDivideLinesCoordinate:(CGSize)viewSize {
    NSInteger count = self.buttonsArray.count;
    if (count == 1) {
        UIButton *button = self.buttonsArray.firstObject;
        button.frame = CGRectMake(0, viewSize.height -kButtonHeight, viewSize.width, kButtonHeight);
        
        CGFloat horizonallineHeight = [self devideLineWidth];
        UIImageView *horizonalline = self.devidinglinesArray.firstObject;
        horizonalline.frame = CGRectMake(0, CGRectGetMinY(button.frame)-horizonallineHeight, viewSize.width, horizonallineHeight);
    } else if (count >= 2) {
        UIButton *button1 = self.buttonsArray.firstObject;
        button1.frame = CGRectMake(0, viewSize.height -kButtonHeight, viewSize.width/2.0, kButtonHeight);
        
        UIButton *button2 = [self.buttonsArray objectAtIndex:1];
        button2.frame = CGRectMake(viewSize.width/2.0, viewSize.height -kButtonHeight, viewSize.width/2.0, kButtonHeight);
        
        CGFloat horizonallineHeight = [self devideLineWidth];
        UIImageView *horizonalline = self.devidinglinesArray.firstObject;
        horizonalline.frame = CGRectMake(0, CGRectGetMinY(button1.frame)-horizonallineHeight, viewSize.width, horizonallineHeight);
        
        CGFloat verticallineWidth = [self devideLineWidth];
        UIImageView *verticalline = self.devidinglinesArray.lastObject;
        verticalline.frame = CGRectMake(CGRectGetMaxX(button1.frame), CGRectGetMinY(button1.frame), verticallineWidth, kButtonHeight);
    } else {
        // ...
    }
}

- (CGFloat)devideLineWidth {
    return 0.5;
}

#pragma mark - property
- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = [title copy];
        self.titleLabel.text = _title;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (titleFont == nil) {
        return ;
    }
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setMessage:(NSString *)message {
    if (_message != message) {
        _message = [message copy];
        self.messageTextView.attributedText = [self createMessageViewAttrsString:_message withMessageCode:self.messageCode];
    }
}

- (void)setMessageFont:(UIFont *)messageFont {
    if (messageFont == nil) {
        return ;
    }
    _messageFont = messageFont;
    self.messageTextView.font = messageFont;
}

- (void)setMessageCode:(NSString *)messageCode {
    if (_messageCode != messageCode) {
        _messageCode = [messageCode copy];
        self.messageTextView.attributedText = [self createMessageViewAttrsString:self.message withMessageCode:_messageCode];
    }
}

- (NSAttributedString *)createMessageViewAttrsString:(NSString *)aMessage withMessageCode:(NSString *)aMessageCode {
    NSString *message = (aMessage?aMessage:@"");
    
    NSString *allMessage = @"";
    
    if (aMessageCode == nil) {
        allMessage = [NSString stringWithFormat:@"%@",message];
        NSMutableAttributedString *mAttrsString = [[NSMutableAttributedString alloc] initWithString:allMessage attributes:[self messageStringAttributes]];
        return [mAttrsString copy];
    } else {
        allMessage = [NSString stringWithFormat:@"%@\n%@",message, aMessageCode];
        NSMutableAttributedString *mAttrsString = [[NSMutableAttributedString alloc] initWithString:allMessage attributes:[self messageStringAttributes]];
        
        NSRange range = [allMessage rangeOfString:aMessageCode];
        if (range.location == NSNotFound) {
            // ...
        } else {
            [mAttrsString addAttributes:[self codeStringAttributes] range:range];
        }
        return [mAttrsString copy];
    }
}

- (NSDictionary *)messageStringAttributes {
    NSDictionary *attrs = @{NSFontAttributeName:(self.messageFont ? self.messageFont : kLabelSize15),
                            NSForegroundColorAttributeName:UIColorFromRGB(0x333333),
                            NSParagraphStyleAttributeName: [self messageTextParagraphStyle]};
    return attrs;
}

- (NSDictionary *)codeStringAttributes {
    NSDictionary *attrs = @{NSFontAttributeName:kLabelSize13,
                            NSForegroundColorAttributeName:UIColorFromRGB(0x666666),
                            NSParagraphStyleAttributeName: [self messageTextParagraphStyle]};
    return attrs;
}

- (NSParagraphStyle *)messageTextParagraphStyle {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = WS(15/2);
    return [style copy];
}

- (void)setButtonTitleArr:(NSArray *)buttonTitleArr {
    if (_buttonTitleArr != buttonTitleArr) {
        
        NSArray *array = nil;
        if (buttonTitleArr.count > 2) {
            array = [buttonTitleArr subarrayWithRange:NSMakeRange(0, 2)];
        } else {
            array = buttonTitleArr;
        }
        
        _buttonTitleArr = [array copy];
        self.buttonsArray = [self createAlertButtons:_buttonTitleArr];
        self.devidinglinesArray = [self createDevidinglines:_buttonTitleArr.count];
    }
}

- (void)setButtonTitleFont:(UIFont *)buttonTitleFont {
    if (buttonTitleFont == nil) {
        return ;
    }
    
    _buttonTitleFont = buttonTitleFont;
    for (UIButton *button in self.buttonsArray) {
        button.titleLabel.font = _buttonTitleFont;
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        aLabel.backgroundColor = kColorClearColor;
        aLabel.font = (self.titleFont ? self.titleFont : kLabelSize17);
        aLabel.textAlignment = NSTextAlignmentCenter;
        aLabel.textColor = kColorBlackColor;
        [self addSubview:aLabel];
        _titleLabel = aLabel;
    }
    return _titleLabel;
}

- (UITextView *)messageTextView {
    if (!_messageTextView) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:nil];
        textView.backgroundColor = kColorClearColor;
        textView.font = (self.messageFont ? self.messageFont : kLabelSize15);
        textView.textColor = kColorBlackColor;
        textView.showsHorizontalScrollIndicator = false;
        textView.selectable = false;
        textView.textAlignment = NSTextAlignmentLeft;
        textView.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
        textView.textContainerInset = UIEdgeInsetsZero;
        textView.editable = false;
        [self addSubview:textView];
        _messageTextView = textView;
    }
    return _messageTextView;
}

- (NSArray *)createAlertButtons:(NSArray *)aTitles {
    NSInteger count = aTitles.count;
    if (count == 1) {
        NSString *title = aTitles.firstObject;
        UIButton *button = [self createButton:1 title:title];
        [button setTitleColor:UIColorFromRGB(0x5ED4E2) forState:UIControlStateNormal];
        [self addSubview:button];
        return @[button];
    } else {
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger i=0; i<count; i++) {
            NSString *title = [aTitles objectAtIndex:i];
            UIButton *button = [self createButton:i+1 title:title];
            [self addSubview:button];
            if (i == 0) {
                [button setTitleColor:kColorBlackColor forState:UIControlStateNormal];
            } else if (i == 1) {
                [button setTitleColor:UIColorFromRGB(0x5ED4E2) forState:UIControlStateNormal];
            }
            [mArray addObject:button];
        }
        return [mArray copy];
    }
}

- (UIButton *)createButton:(NSInteger)tag title:(NSString *)title {
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.frame = CGRectMake(0, 0, 0, kButtonHeight);
    aButton.tag = tag;
    aButton.backgroundColor = kColorClearColor;
    aButton.titleLabel.font =  (self.buttonTitleFont ? self.buttonTitleFont : kLabelSize15);
    [aButton setTitle:title forState:UIControlStateNormal];
    [aButton setTitleColor:RGBCOLOR(102, 102, 102) forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return aButton;
}

- (NSArray *)createDevidinglines:(NSInteger)buttonCount {
    if (buttonCount == 1) {
        UIImageView *horizonalline = [self createDevidinglineImageView:@"System_999_horizontal_alert_line"];
        [self addSubview:horizonalline];
        return @[horizonalline];
    } else if (buttonCount == 2) {
        UIImageView *horizonalline = [self createDevidinglineImageView:@"System_999_horizontal_alert_line"];
        [self addSubview:horizonalline];
        UIImageView *verticalline = [self createDevidinglineImageView:@"System_999_vertical_alert_line"];
        [self addSubview:verticalline];
        return @[horizonalline, verticalline];
    } else {
        return nil;
    }
}

- (UIImageView *)createDevidinglineImageView:(NSString *)imageName {
    UIImage *aImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *line = [[UIImageView alloc] initWithImage:aImage];
    line.tintColor = UIColorFromRGB(0xDDDDDD);
    return line;
}

@end
