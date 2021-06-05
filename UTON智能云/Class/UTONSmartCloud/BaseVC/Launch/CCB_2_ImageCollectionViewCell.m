//
//  CCB_2_ImageCollectionViewCell.m
//  CCBMobileBank
//
//  Created by Ansonyc on 16/5/19.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import "CCB_2_ImageCollectionViewCell.h"

@interface CCB_2_ImageCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CCB_2_ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }

    return self;
}

#pragma - mark Property
- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        self.imageView.image = image;
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
    }

    return _imageView;
}

@end
