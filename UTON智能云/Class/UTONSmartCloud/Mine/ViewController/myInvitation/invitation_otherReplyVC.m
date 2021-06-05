//
//  invitation_otherReplyVC.m
//  UTON智能云
//
//  Created by UTON on 2021/6/1.
//

#import "invitation_otherReplyVC.h"
#import "otherReplyCell.h"

@interface invitation_otherReplyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *replyTableView;
@end

@implementation invitation_otherReplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xF7F8FA);
    
    [self creatUI];
}

- (void)creatUI{
    self.replyTableView = [[UITableView alloc]init];
    self.replyTableView.delegate = self;
    self.replyTableView.dataSource = self;
    self.replyTableView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    self.replyTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.replyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.replyTableView registerClass:[otherReplyCell class] forCellReuseIdentifier:@"otherReplyCell"];
    [self.view addSubview:self.replyTableView];
    [self.replyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    otherReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherReplyCell"];
    if (!cell) {
        cell = [[otherReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"otherReplyCell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WS(196);
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
