//
//  studyRoomDetailCell.m
//  UTON智能云
//
//  Created by UTON on 2021/6/5.
//

#import "studyRoomDetailCell.h"

@interface studyRoomDetailCell ()
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *nameLab;
@end

@implementation studyRoomDetailCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = UIColorFromRGB(0xA7A6B3).CGColor;
    [self.contentView addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(WS(44));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(WS(12));
    }];
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(WS(20));
        make.top.mas_equalTo(self.headerImageView.mas_bottom).offset(WS(4));
    }];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(WS(20));
        make.top.mas_equalTo(self.timeLab.mas_bottom);
    }];
}

- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
    }
    return _headerImageView;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"·02:28:21" attributes:@{NSFontAttributeName:kLabelSize12,NSForegroundColorAttributeName:UIColorFromRGB(0xA7A6B3)}];
        NSRange range1=[[hintString string]rangeOfString:@"·"];
        [hintString addAttribute:NSFontAttributeName value:kLabelSize18 range:range1];
        [hintString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x00BA88) range:range1];
        _timeLab.attributedText = hintString;
    }
    return _timeLab;
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"老人与海";
        _nameLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _nameLab.textColor = UIColorFromRGB(0xCECED6);
    }
    return _nameLab;
}

@end
