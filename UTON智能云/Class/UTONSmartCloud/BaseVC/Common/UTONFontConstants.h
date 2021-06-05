//
//  UTONFontConstants.h
//  CCBMobileBank
//
//  Created by Ansonyc on 16/4/13.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import "M.h"

#ifndef UTONFontConstants_h
#define UTONFontConstants_h


#pragma - mark
#define kLabelSize10 [UIFont systemFontOfSize:10]
#define kLabelSize11 [UIFont systemFontOfSize:11]
#define kLabelSize12 [UIFont systemFontOfSize:12]
#define kLabelSize13 [UIFont systemFontOfSize:13]
#define kLabelSize14 [UIFont systemFontOfSize:14]
#define kLabelSize15 [UIFont systemFontOfSize:15]
#define kLabelSize16 [UIFont systemFontOfSize:16]
#define kLabelSize17 [UIFont systemFontOfSize:17]
#define kLabelSize18 [UIFont systemFontOfSize:18]
#define kLabelSize19 [UIFont systemFontOfSize:19]
#define kLabelSize20 [UIFont systemFontOfSize:20]
#define kLabelSize24 [UIFont systemFontOfSize:24]
#define kLabelBoldSize10 [UIFont fontWithName:@"Helvetica-Bold" size:10];
#define kLabelBoldSize11 [UIFont fontWithName:@"Helvetica-Bold" size:11];
#define kLabelBoldSize12 [UIFont fontWithName:@"Helvetica-Bold" size:12];
#define kLabelBoldSize13 [UIFont fontWithName:@"Helvetica-Bold" size:13];
#define kLabelBoldSize14 [UIFont fontWithName:@"Helvetica-Bold" size:14];
#define kLabelBoldSize15 [UIFont fontWithName:@"Helvetica-Bold" size:15];
#define kLabelBoldSize16 [UIFont fontWithName:@"Helvetica-Bold" size:16];
#define kLabelBoldSize17 [UIFont fontWithName:@"Helvetica-Bold" size:17];
#define kLabelBoldSize18 [UIFont fontWithName:@"Helvetica-Bold" size:18];
#define kLabelBoldSize19 [UIFont fontWithName:@"Helvetica-Bold" size:19];
#define kLabelBoldSize20 [UIFont fontWithName:@"Helvetica-Bold" size:20];
#define kSizeMarginToSuperView45 WS(22.5)
#define kSizeMarginWithItemInSameLine20 WS(10)
#define kSizeButtonHeight30 WS(30)


#define WScale M.A
#define WHcale M.G
#define WS(v) ((v)*WScale)
#define WH(v) ((v)*WHcale)
#define kLabelFontRate M.B
#define mScreenWidth [UIScreen mainScreen].bounds.size.width
#define mScreenHeight [UIScreen mainScreen].bounds.size.height
/*
 iphonex以上全面屏
 **/
#define kIs_iPhoneX [[UIApplication sharedApplication] statusBarFrame].size.height > 20.0

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0

#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kSafeHeight (kStatusBarHeight>20?34:0)
#define kTabBarHeight (kStatusBarHeight>20?83:49)
#define kVCHeight (SCREEN_HEIGHT-kTopHeight-kTabBarHeight)
#define kSafeVCHeight (kStatusBarHeight>20?(SCREEN_HEIGHT-kTopHeight-34):(SCREEN_HEIGHT-kTopHeight))

#endif /* UTONFontConstants_h */
