//
//  YanJiHomePageViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/25.
//

#import "YanJiHomePageViewController.h"
#import "identityCardView.h"

@interface YanJiHomePageViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UIButton *searchBtn;
@property (nonatomic,strong) UTONTextField *searchTextField;
@property (nonatomic,strong) UIImageView *bannerImageView;
@property (nonatomic,strong) UILabel *studyRoomLabOne;
@property (nonatomic,strong) UILabel *studyRoomLabTwo;
@property (nonatomic,strong) UILabel *roomNumOne;
@property (nonatomic,strong) UILabel *roomNumTwo;
@property (nonatomic,strong) UILabel *studyLabOne;
@property (nonatomic,strong) UILabel *studyLabTwo;
@end

@implementation YanJiHomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self creatUI];
    
//    identityCardView *view = [[identityCardView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
//    [[UIApplication sharedApplication].windows[0] addSubview:view];
}

- (void)creatUI{
    
    UIScrollView *homeScrollView = [[UIScrollView alloc]init];
    homeScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+WS(100));
    homeScrollView.userInteractionEnabled = YES;
    [self.view addSubview:homeScrollView];
    [homeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2088")];
    [homeScrollView addSubview:backImageView];
    CGFloat statusBarHeight = 0.0f;
    if (@available(iOS 13, *)) {
        statusBarHeight = UIApplication.sharedApplication.delegate.window.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(-statusHeight);
        make.height.mas_equalTo(WS(220));
        make.right.mas_equalTo(self.view.mas_right);
    }];
    UIImageView *titleImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Group_1406")];
    [homeScrollView addSubview:titleImageView];
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(WS(37));
        make.height.mas_equalTo(WS(35));
        make.width.mas_equalTo(WS(86));
    }];
    //搜索域
    UIButton *highSearchBtn = [[UIButton alloc]init];
    [highSearchBtn setImage:UTONImage(@"highSearchBtnImage") forState:UIControlStateNormal];
    [highSearchBtn addTarget:self action:@selector(highSearchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [homeScrollView addSubview:highSearchBtn];
    [highSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-WS(16));
        make.height.mas_equalTo(WS(38));
        make.width.mas_equalTo(WS(24));
        make.top.mas_equalTo(titleImageView.mas_bottom).offset(WS(25));
    }];
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_21")];
    searchImageView.userInteractionEnabled = YES;
    [homeScrollView addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(titleImageView.mas_bottom).offset(WS(18));
        make.height.mas_equalTo(WS(52));
        make.right.mas_equalTo(highSearchBtn.mas_left).offset(-WS(12));
    }];
    self.searchBtn = [[UIButton alloc]init];
    [self.searchBtn setImage:UTONImage(@"searchBtnImage") forState:UIControlStateNormal];
    [homeScrollView addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(searchImageView.mas_centerY);
        make.left.mas_equalTo(WS(32));
        make.height.mas_equalTo(WS(20));
        make.width.mas_equalTo(WS(36));
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xF2F2F5);
    lineView.userInteractionEnabled = YES;
    [searchImageView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WS(0.8));
        make.left.mas_equalTo(self.searchBtn.mas_right).offset(WS(9));
        make.centerY.mas_equalTo(searchImageView.mas_centerY);
        make.height.mas_equalTo(WS(20));
    }];
    self.searchTextField = [[UTONTextField alloc]init];
    self.searchTextField.delegate = self;
    self.searchTextField.placeholder = @"输入关键词搜索";
    self.searchTextField.font = kLabelSize13;
    self.searchTextField.lineColor = kColorClearColor;
    [searchImageView addSubview:self.searchTextField];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right).offset(WS(10));
        make.centerY.mas_equalTo(searchImageView.mas_centerY);
        make.height.mas_equalTo(WS(30));
        make.right.mas_equalTo(searchImageView.mas_right);
    }];
    
    //上部功能区域
    UIImageView *whiteBackImage = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2144")];
    [self.view addSubview:whiteBackImage];
    [whiteBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(searchImageView.mas_bottom).offset(WS(12));
        make.height.mas_equalTo(WS(93));
    }];
    NSArray *topBtnImageAry = @[@"ProfessionalCatalogue",@"ListOfSchoolRecruitment",@"StrengthRanking",@"FractionalLine"];
    for (int i = 0; i < topBtnImageAry.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        [button setBackgroundImage:UTONImage(topBtnImageAry[i]) forState:UIControlStateNormal];
        button.tag = 111+i;
        [button addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [whiteBackImage addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WS(33)+WS(56)*i+(mScreenWidth-290)/3*i);
            make.top.mas_equalTo(WS(16));
            make.width.mas_equalTo(WS(56));
            make.height.mas_equalTo(WS(66));
        }];
    }
    //中间广告
    self.bannerImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_30")];
    [homeScrollView addSubview:self.bannerImageView];
    [self.bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.top.mas_equalTo(whiteBackImage.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-WS(16));
        make.height.mas_equalTo(WS(88));
    }];
    //中部功能区域
    NSArray *funtionBtnImgAry = @[@"icon_83",@"icon_82",@"icon_81",@"icon_80",@"icon_79"];
    NSArray *funtionBtnStrAry = @[@"招生简章",@"招生目录",@"参考书目",@"复试线",@"复试名单"];
    NSArray *funtionBtnImgAryTwo = @[@"icon_77",@"icon_76",@"icon_73",@"icon_75",@"icon_74"];
    NSArray *funtionBtnStrAryTwo = @[@"录取名单",@"调剂信息",@"非全日制",@"研友圈",@"咨询提问"];
    for (int i = 0; i < funtionBtnImgAry.count; i++) {
        UIButton *funtionBtn = [[UIButton alloc]init];
        [funtionBtn setImage:UTONImage(funtionBtnImgAry[i]) forState:UIControlStateNormal];
        funtionBtn.tag = 222+i;
        [funtionBtn setTitle:funtionBtnStrAry[i] forState:UIControlStateNormal];
        [funtionBtn setTitleColor:UIColorFromRGB(0x696C7A) forState:UIControlStateNormal];
        funtionBtn.titleLabel.font = kLabelSize12;
        funtionBtn.imageEdgeInsets = UIEdgeInsetsMake(-funtionBtn.titleLabel.frame.size.height, 13, 0, funtionBtn.titleLabel.frame.size.width);
        funtionBtn.titleEdgeInsets = UIEdgeInsetsMake(funtionBtn.imageView.frame.size.height+5, -WS(25), 0, -2);
        [homeScrollView addSubview:funtionBtn];
        [funtionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WS(16)+WS(50)*i+(mScreenWidth-282)/4*i);
            make.width.mas_equalTo(WS(50));
            make.height.mas_equalTo(WS(46));
            make.top.mas_equalTo(self.bannerImageView.mas_bottom).offset(WS(10));
        }];
        UIButton *funtionBtnTwo = [[UIButton alloc]init];
        [funtionBtnTwo setImage:UTONImage(funtionBtnImgAryTwo[i]) forState:UIControlStateNormal];
        funtionBtnTwo.tag = 333+i;
        [funtionBtnTwo setTitle:funtionBtnStrAryTwo[i] forState:UIControlStateNormal];
        [funtionBtnTwo setTitleColor:UIColorFromRGB(0x696C7A) forState:UIControlStateNormal];
        funtionBtnTwo.titleLabel.font = kLabelSize12;
        funtionBtnTwo.imageEdgeInsets = UIEdgeInsetsMake(-funtionBtnTwo.titleLabel.frame.size.height, 13, 0, funtionBtnTwo.titleLabel.frame.size.width);
        funtionBtnTwo.titleEdgeInsets = UIEdgeInsetsMake(funtionBtnTwo.imageView.frame.size.height+5, -WS(25), 0, -2);
        [homeScrollView addSubview:funtionBtnTwo];
        [funtionBtnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WS(16)+WS(50)*i+(mScreenWidth-282)/4*i);
            make.width.mas_equalTo(WS(50));
            make.height.mas_equalTo(WS(46));
            make.top.mas_equalTo(funtionBtn.mas_bottom).offset(WS(10));
        }];
    }
    
    //中部自习室区域
    
    UIView *studyView = [[UIView alloc]init];
    studyView.backgroundColor = kColorWhiteColor;
    [homeScrollView addSubview:studyView];
    [studyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.bannerImageView.mas_bottom).offset(WS(148));
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(WS(138));
    }];
    [self creatStudyViewWith:studyView];
    
}

