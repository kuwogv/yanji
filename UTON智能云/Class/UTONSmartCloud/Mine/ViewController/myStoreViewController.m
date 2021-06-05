//
//  myStoreViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/6/2.
//

#import "myStoreViewController.h"
#import "myStoreCell.h"

@interface myStoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation myStoreViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"收藏";
    
    UITableView *storeTableView = [[UITableView alloc]init];
    storeTableView.delegate = self;
    storeTableView.dataSource = self;
    storeTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [storeTableView registerClass:[myStoreCell class] forCellReuseIdentifier:@"myStoreCell"];
    storeTableView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    storeTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:storeTableView];
    [storeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myStoreCell"];
    if (!cell) {
        cell = [[myStoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myStoreCell"];
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WS(98);
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
