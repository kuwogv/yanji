//
//  appleSeniorCell.m
//  UTON智能云
//
//  Created by UTON on 2021/5/29.
//

#import "appleSeniorCell.h"

@interface appleSeniorCell ()

@end

@implementation appleSeniorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubView];
    }
    return self;;
}

- (void)setUpSubView{
    [self.contentView addSubview:self.leftLab];
    [self.contentView addSubview:self.inputTextField];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(WS(20));
        make.width.mas_equalTo(WS(80));
    }];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(WS(40));
        make.left.mas_equalTo(self.leftLab.mas_right).offset(WS(10));
        make.right.mas_equalTo(0);
    }];
    [self.contentView addSubview:self.boyBtn];
    [self.contentView addSubview:self.girlBtn];
    [self.boyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(WS(20));
        make.left.mas_equalTo(self.leftLab.mas_right).offset(WS(10));
        make.width.mas_equalTo(WS(37));
    }];
    [self.girlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(WS(20));
        make.left.mas_equalTo(self.boyBtn.mas_right).offset(WS(17));
        make.width.mas_equalTo(WS(37));
    }];
}

- (UIButton *)boyBtn{
    if (!_boyBtn) {
        _boyBtn = [[UIButton alloc]init];
        [_boyBtn setImage:UTONImage(@"sexSelBtnImage") forState:UIControlStateNormal];
        [_boyBtn setTitle:@"男" forState:UIControlStateNormal];
        _boyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [_boyBtn setTitleColor:kColorBlackColor forState:UIControlStateNormal];
        _boyBtn.titleLabel.font = kLabelSize14;
    }
    return _boyBtn;
}

- (UIButton *)girlBtn{
    if (!_girlBtn) {
        _girlBtn = [[UIButton alloc]init];
        [_girlBtn setImage:UTONImage(@"sexunSelBtnImage") forState:UIControlStateNormal];
        [_girlBtn setTitle:@"女" forState:UIControlStateNormal];
        [_girlBtn setTitleColor:kColorBlackColor forState:UIControlStateNormal];
        _girlBtn.titleLabel.font = kLabelSize14;
        _girlBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    return _girlBtn;
}

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc]init];
        _inputTextField.font = kLabelSize14;
    }
    return _inputTextField;
}

- (UILabel *)leftLab{
    if (!_leftLab) {
        _leftLab = [[UILabel alloc]init];
        _leftLab.textColor = UIColorFromRGB(0x696C7A);
        _leftLab.font = kLabelSize14;
    }
    return _leftLab;
}

@end
