//
//  roomRankListVC.m
//  UTON智能云
//
//  Created by UTON on 2021/6/3.
//

#import "roomRankListVC.h"
#import "roomRankingCell.h"

@interface roomRankListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *rankingTableView;
@end

@implementation roomRankListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];//
}

- (void)creatUI{
    CGFloat topFloat;
    NSArray *paimingImageAry = @[@"rankingTwo",@"rankingOne",@"rankingThree"];
    for (int i = 0; i < 3; i++) {
        UIImageView *backImageView = [[UIImageView alloc]initWithImage:UTONImage(@"openVipImageWhite")];//
        [self.view addSubview:backImageView];
        if (i==1) {
            topFloat = WS(48);
        }else{
            topFloat = WS(67);
        }
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topFloat);
            make.height.mas_equalTo(151);
            make.width.mas_equalTo((mScreenWidth-WS(12))/3);
            make.left.mas_equalTo(WS(6)+(mScreenWidth-WS(12))/3*i);
        }];
        UIImageView *headerImageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
        [backImageView addSubview:headerImageView];
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backImageView.mas_centerX);
            make.width.height.mas_equalTo(WS(60));
            make.top.mas_equalTo(-WS(30));
        }];
        UIImageView *rankingImageView = [[UIImageView alloc]initWithImage:UTONImage(paimingImageAry[i])];
        [backImageView addSubview:rankingImageView];
        [rankingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backImageView.mas_centerX);
            make.width.height.mas_equalTo(WS(32));
            make.top.mas_equalTo(19);
        }];
        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.text = @"测试人名";
        nameLab.textColor = kColorBlackColor;
        nameLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        [backImageView addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backImageView.mas_centerX);
            make.height.mas_equalTo(WS(20));
            make.top.mas_equalTo(rankingImageView.mas_bottom).offset(WS(7));
        }];
        UILabel *schoolLab = [[UILabel alloc]init];
        schoolLab.text = @"某某大学";
        schoolLab.textColor = UIColorFromRGB(0xA7A6B3);
        schoolLab.font = kLabelSize12;
        [backImageView addSubview:schoolLab];
        [schoolLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backImageView.mas_centerX);
            make.height.mas_equalTo(WS(20));
            make.top.mas_equalTo(nameLab.mas_bottom).offset(WS(2));
        }];
        UILabel *timeLab = [[UILabel alloc]init];
        timeLab.textColor = UIColorFromRGB(0x696C7A);
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"120h" attributes:@{NSFontAttributeName:kLabelSize18}];
        NSRange range1=[[hintString string]rangeOfString:@"h"];
        [hintString addAttribute:NSFontAttributeName value:kLabelSize12 range:range1];
        timeLab.attributedText = hintString;
        [backImageView addSubview:timeLab];
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backImageView.mas_centerX);
            make.height.mas_equalTo(WS(20));
            make.top.mas_equalTo(schoolLab.mas_bottom).offset(WS(8));
        }];
    }
    self.rankingTableView = [[UITableView alloc]init];
    self.rankingTableView.delegate = self;
    self.rankingTableView.dataSource = self;
    self.rankingTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.rankingTableView registerClass:[roomRankingCell class] forCellReuseIdentifier:@"roomRankingCell"];
    self.rankingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.rankingTableView];
    [self.rankingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-WS(80));
        make.top.mas_equalTo(WS(210));
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = UIColorFromRGB(0xF7F8FA);
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(WS(80));
    }];
    UIImageView *bottomImageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
    [bottomView addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.width.height.mas_equalTo(WS(48));
        make.top.mas_equalTo(WS(10));
    }];
    UILabel *bottomLab = [[UILabel alloc]init];
    bottomLab.text = @"老人与海燕";
    bottomLab.textColor = kColorBlackColor;
    bottomLab.font = kLabelSize17;
    [bottomView addSubview:bottomLab];
    [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomImageView.mas_right).offset(WS(12));
        make.top.mas_equalTo(WS(22));
        make.height.mas_equalTo(WS(20));
    }];
    UILabel *bottomtimHourLab = [[UILabel alloc]init];
    bottomtimHourLab.textColor = UIColorFromRGB(0xFF6D00);
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"120h" attributes:@{NSFontAttributeName:kLabelSize18}];
    NSRange range1=[[hintString string]rangeOfString:@"h"];
    [hintString addAttribute:NSFontAttributeName value:kLabelSize12 range:range1];
    bottomtimHourLab.attributedText = hintString;
    [bottomView addSubview:bottomtimHourLab];
    [bottomtimHourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WS(24));
        make.right.mas_equalTo(-WS(32));
        make.top.mas_equalTo(WS(20));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    roomRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"roomRankingCell"];
    if (!cell) {
        cell = [[roomRankingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCourseListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = @[@"4",@"5",@"6"];
    cell.rankingLab.text = array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WS(88);
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
