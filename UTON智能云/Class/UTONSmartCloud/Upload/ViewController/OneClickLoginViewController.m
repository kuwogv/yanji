//
//  OneClickLoginViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/27.
//

#import "OneClickLoginViewController.h"

@interface OneClickLoginViewController ()
@property (nonatomic,strong) UILabel *phoneLab;
@end

@implementation OneClickLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhiteColor;
    [self creatUI];
    
}

- (void)creatUI{
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Frame_637")];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(WS(158));
        make.width.height.mas_equalTo(WS(102));
    }];
    self.phoneLab = [[UILabel alloc]init];
    self.phoneLab.text = @"130****2291";
    self.phoneLab.textColor = kColorBlackColor;
    self.phoneLab.font = kLabelSize18;
    [self.view addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(WS(20));
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(WS(30));
    }];
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setBackgroundImage:UTONImage(@"loginBtnImage") forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginApp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(32));
        make.right.mas_equalTo(-WS(32));
        make.top.mas_equalTo(self.phoneLab.mas_bottom).offset(WS(40));
        make.height.mas_equalTo(WS(44));
    }];
    
    UIButton *xieyiBtn = [[UIButton alloc]init];
    [xieyiBtn setBackgroundImage:UTONImage(@"Group_1357") forState:UIControlStateNormal];
    [xieyiBtn addTarget:self action:@selector(xieyibtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xieyiBtn];
    [xieyiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(10);
        make.height.mas_equalTo(WS(15));
        make.width.mas_equalTo(WS(155));
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(WS(20));
    }];
    
    UIButton *agreeBtn = [[UIButton alloc]init];
    [agreeBtn setImage:UTONImage(@"btnUnselImage") forState:UIControlStateNormal];
    agreeBtn.selected = NO;
    [agreeBtn addTarget:self action:@selector(agreeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreeBtn];
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(WS(20));
        make.width.height.mas_equalTo(WS(15));
        make.right.mas_equalTo(xieyiBtn.mas_left).offset(-WS(10));
    }];
}

- (void)loginApp{
    if ([self.loginDelegate respondsToSelector:@selector(loginAppToHomePage:)]) {
        [self.loginDelegate loginAppToHomePage:self];
    }
}

- (void)agreeBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setImage:UTONImage(@"btnSelImage") forState:UIControlStateNormal];
    }else{
        [btn setImage:UTONImage(@"btnUnselImage") forState:UIControlStateNormal];
    }
    
}

- (void)xieyibtnAction{
    
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
