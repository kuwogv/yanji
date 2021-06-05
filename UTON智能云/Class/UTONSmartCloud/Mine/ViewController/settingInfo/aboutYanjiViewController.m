//
//  aboutYanjiViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/26.
//

#import "aboutYanjiViewController.h"

@interface aboutYanjiViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation aboutYanjiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"关于研集";
    
    [self creatUI];
}

- (void)creatUI{
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2357")];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(100);
        make.width.height.mas_equalTo(WS(100));
    }];
    UITableView *aboutTableView = [[UITableView alloc]init];
    aboutTableView.delegate = self;
    aboutTableView.dataSource = self;
    aboutTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    aboutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:aboutTableView];
    [aboutTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(WS(45));
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mineTableViewCell"];
    }
    NSArray *textAry = @[@"研集介绍",@"用户协议",@"用户个人保护政策"];
    cell.textLabel.font = kLabelSize15;
    cell.textLabel.text = textAry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = kColorWhiteColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
