//
//  applyResultViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/29.
//

#import "applyResultViewController.h"

@interface applyResultViewController (){
    UIImageView *resultImageView;
    UILabel *resultLab;
    UIButton *resultBtn;
}

@end

@implementation applyResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)creatUI{
    resultImageView = [[UIImageView alloc]initWithImage:UTONImage(@"inReviewImage")];
    [self.view addSubview:resultImageView];
    [resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(WS(160));
        make.top.mas_equalTo(113);
    }];
    resultLab = [[UILabel alloc]init];
    resultLab.text = @"审核中，请稍后来看";
    resultLab.textColor = kColorBlackColor;
    resultLab.font = kLabelSize17;
    [self.view addSubview:resultLab];
    [resultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(resultImageView.mas_bottom).offset(WS(20));
        make.height.mas_equalTo(WS(20));
    }];
    resultBtn = [[UIButton alloc]init];
    resultBtn.layer.cornerRadius = 21;
    resultBtn.backgroundColor = UIColorFromRGB(0xFF6D00);
    [resultBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [resultBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    resultBtn.titleLabel.font = kLabelSize14;
    [resultBtn addTarget:self action:@selector(resultBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resultBtn];
    [resultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(resultLab.mas_bottom).offset(WS(143));
        make.height.mas_equalTo(WS(44));
        make.left.mas_equalTo(WS(73));
        make.right.mas_equalTo(-WS(73));
    }];
}

- (void)resultBtnAction{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];
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
