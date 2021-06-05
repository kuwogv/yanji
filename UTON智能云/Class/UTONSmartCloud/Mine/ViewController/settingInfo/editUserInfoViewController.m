//
//  editUserInfoViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/29.
//

#import "editUserInfoViewController.h"

@interface editUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation editUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"个人资料编辑";
    [self creatUI];
}

- (void)creatUI{
    UITableView *editTableView = [[UITableView alloc]init];
    editTableView.delegate = self;
    editTableView.dataSource = self;
    editTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    editTableView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    [self.view addSubview:editTableView];
    [editTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"editTableViewCell"];
    }
    NSArray *titleAryOne = @[@[@"头像",@"昵称",@"本科院校",@"本科专业",@"目前身份"],@[@"备考状态",@"备考届次",@"意向学校",@"意向专业"]];
    
    cell.textLabel.font = kLabelSize14;
    cell.textLabel.text = titleAryOne[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, WS(45))];
    headerView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 44)];
    titleLab.textColor = UIColorFromRGB(0x696C7A);
    titleLab.font = kLabelSize12;
    if (section==0) {
        titleLab.text = @"关于我";
    }else{
        titleLab.text = @"关于考研";
    }
    [headerView addSubview:titleLab];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return WS(45);
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
