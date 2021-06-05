//
//  CCB_2_LaunchImageCollectionViewCell.m
//  CCBMobileBank
//
//  Created by Ansonyc on 16/5/19.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import "CCB_2_LaunchImageCollectionViewCell.h"

@implementation CCB_2_LaunchImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:button];

        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];

        float buttonWidth = mScreenWidth;
        
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(buttonWidth);
            
            make.bottom.mas_equalTo(self.mas_bottom);//减少5是因为这个高度是40，而不是30
               
            make.height.mas_equalTo(WS(300));

        }];

    }

    return self;
}

#pragma - mark UI Event Handler
- (void)clickButton {
    if ([self.delegate respondsToSelector:@selector(launchImageCollectionViewCellDidClickButton:)]) {
        [self.delegate launchImageCollectionViewCellDidClickButton:self];
    }
}

@end
