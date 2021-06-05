//
//  YanJiMineViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/25.
//

#import "YanJiMineViewController.h"
#import "myCourseListViewController.h"
#import "openVipViewController.h"
#import "settingInfoViewController.h"
#import "appleSeniorViewController.h"
#import "myConsultViewController.h"
#import "myInvitationViewController.h"
#import "myStoreViewController.h"
#import "editUserInfoViewController.h"

@interface YanJiMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)UILabel *nameLab;
@property (nonatomic,strong)UIButton *userinfoBtn;
@property (nonatomic,strong)UIButton *vipBtn;
@end

@implementation YanJiMineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    };
    self.navigationController.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorWhiteColor;
    [self creatUI];
}

- (void)creatUI{
    UIImageView *topBackImage = [[UIImageView alloc]init];
    topBackImage.alpha = 0.76;
    topBackImage.layer.backgroundColor = kColorWhiteColor.CGColor;
    [self.view addSubview:topBackImage];
    [topBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(WS(264));
    }];
    UIImageView *bottomBackImage = [[UIImageView alloc]initWithImage:UTONImage(@"Mask_Group")];
    [self.view addSubview:bottomBackImage];
    [bottomBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(WS(40));
        make.bottom.mas_equalTo(topBackImage.mas_bottom);
    }];
    self.headerImageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
    [self.view addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.top.mas_equalTo(WS(101));
        make.width.height.mas_equalTo(WS(64));
    }];
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"用户名";
    self.nameLab.textColor = kColorBlackColor;
    self.nameLab.font = kLabelSize17;
    [self.view addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(12));
        make.height.mas_equalTo(WS(20));
        make.top.mas_equalTo(WS(108));
    }];
    self.userinfoBtn = [[UIButton alloc]init];
    [self.userinfoBtn setTitle:@"查看并编辑个人资料" forState:UIControlStateNormal];
    [self.userinfoBtn setTitleColor:UIColorFromRGB(0x696C7A) forState:UIControlStateNormal];
    self.userinfoBtn.titleLabel.font = kLabelSize12;
    [self.userinfoBtn addTarget:self action:@selector(userinfoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.userinfoBtn];
    [self.userinfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(12));
        make.height.mas_equalTo(WS(20));
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(WS(8));
    }];
    
    self.vipBtn = [[UIButton alloc]init];
    [self.vipBtn setBackgroundImage:UTONImage(@"openVip") forState:UIControlStateNormal];
    [self.vipBtn addTarget:self action:@selector(openVip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.vipBtn];
    [self.vipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(topBackImage.mas_bottom);
        make.height.mas_equalTo(WS(78));
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
    }];
    
    NSArray *titleAry = @[@"我的课程",@"我的咨询",@"我的帖子",@"收藏分数线"];
    NSArray *numAry = @[@"10",@"5",@"29",@"0"];
    for (int i = 0; i < titleAry.count; i++) {
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = titleAry[i];
        titleLab.textColor = UIColorFromRGB(0x696C7A);
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:(12)];
        [self.view addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WS(25)+WS(60)*i+(mScreenWidth-280)/4*i);
            make.top.mas_equalTo(topBackImage.mas_bottom).offset(WS(60));
            make.width.mas_equalTo(WS(60));
            make.height.mas_equalTo(WS(15));
        }];
        
        UILabel *numLab = [[UILabel alloc]init];
        numLab.text = numAry[i];
        numLab.font = [UIFont fontWithName:@"D-DINCondensed-DINCondensed-Bold" size:(20)];
        numLab.textColor = kColorBlackColor;
        numLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:numLab];
        [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(titleLab.mas_centerX);
            make.bottom.mas_equalTo(titleLab.mas_top).offset(-WS(8));
            make.height.mas_equalTo(WS(24));
        }];
        UIButton *clickBtn = [[UIButton alloc]init];
        clickBtn.backgroundColor = kColorClearColor;
        clickBtn.tag = 100+i;
        [clickBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WS(25)+WS(60)*i+(mScreenWidth-280)/4*i);
            make.top.mas_equalTo(topBackImage.mas_bottom).offset(WS(28));
            make.width.mas_equalTo(WS(60));
            make.height.mas_equalTo(WS(47));
        }];
    }
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xEBECF0);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(17));
        make.right.mas_equalTo(-WS(15));
        make.top.mas_equalTo(topBackImage.mas_bottom).offset(WS(100));
        make.height.mas_equalTo(0.8);
    }];
    
    UITableView *mineTableView = [[UITableView alloc]init];
    mineTableView.delegate = self;
    mineTableView.dataSource = self;
    mineTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:mineTableView];
    [mineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(lineView.mas_bottom).offset(WS(10));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mineTableViewCell"];
    }
    NSArray *textAry = @[@"考研志愿身份卡",@"申请成为学长",@"设置"];
    NSArray *imageAry = @[@"Message",@"Paper",@"Filter"];
    cell.textLabel.font = kLabelSize14;
    cell.textLabel.text = textAry[indexPath.row];
    cell.imageView.image = UTONImage(imageAry[indexPath.row]);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        settingInfoViewController *vc = [[settingInfoViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==1) {
        appleSeniorViewController *vc = [[appleSeniorViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)userinfoBtnAction{
    editUserInfoViewController *vc = [[editUserInfoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)openVip{
    openVipViewController *vc = [[openVipViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnAction:(UIButton *)btn{
    if (btn.tag==100) {
        myCourseListViewController *vc = [[myCourseListViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==101){
        myConsultViewController *vc = [[myConsultViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==102){
        myInvitationViewController *vc = [[myInvitationViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==103){
        myStoreViewController *vc = [[myStoreViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
