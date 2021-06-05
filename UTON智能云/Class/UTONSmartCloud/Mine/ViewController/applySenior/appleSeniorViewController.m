//
//  appleSeniorViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/29.
//

#import "appleSeniorViewController.h"
#import "appleSeniorCell.h"
#import "applyResultViewController.h"

@interface appleSeniorViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation appleSeniorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF7F8FA);
    [self creatUI];
}

- (void)creatUI{
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:UTONImage(@"appleSeniorBackImage")];
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(WS(260));
    }];
    UIButton *goBackBtn = [[UIButton alloc]init];
    [goBackBtn setImage:UTONImage(@"navigationBack") forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(goBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:goBackBtn];
    [goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.width.height.mas_equalTo(WS(20));
        make.top.mas_equalTo(WS(30));
    }];
    
    UIImageView *seniorImageView = [[UIImageView alloc]initWithImage:UTONImage(@"seniorImage")];
    [backImageView addSubview:seniorImageView];
    [seniorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-WS(32));
        make.top.mas_equalTo(WS(80));
        make.width.height.mas_equalTo(WS(124));
    }];
    UILabel *applyLab = [[UILabel alloc]init];
    applyLab.text = @"申请学长";
    applyLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    applyLab.textColor = kColorBlackColor;
    [backImageView addSubview:applyLab];
    [applyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(128));
        make.left.mas_equalTo(WS(32));
        make.height.mas_equalTo(WS(20));
    }];
    UILabel *tipsLab = [[UILabel alloc]init];
    tipsLab.text = @"请填写相关信息";
    tipsLab.textColor = UIColorFromRGB(0xA7A6B3);
    tipsLab.font = kLabelSize13;
    [backImageView addSubview:tipsLab];
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(32));
        make.top.mas_equalTo(applyLab.mas_bottom).offset(WS(10));
        make.height.mas_equalTo(WS(20));
    }];
    
    UITableView *applyTableView = [[UITableView alloc]init];
    applyTableView.delegate = self;
    applyTableView.dataSource = self;
    applyTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    applyTableView.backgroundColor = kColorWhiteColor;
    applyTableView.layer.cornerRadius = 10;
    [applyTableView registerClass:[appleSeniorCell class] forCellReuseIdentifier:@"appleSeniorCell"];
    applyTableView.scrollEnabled = NO;
    [self.view addSubview:applyTableView];
    [applyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(52)*6);
        make.top.mas_equalTo(seniorImageView.mas_bottom);
    }];
    
    UIButton *applyBtn = [[UIButton alloc]init];
    applyBtn.backgroundColor = UIColorFromRGB(0xFF6D00);
    applyBtn.layer.cornerRadius = 23;
    [applyBtn setTitle:@"申请" forState:UIControlStateNormal];
    [applyBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    applyBtn.titleLabel.font = kLabelSize15;
    [applyBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(applyTableView.mas_bottom).offset(WS(40));
        make.height.mas_equalTo(WS(44));
        make.left.mas_equalTo(WS(73));
        make.right.mas_equalTo(-WS(73));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    appleSeniorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appleSeniorCell"];
    if (!cell) {
        cell = [[appleSeniorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"appleSeniorCell"];
    }
    NSArray *titleAry = @[@"学校",@"所学专业",@"本人的学号",@"您的名字",@"您的性别",@"手机号"];
    NSArray *placeHolderAry = @[@"填写你所在的学校",@"填写你所在的专业",@"填写自己的学号",@"填写您的名字",@"",@"填写手机号"];
    cell.leftLab.text = titleAry[indexPath.row];
    cell.inputTextField.delegate = self;
    cell.inputTextField.placeholder = placeHolderAry[indexPath.row];
    if (indexPath.row==4) {
        cell.boyBtn.hidden = NO;
        cell.girlBtn.hidden = NO;
        cell.inputTextField.hidden = YES;
    }else{
        cell.boyBtn.hidden = YES;
        cell.girlBtn.hidden = YES;
        cell.inputTextField.hidden = NO;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WS(52);
}

- (void)goBackBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)applyBtnAction{
    applyResultViewController *vc = [[applyResultViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//点击键盘以外区域收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if ([self.phoneTextField becomeFirstResponder]) {
//        [self.phoneTextField resignFirstResponder];
//    }
//    if ([self.codeTextField becomeFirstResponder]) {
//        [self.codeTextField resignFirstResponder];
//    }
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
