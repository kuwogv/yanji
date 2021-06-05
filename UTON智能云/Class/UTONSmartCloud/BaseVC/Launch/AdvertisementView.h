//
//  AdvertisementView.h
//  CCBCloudMerchant
//
//  Created by LBD on 2020/4/17.
//  Copyright © 2020 ccb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdvertisementView : UIView
- (instancetype)initWithImage:(UIImage *)image;
@property(nonatomic,copy)void (^cancelButtonClickCallBack)(void);
@property(nonatomic,copy)void (^clickImageViewCallBack)(void);
@end

NS_ASSUME_NONNULL_END
