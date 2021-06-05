//
//  myConsultViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/31.
//

#import "myConsultViewController.h"
#import "myConsultCell.h"

@interface myConsultViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *myConsultTableView;
@end

@implementation myConsultViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"我的咨询";
    self.view.backgroundColor = UIColorFromRGB(0xF7F8FA);
    [self creatUI];
}

- (void)creatUI{
    self.myConsultTableView = [[UITableView alloc]init];
    self.myConsultTableView.delegate = self;
    self.myConsultTableView.dataSource = self;
    self.myConsultTableView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    self.myConsultTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.myConsultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myConsultTableView registerClass:[myConsultCell class] forCellReuseIdentifier:@"myConsultCell"];
    [self.view addSubview:self.myConsultTableView];
    [self.myConsultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myConsultCell"];
    if (!cell) {
        cell = [[myConsultCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myConsultCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==2) {
        cell.consultBtn.backgroundColor = UIColorFromRGB(0xF2F2F5);
        [cell.consultBtn setTitle:@"重新咨询" forState:UIControlStateNormal];
        [cell.consultBtn setTitleColor:kColorBlackColor forState:UIControlStateNormal];
        cell.timeLab.text = @"剩余00:00";
        cell.timeLab.textColor = UIColorFromRGB(0xA7A6B3);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WS(96);
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
