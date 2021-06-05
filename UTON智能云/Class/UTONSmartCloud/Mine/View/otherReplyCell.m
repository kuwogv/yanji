//
//  otherReplyCell.m
//  UTON智能云
//
//  Created by UTON on 2021/6/2.
//

#import "otherReplyCell.h"

@interface otherReplyCell ()
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *replyLab;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIImageView *invitImageView;
@property (nonatomic,strong) UIButton *likesBtn;
@property (nonatomic,strong) UIButton *replyBtn;
@end

@implementation otherReplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubView];
    }
    return self;;
}

- (void)setUpSubView{
    self.contentView.backgroundColor = kColorWhiteColor;
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.replyLab];
    [self.contentView addSubview:self.likesBtn];
    [self.contentView addSubview:self.replyBtn];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(WS(16));
        make.width.height.mas_equalTo(WS(40));
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(8));
        make.top.mas_equalTo(WS(16));
        make.height.mas_equalTo(WS(20));
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(19));
        make.height.mas_equalTo(WS(14));
        make.left.mas_equalTo(self.nameLab.mas_right).offset(WS(2));
    }];
    [self.replyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(WS(4));
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(8));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(20));
    }];
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    [self.contentView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.top.mas_equalTo(self.replyLab.mas_bottom).offset(WS(12));
        make.height.mas_equalTo(WS(72));
    }];
    [backgroundView addSubview:self.titleLab];
    [backgroundView addSubview:self.invitImageView];
    [self.invitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-WS(12));
        make.top.mas_equalTo(WS(12));
        make.width.height.mas_equalTo(WS(48));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.left.mas_equalTo(WS(12));
        make.height.mas_equalTo(WS(40));
        make.right.mas_equalTo(self.invitImageView.mas_left).offset(-WS(24));
    }];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-WS(16));
        make.bottom.mas_equalTo(-WS(16));
        make.width.mas_equalTo(WS(41));
        make.height.mas_equalTo(WS(16));
    }];
    [self.likesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-WS(16));
        make.width.mas_equalTo(WS(41));
        make.height.mas_equalTo(WS(16));
        make.right.mas_equalTo(self.replyBtn.mas_left).offset(-WS(16));
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(WS(8));
    }];
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
        _nameLab.text = @"哪个回复的？";
        _nameLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        _nameLab.textColor = kColorBlackColor;
    }
    return _nameLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"·16:32";
        _timeLab.textColor = UIColorFromRGB(0xA7A6B3);
        _timeLab.font = kLabelSize12;
    }
    return _timeLab;
}

- (UILabel *)replyLab{
    if (!_replyLab) {
        _replyLab = [[UILabel alloc]init];
        _replyLab.text = @"❤️去看了黑豹乐队秦勇和李彤的电台采访";
        _replyLab.textColor = kColorBlackColor;
        _replyLab.font = kLabelSize13;
    }
    return _replyLab;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"这是一大坨测试数据测数据，测试数据测试数据啊测试数据";
        _titleLab.font = kLabelSize13;
        _titleLab.textColor = kColorBlackColor;
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

- (UIImageView *)invitImageView{
    if (!_invitImageView) {
        _invitImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_35")];
        _invitImageView.layer.cornerRadius = 10;
        _invitImageView.layer.masksToBounds = YES;
    }
    return _invitImageView;
}

- (UIButton *)likesBtn{
    if (!_likesBtn) {
        _likesBtn = [[UIButton alloc]init];
        [_likesBtn setBackgroundImage:UTONImage(@"likesBtnImage") forState:UIControlStateNormal];
    }
    return _likesBtn;
}

- (UIButton *)replyBtn{
    if (!_replyBtn) {
        _replyBtn = [[UIButton alloc]init];
        [_replyBtn setBackgroundImage:UTONImage(@"replyBtnImage") forState:UIControlStateNormal];
    }
    return _replyBtn;
}

@end
