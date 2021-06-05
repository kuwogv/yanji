//
//  openVipViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/26.
//

#import "openVipViewController.h"

@interface openVipViewController ()
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *userNameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UIImageView *vipImageView;
@property (nonatomic,strong) NSMutableArray *priceButtons;
@property (nonatomic,strong) NSArray *priceAry;
@property (nonatomic,strong) UIButton *openVipBtn;
@end

@implementation openVipViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhiteColor;
    [self creatNavition];
    [self creatUI];
}

- (void)creatNavition{
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2142")];
    [self.view addSubview:backImageView];
    CGFloat statusBarHeight = 0.0f;
    if (@available(iOS 13, *)) {
        statusBarHeight = UIApplication.sharedApplication.delegate.window.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(-statusHeight);
        make.height.mas_equalTo(WS(230));
    }];
    
    UIButton *backNavBtn = [[UIButton alloc]init];
    [backNavBtn setImage:UTONImage(@"navigationBack_white") forState:UIControlStateNormal];
    [backNavBtn addTarget:self action:@selector(backnavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backNavBtn];
    [backNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(WS(30));
        make.left.mas_equalTo(WS(12));
        make.top.mas_equalTo(WS(34));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"开通会员";
    titleLabel.textColor = kColorWhiteColor;
    titleLabel.font = kLabelSize15;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(WS(37));
    }];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIButton *rightBtnOne = [[UIButton alloc]init];
    [rightBtnOne setImage:UTONImage(@"close") forState:UIControlStateNormal];
    [self.view addSubview:rightBtnOne];
    [rightBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(38));
        make.right.mas_equalTo(-WS(13));
        make.width.height.mas_equalTo(WS(19));
    }];
    UIButton *rightBtnTwo = [[UIButton alloc]init];
    [rightBtnTwo setImage:UTONImage(@"more") forState:UIControlStateNormal];
    [self.view addSubview:rightBtnTwo];
    [rightBtnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(38));
        make.right.mas_equalTo(rightBtnOne.mas_left).offset(-WS(20));
        make.width.height.mas_equalTo(WS(20));
    }];
}

