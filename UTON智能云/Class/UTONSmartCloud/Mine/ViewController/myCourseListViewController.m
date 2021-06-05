//
//  myCourseListViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/26.
//

#import "myCourseListViewController.h"
#import "myCourseListCell.h"

@interface myCourseListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *courseListTableView;
@end

@implementation myCourseListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"课程列表";
    self.view.backgroundColor = UIColorFromRGB(0xF7F8FA);
    [self creatUI];
}

- (void)creatUI{
    self.courseListTableView = [[UITableView alloc]init];
    self.courseListTableView.delegate = self;
    self.courseListTableView.dataSource = self;
    self.courseListTableView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    self.courseListTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.courseListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.courseListTableView registerClass:[myCourseListCell class] forCellReuseIdentifier:@"myCourseListCell"];
    [self.view addSubview:self.courseListTableView];
    [self.courseListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCourseListCell"];
    if (!cell) {
        cell = [[myCourseListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCourseListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WS(146);
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
