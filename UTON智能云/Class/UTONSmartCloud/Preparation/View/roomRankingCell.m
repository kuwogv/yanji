//
//  roomRankingCell.m
//  UTON智能云
//
//  Created by UTON on 2021/6/5.
//

#import "roomRankingCell.h"

@implementation roomRankingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubView];
    }
    return self;;
}

- (void)setUpSubView{
    UIImageView *BackImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2303")];
    BackImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:BackImageView];
    [BackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(WS(104));
        make.top.mas_equalTo(WS(5));
    }];
    [BackImageView addSubview:self.rankingLab];
    [BackImageView addSubview:self.headerImageView];
    [BackImageView addSubview:self.nameLab];
    [BackImageView addSubview:self.schoolLab];
    [BackImageView addSubview:self.hourLab];
    [self.rankingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(34));
        make.width.height.mas_equalTo(WS(20));
        make.left.mas_equalTo(WS(30));
    }];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(25));
        make.width.height.mas_equalTo(WS(48));
        make.left.mas_equalTo(self.rankingLab.mas_right).offset(WS(16));
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(12));
        make.top.mas_equalTo(WS(25));
        make.height.mas_equalTo(WS(22));
    }];
    [self.schoolLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(12));
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(WS(2));
            make.height.mas_equalTo(WS(22));
    }];
    [self.hourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-WS(30));
        make.top.mas_equalTo(WS(34));
        make.height.mas_equalTo(WS(20));
    }];
    
}

- (UILabel *)rankingLab{
    if (!_rankingLab) {
        _rankingLab = [[UILabel alloc]init];
        _rankingLab.backgroundColor = UIColorFromRGB(0xCECED6);
        _rankingLab.textColor = kColorWhiteColor;
        _rankingLab.layer.cornerRadius = 5;
        _rankingLab.layer.masksToBounds = YES;
        _rankingLab.textAlignment = NSTextAlignmentCenter;
        _rankingLab.font = kLabelSize14;
    }
    return _rankingLab;
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
        _nameLab.text = @"老人与海";
        _nameLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        _nameLab.textColor = kColorBlackColor;
    }
    return _nameLab;
}

- (UILabel *)schoolLab{
    if (!_schoolLab) {
        _schoolLab = [[UILabel alloc]init];
        _schoolLab.text = @"北京大学";
        _schoolLab.font = kLabelSize13;
        _schoolLab.textColor = UIColorFromRGB(0xA7A6B3);
    }
    return _schoolLab;
}

- (UILabel *)hourLab{
    if (!_hourLab) {
        _hourLab = [[UILabel alloc]init];
        _hourLab.textColor = UIColorFromRGB(0x696C7A);
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"80h" attributes:@{NSFontAttributeName:kLabelSize18}];
        NSRange range1=[[hintString string]rangeOfString:@"h"];
        [hintString addAttribute:NSFontAttributeName value:kLabelSize12 range:range1];
        _hourLab.attributedText = hintString;
    }
    return _hourLab;
}

@end
