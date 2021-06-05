//
//  studyRoomCell.m
//  UTON智能云
//
//  Created by UTON on 2021/6/3.
//

#import "studyRoomCell.h"

@interface studyRoomCell ()

@end

@implementation studyRoomCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.backImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    self.idBtn = [[UIButton alloc]init];
    [self.contentView addSubview:self.idBtn];
    [self.idBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(WS(25));
        make.height.mas_equalTo(WS(20));
        make.width.mas_equalTo(WS(85));
    }];
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.numberOfLines = 2;
    self.nameLab.textColor = kColorBlackColor;
    self.nameLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(42));
        make.top.mas_equalTo(self.idBtn.mas_bottom).offset(WS(12));
    }];
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(WS(11));
            make.width.height.mas_equalTo(WS(24));
            make.left.mas_equalTo(self.contentView.mas_centerX).offset(-WS(40)+WS(20)*i);
            
        }];
    }
    self.studyNumLab = [[UILabel alloc]init];
    self.studyNumLab.textColor = UIColorFromRGB(0x696C7A);
    self.studyNumLab.font = kLabelSize12;
    [self.contentView addSubview:self.studyNumLab];
    [self.studyNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(WS(15));
        make.bottom.mas_equalTo(-WS(20));
    }];
    
    
}



@end
