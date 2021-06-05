//
//  myCourseListCell.m
//  UTON智能云
//
//  Created by UTON on 2021/5/26.
//

#import "myCourseListCell.h"

@interface myCourseListCell ()
@property (nonatomic,strong)UILabel *courseName;
@property (nonatomic,strong)UILabel *courseTime;
@property (nonatomic,strong)UILabel *teacherName;
@property (nonatomic,strong)UIImageView *teacherImage;
@property (nonatomic,strong)UIButton *studyBtn;
@end

@implementation myCourseListCell

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
    [backgroundView addSubview:self.courseName];
    [backgroundView addSubview:self.courseTime];
    [backgroundView addSubview:self.teacherName];
    [backgroundView addSubview:self.teacherImage];
    [backgroundView addSubview:self.studyBtn];
    [self.courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(22));
        make.top.mas_equalTo(WS(16));
    }];
    [self.courseTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(14));
        make.top.mas_equalTo(self.courseName.mas_bottom).offset(WS(8));
    }];
    [self.teacherImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.width.mas_equalTo(WS(24));
        make.height.mas_equalTo(WS(24));
        make.top.mas_equalTo(self.courseTime.mas_bottom).offset(WS(12));
    }];
    [self.teacherName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.height.mas_equalTo(WS(15));
        make.top.mas_equalTo(self.teacherImage.mas_bottom).offset(WS(5));
    }];
    
    [self.studyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WS(80));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(32));
        make.bottom.mas_equalTo(-WS(22));
    }];
}

- (UIButton *)studyBtn{
    if (!_studyBtn) {
        _studyBtn = [[UIButton alloc]init];
        [_studyBtn setBackgroundImage:UTONImage(@"studyButtonImage") forState:UIControlStateNormal];
    }
    return _studyBtn;
}

- (UILabel *)courseName{
    if (!_courseName) {
        _courseName = [[UILabel alloc]init];
        _courseName.text = @"2022考研英语词汇分类功课班";
        _courseName.textColor = kColorBlackColor;
        _courseName.font = kLabelSize15;
    }
    return _courseName;
}

- (UILabel *)courseTime{
    if (!_courseTime) {
        _courseTime = [[UILabel alloc]init];
        _courseTime.text = @"3月15日 19:00开课";
        _courseTime.textColor = UIColorFromRGB(0xA7A6B3);
        _courseTime.font = kLabelSize12;
    }
    return _courseTime;
}
- (UILabel *)teacherName{
    if (!_teacherName) {
        _teacherName = [[UILabel alloc]init];
        _teacherName.text = @"王某某";
        _teacherName.textColor = UIColorFromRGB(0x696C7A);
        _teacherName.font = kLabelSize12;
    }
    return _teacherName;
}

- (UIImageView *)teacherImage{
    if (!_teacherImage) {
        _teacherImage = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
    }
    return _teacherImage;
}

@end
