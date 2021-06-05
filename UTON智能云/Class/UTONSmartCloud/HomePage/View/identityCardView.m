//
//  identityCardView.m
//  UTON智能云
//
//  Created by UTON on 2021/5/29.
//

#import "identityCardView.h"

@interface identityCardView (){
    //存放按钮
    NSMutableArray *_buttons;
}
@property (nonatomic,strong) NSString *selectYear;
@end

@implementation identityCardView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    _buttons = [[NSMutableArray alloc]init];
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2361")];
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(100));
        make.left.mas_equalTo(WS(32));
        make.right.mas_equalTo(-WS(32));
        make.height.mas_equalTo(WS(500));
    }];
    
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Frame_585")];
    topImageView.userInteractionEnabled = YES;
    [backImageView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(WS(260));
    }];
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:UTONImage(@"closeBtnImage") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(15));
        make.right.mas_equalTo(-WS(15));
        make.width.height.mas_equalTo(WS(22));
    }];
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"越了解 越贴心";
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:(17)];
    titleLab.textColor = kColorBlackColor;
    [backImageView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(40));
        make.centerX.mas_equalTo(backImageView.mas_centerX);
        make.height.mas_equalTo(WS(20));
    }];
    UILabel *tipsLab = [[UILabel alloc]init];
    tipsLab.text = @"获取你的身份卡";
    tipsLab.textColor = UIColorFromRGB(0xA7A6B3);
    tipsLab.font = kLabelSize13;
    [backImageView addSubview:tipsLab];
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backImageView.mas_centerX);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(WS(6));
        make.height.mas_equalTo(WS(20));
    }];
    UILabel *yearLab = [[UILabel alloc]init];
    yearLab.text = @"您的备考届次";
    yearLab.textColor = kColorBlackColor;
    yearLab.font = kLabelSize15;
    [backImageView addSubview:yearLab];
    [yearLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(24));
        make.top.mas_equalTo(tipsLab.mas_bottom).offset(WS(30));
        make.height.mas_equalTo(WS(20));
    }];
    NSArray *titleAry = @[@"2022",@"2023",@"2024"];
    for (int i = 0; i < titleAry.count; i++) {
        UIButton *yearBtn = [[UIButton alloc]init];
        yearBtn.backgroundColor = kColorWhiteColor;
        [yearBtn setTitle:titleAry[i] forState:UIControlStateNormal];
        [yearBtn setTitleColor:UIColorFromRGB(0x696C7A) forState:UIControlStateNormal];
        yearBtn.titleLabel.font = kLabelSize14;
        [yearBtn addTarget:self action:@selector(yearbtnAction:) forControlEvents:UIControlEventTouchUpInside];
        yearBtn.selected = NO;
        yearBtn.layer.cornerRadius = 8;
        [backImageView addSubview:yearBtn];
        [yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WS(68));
            make.height.mas_equalTo(WS(36));
            make.top.mas_equalTo(yearLab.mas_bottom).offset(WS(12));
            make.left.mas_equalTo(WS(24)+WS(68)*i+WS(12)*i);
        }];
        [_buttons addObject:yearBtn];
    }
    
    UILabel *majorLab = [[UILabel alloc]init];
    majorLab.text = @"您的意向专业";
    majorLab.textColor = kColorBlackColor;
    majorLab.font = kLabelSize15;
    [backImageView addSubview:majorLab];
    [majorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(24));
        make.top.mas_equalTo(yearLab.mas_bottom).offset(WS(80));
        make.height.mas_equalTo(WS(20));
    }];
    UIButton *majorBtn = [[UIButton alloc]init];
    [majorBtn setBackgroundImage:UTONImage(@"chooseMajorBtnImage") forState:UIControlStateNormal];
    [majorBtn addTarget:self action:@selector(chooseMajor) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:majorBtn];
    [majorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(24));
        make.height.mas_equalTo(WS(36));
        make.width.mas_equalTo(WS(88));
        make.top.mas_equalTo(majorLab.mas_bottom).offset(WS(12));
    }];
    
    UILabel *schoolLab = [[UILabel alloc]init];
    schoolLab.text = @"您的意向学校";
    schoolLab.textColor = kColorBlackColor;
    schoolLab.font = kLabelSize15;
    [backImageView addSubview:schoolLab];
    [schoolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(24));
        make.top.mas_equalTo(majorBtn.mas_bottom).offset(WS(32));
        make.height.mas_equalTo(WS(20));
    }];
    
    UIButton *schoolBtn = [[UIButton alloc]init];
    [schoolBtn setTitle:@"江西师范大学" forState:UIControlStateNormal];
    [schoolBtn setImage:UTONImage(@"dropDownSel") forState:UIControlStateNormal];
    [schoolBtn addTarget:self action:@selector(chooseSchool) forControlEvents:UIControlEventTouchUpInside];
    [schoolBtn setTitleColor:kColorBlackColor forState:UIControlStateNormal];
    schoolBtn.titleLabel.font = kLabelSize15;
    schoolBtn.layer.cornerRadius = 8;
    schoolBtn.backgroundColor = kColorWhiteColor;
    schoolBtn.imageEdgeInsets = UIEdgeInsetsMake(0, schoolBtn.titleLabel.frame.size.width+97, 0, -schoolBtn.titleLabel.frame.size.width-97);
    schoolBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -schoolBtn.imageView.frame.size.width-10, 0, schoolBtn.imageView.frame.size.width+10);
    [backImageView addSubview:schoolBtn];
    [schoolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(24));
        make.top.mas_equalTo(schoolLab.mas_bottom).offset(WS(12));
        make.height.mas_equalTo(WS(36));
        make.width.mas_equalTo(WS(120));
    }];
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setBackgroundImage:UTONImage(@"sureBtnImage") forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-WS(24));
        make.left.mas_equalTo(WS(41));
        make.right.mas_equalTo(-WS(41));
        make.height.mas_equalTo(WS(44));
    }];
}

- (void)sureBtnAction{
    [self removeFromSuperview];
}

- (void)dismissView{
    [self removeFromSuperview];
}

- (void)yearbtnAction:(UIButton *)btn{
    [self updateUIWithSelectedIndex:[_buttons indexOfObject:btn]];
}

-(void)updateUIWithSelectedIndex:(NSInteger)index{
    for (UIButton *button in _buttons) {
        if ([_buttons indexOfObject:button] == index) {
            button.backgroundColor = UIColorFromRGB(0xFF6D00);
            [button setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
            button.selected = true;
            self.selectYear = button.titleLabel.text;
        }else{
            button.backgroundColor = kColorWhiteColor;
            [button setTitleColor:UIColorFromRGB(0x696C7A) forState:UIControlStateNormal];
            button.selected = false;
        }
    }
}

- (void)chooseMajor{
    
}

- (void)chooseSchool{
    
}


@end
