//
//  setUpStudyRoomVC.m
//  UTON智能云
//
//  Created by UTON on 2021/6/3.
//

#import "setUpStudyRoomVC.h"

@interface setUpStudyRoomVC ()<UITextFieldDelegate>
@property (nonatomic,strong)UTONTextField *inputTextField;
@property (nonatomic,strong)UILabel *numLab;
@property (nonatomic,strong)UTONTextField *pwTextField;
@end

@implementation setUpStudyRoomVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"创建自习室";
    [self creatUI];
}

- (void)creatUI{
    self.inputTextField = [[UTONTextField alloc]init];
    self.inputTextField.lineColor = UIColorFromRGB(0xEBECF0);
    self.inputTextField.delegate = self;
    self.inputTextField.placeholder = @"输入自习室名称";
    self.inputTextField.font = kLabelSize16;
    [self.view addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(20));
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(40));
    }];
    UILabel *numberLab = [[UILabel alloc]init];
    numberLab.text = @"限制人数";
    numberLab.textColor = UIColorFromRGB(0x696C7A);
    numberLab.font = kLabelSize14;
    [self.view addSubview:numberLab];
    [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.top.mas_equalTo(self.inputTextField.mas_bottom).offset(WS(15));
        make.height.mas_equalTo(WS(20));
    }];
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setImage:UTONImage(@"addNumBtnImage") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAndCutNum:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = 102;
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(numberLab.mas_centerY);
        make.width.height.mas_equalTo(WS(22));
        make.right.mas_equalTo(-WS(16));
    }];
    self.numLab = [[UILabel alloc]init];
    self.numLab.textColor = kColorBlackColor;
    self.numLab.font = kLabelSize15;
    self.numLab.text = @"1";
    self.numLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(numberLab.mas_centerY);
        make.height.mas_equalTo(WS(20));
        make.width.mas_equalTo(WS(25));
        make.right.mas_equalTo(addBtn.mas_left).offset(-WS(10));
    }];
    UIButton *cutBtn = [[UIButton alloc]init];
    [cutBtn setImage:UTONImage(@"cutNumBtnImage") forState:UIControlStateNormal];
    [cutBtn addTarget:self action:@selector(addAndCutNum:) forControlEvents:UIControlEventTouchUpInside];
    cutBtn.tag = 101;
    [self.view addSubview:cutBtn];
    [cutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(numberLab.mas_centerY);
        make.width.height.mas_equalTo(WS(22));
        make.right.mas_equalTo(self.numLab.mas_left).offset(-WS(10));
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xEBECF0);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(numberLab.mas_bottom).offset(WS(15));
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(0.5);
    }];
    UILabel *simiLab = [[UILabel alloc]init];
    simiLab.text = @"私密";
    simiLab.textColor = UIColorFromRGB(0x696C7A);
    simiLab.font = kLabelSize14;
    [self.view addSubview:simiLab];
    [simiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.top.mas_equalTo(lineView.mas_bottom).offset(WS(15));
        make.height.mas_equalTo(WS(20));
    }];
    UISwitch *allowSwitch = [[UISwitch alloc]init];
    allowSwitch.tintColor = UIColorFromRGB(0xFF6D00);
    allowSwitch.onTintColor = UIColorFromRGB(0xFF6D00);
    [allowSwitch setOn:YES];
    [allowSwitch addTarget:self action:@selector(allowSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allowSwitch];
    [allowSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-WS(25));
        make.top.mas_equalTo(lineView.mas_bottom).offset(WS(10));
        make.height.mas_equalTo(WS(27));
        make.width.mas_equalTo(WS(50));
    }];
    UIView *lineViewTwo = [[UIView alloc]init];
    lineViewTwo.backgroundColor = UIColorFromRGB(0xEBECF0);
    [self.view addSubview:lineViewTwo];
    [lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(simiLab.mas_bottom).offset(WS(15));
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(0.5);
    }];
    UIView *passwordView = [[UIView alloc]init];
    passwordView.backgroundColor = kColorWhiteColor;
    [self.view addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(WS(50));
        make.top.mas_equalTo(lineViewTwo.mas_bottom);
    }];
    UILabel *simiLab2 = [[UILabel alloc]init];
    simiLab2.text = @"私密";
    simiLab2.textColor = UIColorFromRGB(0x696C7A);
    simiLab2.font = kLabelSize14;
    [passwordView addSubview:simiLab2];
    [simiLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.top.mas_equalTo(lineViewTwo.mas_bottom).offset(WS(15));
        make.height.mas_equalTo(WS(20));
    }];
    self.pwTextField = [[UTONTextField alloc]init];
    self.pwTextField.lineColor = kColorWhiteColor;
    self.pwTextField.delegate = self;
    self.pwTextField.placeholder = @"请输入房间密码";
    self.pwTextField.font = kLabelSize14;
    [passwordView addSubview:self.pwTextField];
    [self.pwTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(10));
        make.width.mas_equalTo(WS(100));
        make.right.mas_equalTo(-WS(16));
        make.height.mas_equalTo(WS(40));
    }];
    UIButton *setBtn = [[UIButton alloc]init];
    setBtn.backgroundColor = UIColorFromRGB(0xFF6D00);
    setBtn.layer.cornerRadius = 23;
    [setBtn setTitle:@"创建" forState:UIControlStateNormal];
    [setBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    setBtn.titleLabel.font = kLabelSize15;
    [self.view addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WS(44));
        make.left.mas_equalTo(WS(72));
        make.right.mas_equalTo(-WS(72));
        make.top.mas_equalTo(passwordView.mas_bottom).offset(WS(40));
    }];
}

- (void)allowSwitchAction:(UISwitch *)allowSwitch{
    if (allowSwitch.isOn==NO) {
        
    }else{
        
    }
}

- (void)addAndCutNum:(UIButton *)btn{
    int num = [self.numLab.text intValue];
    if (btn.tag==101) {
        if (num == 1) {
            return;
        }else{
            num--;
        }
    }else{
        num++;
    }
    self.numLab.text = [NSString stringWithFormat:@"%d",num];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.inputTextField becomeFirstResponder]) {
        [self.inputTextField resignFirstResponder];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
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
