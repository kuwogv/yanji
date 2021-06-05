//
//  myIssueAndQuestionCell.m
//  UTON智能云
//
//  Created by UTON on 2021/6/1.
//

#import "myIssueAndQuestionCell.h"

@interface myIssueAndQuestionCell ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *timeLab;
@end

@implementation myIssueAndQuestionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.invitImageView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.timeLab];
    [self.invitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.invitImageView.mas_bottom).offset(WS(8));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(WS(36));
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(WS(11));
        make.height.mas_equalTo(WS(14));
    }];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(WS(9));
        make.width.height.mas_equalTo(WS(16));
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(WS(10));
        make.height.mas_equalTo(WS(14));
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(4));
    }];
}

- (UIImageView *)invitImageView{
    if (!_invitImageView) {
        _invitImageView = [[UIImageView alloc]init];
    }
    return _invitImageView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"普通的三本院校，测试数据测试数据，测试数据";
        _titleLab.font = kLabelSize14;
        _titleLab.textColor = kColorBlackColor;
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"19:30";
        _timeLab.font = kLabelSize11;
        _timeLab.textColor = UIColorFromRGB(0xCECED6);
    }
    return _timeLab;
}

- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
    }
    return _headerImageView;
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"郭靖在此";
        _nameLab.font = kLabelSize12;
        _nameLab.textColor = UIColorFromRGB(0xA7A6B3);
    }
    return _nameLab;
}

@end
