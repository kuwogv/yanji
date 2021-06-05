//
//  AdvertisementView.m
//  CCBCloudMerchant
//
//  Created by LBD on 2020/4/17.
//  Copyright © 2020 ccb. All rights reserved.
//

#import "AdvertisementView.h"

@interface AdvertisementView ()
@property (nonatomic, strong) UIImageView *AdvertisementImageView;
/** *  广告页"跳过"按钮 */
@property (nonatomic, strong) UIButton *skipButton;
/** *  倒数计时器 */
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIImageView *bottomImageView;
@end

@implementation AdvertisementView{
    int verifyMaxTime;
    NSDate *verifyDate;
}

- (instancetype)initWithImage:(UIImage *)image{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, mScreenWidth, mScreenHeight);
        self.backgroundColor = kColorWhiteColor;
        verifyMaxTime = 4;
        [self addSubview:self.AdvertisementImageView];
        [self.AdvertisementImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
        [self addSubview:self.skipButton];
        [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(WS(40));
            make.right.mas_equalTo(-WS(25));
            make.width.mas_equalTo(WS(85));
            make.height.mas_equalTo(WS(28));
        }];
        [self addSubview:self.bottomImageView];
        [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
        [self startTheTimer];
        self.AdvertisementImageView.image = image;
    }
    return self;
}

- (void)startTheTimer{
    if(self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    verifyDate = [NSDate date];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(changeCircleLabelText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}

- (void)changeCircleLabelText{
    int showTime = [self timeForShow:NO];
    [self.skipButton setTitle:[NSString stringWithFormat:@"%d 跳过广告",showTime] forState:UIControlStateNormal];
    if (showTime == 1) {
        [self performSelector:@selector(clickSkip) withObject:nil afterDelay:0.95];
    }else if(showTime == 0){
        [self performSelector:@selector(clickSkip) withObject:nil afterDelay:0.1];
    }
}

- (int)timeForShow:(BOOL)isFirst{
    
    if (isFirst) {
        verifyDate = [NSDate date];
    }else{
        
    }
    
    int showTime = [self timeToFormatterNow];
    
    if (showTime <= 0) {
        showTime = 0;
    }
    
    return showTime;
}

- (int)timeToFormatterNow{
    NSTimeInterval times = [[NSDate date] timeIntervalSinceDate:verifyDate];
    NSString *timeStr = [NSString stringWithFormat:@"%.0f",times];
//    CCBLogDebug(@"--------timeStr------%@",timeStr);
    return verifyMaxTime - [timeStr intValue] - 1;
}

- (UIImageView *)AdvertisementImageView{
    if (!_AdvertisementImageView) {
        CGSize viewSize =self.frame.size;
        NSString*viewOrientation =@"Portrait";//横屏请设置成 @"Landscape"
        NSString*launchImage =@"";
        NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
        for(NSDictionary* dict in imagesDict) {
            CGSize imageSize =CGSizeFromString(dict[@"UILaunchImageSize"]);
            if(CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
                launchImage = dict[@"UILaunchImageName"];
            }
        }
        _AdvertisementImageView = [[UIImageView alloc]init];
        _AdvertisementImageView.userInteractionEnabled = YES;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
        action:@selector(advertImageViewAction:)];
        [_AdvertisementImageView addGestureRecognizer:gesture];
    }
    return _AdvertisementImageView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [[UIButton alloc]init];
        _skipButton.backgroundColor = [UIColor darkGrayColor];
        [_skipButton setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
        _skipButton.titleLabel.numberOfLines = 0;
        _skipButton.titleLabel.font = kLabelSize13;
        _skipButton.layer.cornerRadius = 5;
        [_skipButton setTitle:[NSString stringWithFormat:@" %d秒 跳过",verifyMaxTime - 1] forState:UIControlStateNormal];
        [[_skipButton titleLabel] setFont:kLabelSize15];
        [_skipButton addTarget:self
                        action:@selector(clickSkip)
              forControlEvents:UIControlEventTouchUpInside];
    }

    return _skipButton;
}

- (UIImageView *)bottomImageView{
    if (!_bottomImageView) {
        _bottomImageView = [[UIImageView alloc]initWithImage:UTONImage(@"advertiaementBottomImage")];
    }
    return _bottomImageView;
}

- (void)clickSkip {
    // 取消倒数
    if (self.timer == nil) {
        return;
    }
    if(self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (self.cancelButtonClickCallBack) {
        self.cancelButtonClickCallBack();
    }
}

- (void)advertImageViewAction:(UITapGestureRecognizer *)recognizer{
    if (self.clickImageViewCallBack) {
        self.clickImageViewCallBack();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
