//
//  myStoreCell.m
//  UTON智能云
//
//  Created by UTON on 2021/6/2.
//

#import "myStoreCell.h"

@interface myStoreCell ()
@property (nonatomic,strong) UILabel *schoolNameLab;
@property (nonatomic,strong) UILabel *fractionLab;
@end

@implementation myStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubView];
    }
    return self;;
}

- (void)setUpSubView{
    self.contentView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = kColorWhiteColor;
    backgroundView.layer.cornerRadius = 6;
    [self.contentView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(82));
    }];
    
    [backgroundView addSubview:self.schoolNameLab];
    [backgroundView addSubview:self.fractionLab];
    [self.schoolNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(WS(16));
        make.height.mas_equalTo(WS(21));
    }];
    [self.fractionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(20));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(24));
    }];
    UILabel *tipsLab = [[UILabel alloc]init];
    tipsLab.text = @"今年录取分";
    tipsLab.font = kLabelSize12;
    tipsLab.textColor = UIColorFromRGB(0x696C7A);
    tipsLab.textAlignment = NSTextAlignmentRight;
    [backgroundView addSubview:tipsLab];
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fractionLab.mas_bottom).offset(WS(4));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(15));
    }];
}

- (UILabel *)schoolNameLab{
    if (!_schoolNameLab) {
        _schoolNameLab = [[UILabel alloc]init];
        _schoolNameLab.text = @"北京大学";
        _schoolNameLab.font = kLabelSize15;
        _schoolNameLab.textColor = kColorBlackColor;
    }
    return _schoolNameLab;
}

- (UILabel *)fractionLab{
    if (!_fractionLab) {
        _fractionLab = [[UILabel alloc]init];
        _fractionLab.text = @"701";
        _fractionLab.font = [UIFont fontWithName:@"D-DINCondensed-DINCondensed-Bold" size:17];
        _fractionLab.textColor = kColorBlackColor;
    }
    return _fractionLab;
}

@end
