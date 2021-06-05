//
//  CCB_2_LaunchImageCollectionViewCell.h
//  CCBMobileBank
//
//  Created by Ansonyc on 16/5/19.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import "CCB_2_ImageCollectionViewCell.h"

@class CCB_2_LaunchImageCollectionViewCell;
@protocol CCBLaunchImageCollectionViewDelegate <NSObject>
@optional
/**
 *  点击底部按钮的回调
 *
 *  @param cell 当前cell
 */
- (void)launchImageCollectionViewCellDidClickButton:(CCB_2_LaunchImageCollectionViewCell *)cell;
@end

/**
 *  底部有一个"进入"按钮的图片collectionviewcell
 */
@interface CCB_2_LaunchImageCollectionViewCell : CCB_2_ImageCollectionViewCell

/**
 *  委托
 */
@property (nonatomic, weak) id<CCBLaunchImageCollectionViewDelegate> delegate;

@end