- (void)creatUI{
    UIImageView *infoBackImage = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2143")];
    [self.view addSubview:infoBackImage];
    [infoBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(90));
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(88));
    }];
    self.headerImageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
    [infoBackImage addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.top.mas_equalTo(WS(23));
        make.width.height.mas_equalTo(WS(44));
    }];
    self.userNameLab = [[UILabel alloc]init];
    self.userNameLab.text = @"我是黄蓉";
    self.userNameLab.font = kLabelSize15;
    self.userNameLab.textColor = kColorWhiteColor;
    [infoBackImage addSubview:self.userNameLab];
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(14));
        make.height.mas_equalTo(WS(22));
        make.top.mas_equalTo(WS(24));
    }];
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.text = @"会员有效期：2099.09.09";
    self.timeLab.font = kLabelSize12;
    self.timeLab.textColor = UIColorFromRGB(0xFFFFFF);
    [infoBackImage addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(14));
        make.height.mas_equalTo(WS(15));
        make.top.mas_equalTo(self.userNameLab.mas_bottom).offset(WS(4));
    }];
    self.vipImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Frame_674")];
    [infoBackImage addSubview:self.vipImageView];
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(infoBackImage.mas_centerY);
        make.right.mas_equalTo(-WS(16));
        make.width.mas_equalTo(WS(36));
        make.height.mas_equalTo(WS(18));
    }];
    
    UIImageView *whiteBackImage = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2144")];
    [self.view addSubview:whiteBackImage];
    [whiteBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(infoBackImage.mas_bottom);
        make.height.mas_equalTo(WS(125));
    }];
    UILabel *rechargeLab = [[UILabel alloc]init];
    rechargeLab.font = kLabelSize15;
    rechargeLab.text = @"会员充值";
    rechargeLab.textColor = kColorBlackColor;
    [self.view addSubview:rechargeLab];
    [rechargeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.top.mas_equalTo(whiteBackImage.mas_top).offset(WS(32));
    }];
    self.priceButtons = [[NSMutableArray alloc]init];
    NSArray *mouthAry = @[@"1个月",@"3个月",@"12个月"];
    self.priceAry = @[@"10",@"30",@"120"];
    for (int i = 0; i < 3; i++) {
        UIButton *openVipBtn = [[UIButton alloc]init];
        openVipBtn.selected = YES;
        if (i == 0) {
            [openVipBtn setBackgroundImage:UTONImage(@"openVipImageOrange") forState:UIControlStateNormal];
        }else{
            [openVipBtn setBackgroundImage:UTONImage(@"openVipImageWhite") forState:UIControlStateNormal];
        }
        [openVipBtn addTarget:self action:@selector(openVipPriceAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:openVipBtn];
        [openVipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(WS(126));
            make.width.mas_equalTo(WS(109));
            make.top.mas_equalTo(rechargeLab.mas_bottom).offset(WS(16));
            make.left.mas_equalTo(WS(16)+WS(109)*i+(mScreenWidth-359)/2*i);
        }];
        [self.priceButtons addObject:openVipBtn];
        UILabel *mouthLab = [[UILabel alloc]init];
        mouthLab.text = mouthAry[i];
        mouthLab.font = kLabelSize14;
        mouthLab.textColor = kColorBlackColor;
        [openVipBtn addSubview:mouthLab];
        [mouthLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(WS(20));
            make.centerX.mas_equalTo(openVipBtn.mas_centerX);
            make.top.mas_equalTo(WS(32));
        }];
        UILabel *priceLab = [[UILabel alloc]init];
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",self.priceAry[i]] attributes:@{NSFontAttributeName:kLabelSize18}];
        NSRange range1=[[hintString string]rangeOfString:@"¥"];
        [hintString addAttribute:NSFontAttributeName value:kLabelSize12 range:range1];
        priceLab.attributedText = hintString;
        priceLab.textColor = UIColorFromRGB(0xD89A58);
        [openVipBtn addSubview:priceLab];
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(WS(20));
            make.centerX.mas_equalTo(openVipBtn.mas_centerX);
            make.top.mas_equalTo(mouthLab.mas_bottom).offset(WS(8));
        }];
    }
    self.openVipBtn = [[UIButton alloc]init];
    [self.openVipBtn setBackgroundImage:UTONImage(@"openVipBtnImage") forState:UIControlStateNormal];
    [self.openVipBtn setTitle:@"¥10 立即开通" forState:UIControlStateNormal];
    [self.openVipBtn setTitleColor:kColorBlackColor forState:UIControlStateNormal];
    self.openVipBtn.titleLabel.font = kLabelSize15;
    [self.openVipBtn addTarget:self action:@selector(openVipBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.openVipBtn];
    [self.openVipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.top.mas_equalTo(rechargeLab.mas_bottom).offset(WS(174));
        make.height.mas_equalTo(WS(48));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.openVipBtn.mas_bottom).offset(WS(32));
        make.height.mas_equalTo(WS(10));
    }];
    UILabel *ruleLab = [[UILabel alloc]init];
    ruleLab.text = @"会员规则";
    ruleLab.textColor = kColorBlackColor;
    ruleLab.font = kLabelSize17;
    [self.view addSubview:ruleLab];
    [ruleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.top.mas_equalTo(lineView.mas_bottom).offset(WS(20));
        make.height.mas_equalTo(WS(20));
    }];
    UITextView *ruleTextView = [[UITextView alloc]init];
    ruleTextView.textColor = UIColorFromRGB(0x696C7A);
    ruleTextView.font = kLabelSize14;
    ruleTextView.text = @"回到过去，重写历史，是“异世界”的一大主题。 体验过去的时空，甚至以“未来人”的身份试图扭转历史发展的趋势，这种关于过去的想象早已不新鲜，但却依然经久不衰。 早在1889年，马克吐温就写成了《康州美国佬在亚瑟王朝》一书，至今被视为“穿越小说”的鼻祖；十几年前的国内电视业，《寻秦记》《宫》《步步惊心》以及《神话》等穿越剧如雨后春笋般出现在荧屏之上";
    [self.view addSubview:ruleTextView];
    [ruleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-WS(16));
        make.top.mas_equalTo(ruleLab.mas_bottom).offset(WS(16));
    }];
    
}

- (void)openVipPriceAction:(UIButton *)btn{
    for (UIButton *button in self.priceButtons) {
        if ([self.priceButtons indexOfObject:button] == [self.priceButtons indexOfObject:btn]) {
            [button setBackgroundImage:UTONImage(@"openVipImageOrange") forState:UIControlStateNormal];
            button.selected = true;
            
            [self.openVipBtn setTitle:[NSString stringWithFormat:@"¥%@ 立即开通",self.priceAry[[self.priceButtons indexOfObject:btn]]] forState:UIControlStateNormal];
        }else{
            [button setBackgroundImage:UTONImage(@"openVipImageWhite") forState:UIControlStateNormal];
            button.selected = false;
        }
    }
}

- (void)openVipBtnAction{
    
}

- (void)backnavBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
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
