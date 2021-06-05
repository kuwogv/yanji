//
//  myConsultCell.m
//  UTON智能云
//
//  Created by UTON on 2021/5/31.
//

#import "myConsultCell.h"

@interface myConsultCell ()

@end

@implementation myConsultCell

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
    backgroundView.layer.cornerRadius = 10;
    [self.contentView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.top.mas_equalTo(WS(12));
        make.bottom.mas_equalTo(0);
    }];
    [backgroundView addSubview:self.heardImageView];
    [backgroundView addSubview:self.nameLab];
    [backgroundView addSubview:self.timeLab];
    [backgroundView addSubview:self.consultBtn];
    [self.heardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.left.mas_equalTo(WS(16));
        make.width.height.mas_equalTo(WS(44));
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.left.mas_equalTo(self.heardImageView.mas_right).offset(WS(12));
        make.height.mas_equalTo(WS(20));
    }];
    [self.consultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WS(80));
        make.height.mas_equalTo(WS(32));
        make.right.mas_equalTo(-WS(16));
        make.top.mas_equalTo(WS(20));
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WS(20));
        make.top.mas_equalTo(self.consultBtn.mas_bottom).offset(WS(1));
        make.centerX.mas_equalTo(self.consultBtn.mas_centerX);
    }];
}

- (UIImageView *)heardImageView{
    if (!_heardImageView) {
        _heardImageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
        
    }
    return _heardImageView;
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"我是谁";
        _nameLab.font = kLabelSize15;
        _nameLab.textColor = kColorBlackColor;
    }
    return _nameLab;
}

- (UIButton *)consultBtn{
    if (!_consultBtn) {
        _consultBtn = [[UIButton alloc]init];
        _consultBtn.layer.cornerRadius = 6;
        _consultBtn.backgroundColor = UIColorFromRGB(0xFF6D00);
        [_consultBtn setTitle:@"继续咨询" forState:UIControlStateNormal];
        [_consultBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
        _consultBtn.titleLabel.font = kLabelSize14;
    }
    return _consultBtn;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"剩余15:35";
        _timeLab.textColor = UIColorFromRGB(0xFF6D00);
        _timeLab.font = kLabelSize12;
    }
    return _timeLab;
}

@end