- (void)topBtnAction:(UIButton *)btn{
    
}

- (void)highSearchBtnAction{
    
}

- (void)allSelfStudyRoom{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField becomeFirstResponder];
}

- (void)creatStudyViewWith:(UIView *)studyView{
    UIImageView *selfStudyImage = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2094")];
    [studyView addSubview:selfStudyImage];
    [selfStudyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.top.mas_equalTo(WS(7));
        make.width.mas_equalTo(WS(3));
        make.height.mas_equalTo(WS(10));
    }];
    UIButton *allSelfStudyBtn = [[UIButton alloc]init];
    [allSelfStudyBtn setBackgroundImage:UTONImage(@"allSelfStudyRoom") forState:UIControlStateNormal];
    [allSelfStudyBtn addTarget:self action:@selector(allSelfStudyRoom) forControlEvents:UIControlEventTouchUpInside];
    [studyView addSubview:allSelfStudyBtn];
    [allSelfStudyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(selfStudyImage.mas_right).offset(WS(8));
        make.right.mas_equalTo(-WS(20));
        make.height.mas_equalTo(WS(26));
    }];

    UIImageView *selfStudyOne = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_33")];
    selfStudyOne.userInteractionEnabled = YES;
    [studyView addSubview:selfStudyOne];
    [selfStudyOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(self.view.mas_centerX).offset(-WS(6));
        make.top.mas_equalTo(allSelfStudyBtn.mas_bottom).offset(WS(14));
        make.height.mas_equalTo(WS(98));
    }];
    self.studyRoomLabOne = [[UILabel alloc]init];
    self.studyRoomLabOne.text = @"xx自习室";
    self.studyRoomLabOne.textColor = kColorBlackColor;
    self.studyRoomLabOne.font = [UIFont fontWithName:@"PingFangSC-Medium" size:(15)];
    [selfStudyOne addSubview:self.studyRoomLabOne];
    [self.studyRoomLabOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(12));
        make.top.mas_equalTo(WS(16));
        make.height.mas_equalTo(WS(22));
    }];
    self.roomNumOne = [[UILabel alloc]init];
    self.roomNumOne.text = @"10/50";
    self.roomNumOne.textColor = UIColorFromRGB(0xCECED6);
    self.roomNumOne.font = kLabelSize13;
    [selfStudyOne addSubview:self.roomNumOne];
    [self.roomNumOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WS(15));
        make.left.mas_equalTo(WS(12));
        make.top.mas_equalTo(self.studyRoomLabOne.mas_bottom).offset(WS(2));
    }];
    self.studyLabOne = [[UILabel alloc]init];
    self.studyLabOne.text = @"8人正在学习";
    self.studyLabOne.textColor = UIColorFromRGB(0xA7A6B3);
    self.studyLabOne.font = kLabelSize13;
    self.studyLabOne.textAlignment = NSTextAlignmentRight;
    [selfStudyOne addSubview:self.studyLabOne];
    [self.studyLabOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WS(15));
        make.right.mas_equalTo(-WS(8));
        make.bottom.mas_equalTo(-WS(19));
    }];
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
        [selfStudyOne addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.roomNumOne.mas_bottom).offset(WS(8));
            make.width.height.mas_equalTo(WS(20));
            make.right.mas_equalTo(self.studyLabOne.mas_left).offset(-WS(10)-WS(13)*i);
        }];
    }
    
    UIImageView *selfStudyTwo = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_33")];
    selfStudyTwo.userInteractionEnabled = YES;
    [studyView addSubview:selfStudyTwo];
    [selfStudyTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-WS(16));
        make.left.mas_equalTo(self.view.mas_centerX).offset(WS(6));
        make.top.mas_equalTo(allSelfStudyBtn.mas_bottom).offset(WS(14));
        make.height.mas_equalTo(WS(98));
    }];
    self.studyRoomLabTwo = [[UILabel alloc]init];
    self.studyRoomLabTwo.text = @"冲刺自习室";
    self.studyRoomLabTwo.textColor = kColorBlackColor;
    self.studyRoomLabTwo.font = [UIFont fontWithName:@"PingFangSC-Medium" size:(15)];
    [selfStudyTwo addSubview:self.studyRoomLabTwo];
    [self.studyRoomLabTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(12));
        make.top.mas_equalTo(WS(16));
        make.height.mas_equalTo(WS(22));
    }];
    self.roomNumTwo = [[UILabel alloc]init];
    self.roomNumTwo.text = @"23/50";
    self.roomNumTwo.textColor = UIColorFromRGB(0xCECED6);
    self.roomNumTwo.font = kLabelSize13;
    [selfStudyTwo addSubview:self.roomNumTwo];
    [self.roomNumTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WS(15));
        make.left.mas_equalTo(WS(12));
        make.top.mas_equalTo(self.studyRoomLabTwo.mas_bottom).offset(WS(2));
    }];
    self.studyLabTwo = [[UILabel alloc]init];
    self.studyLabTwo.text = @"15人正在学习";
    self.studyLabTwo.textColor = UIColorFromRGB(0xA7A6B3);
    self.studyLabTwo.font = kLabelSize13;
    self.studyLabTwo.textAlignment = NSTextAlignmentRight;
    [selfStudyTwo addSubview:self.studyLabTwo];
    [self.studyLabTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WS(15));
        make.right.mas_equalTo(-WS(8));
        make.bottom.mas_equalTo(-WS(19));
    }];
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
        [selfStudyTwo addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.roomNumTwo.mas_bottom).offset(WS(8));
            make.width.height.mas_equalTo(WS(20));
            make.right.mas_equalTo(self.studyLabTwo.mas_left).offset(-WS(10)-WS(13)*i);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.searchTextField becomeFirstResponder]) {
        [self.searchTextField resignFirstResponder];
    }
    
}
- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event{
    if ([self.searchTextField becomeFirstResponder]) {
        [self.searchTextField resignFirstResponder];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
