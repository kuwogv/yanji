//
//  UILabel+Frame.h
//  CCBClientV2
//
//  Created by jinhong on 14-12-9.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frames)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign, readonly) CGFloat bottomY;
@property (nonatomic, assign, readonly) CGFloat rightX;
@end
