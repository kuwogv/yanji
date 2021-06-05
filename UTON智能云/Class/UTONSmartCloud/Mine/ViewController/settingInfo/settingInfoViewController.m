//
//  settingInfoViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/26.
//

#import "settingInfoViewController.h"
#import "aboutYanjiViewController.h"
#import "editUserInfoViewController.h"

@interface settingInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation settingInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"设置";
    self.view.backgroundColor = UIColorFromRGB(0xF7F8FA);
    
    UITableView *settingTableView = [[UITableView alloc]init];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    settingTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    settingTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    settingTableView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    settingTableView.scrollEnabled = NO;
    [self.view addSubview:settingTableView];
    [settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    UIButton *logoutBtn = [[UIButton alloc]init];
    [logoutBtn setBackgroundImage:UTONImage(@"logoutBtn") forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WS(40));
        make.bottom.mas_equalTo(-WS(46));
        make.left.mas_equalTo(WS(83));
        make.right.mas_equalTo(-WS(83));
    }];
}

- (void)logoutBtnAction{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mineTableViewCell"];
    }
    NSArray *textAry = @[@"个人资料编辑",@"关于研集",@"清除缓存"];
    cell.textLabel.font = kLabelSize15;
    cell.textLabel.text = textAry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==2) {
        cell.detailTextLabel.text = @"108M";
        cell.detailTextLabel.font = kLabelSize14;
    }
    cell.backgroundColor = kColorWhiteColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        editUserInfoViewController *vc = [[editUserInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==1) {
        aboutYanjiViewController *vc = [[aboutYanjiViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==2) {
        
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
