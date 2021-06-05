//
//  studyRoomViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/6/2.
//

#import "studyRoomViewController.h"
#import "roomRankViewController.h"
#import "studyRoomCell.h"
#import "setUpStudyRoomVC.h"
#import "studyRoomDetailVC.h"

@interface studyRoomViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>{
    UISearchBar *searchBar;
}
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UICollectionView *rechargeCollectionView;
@end

@implementation studyRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)creatUI{
    UIImageView *topBackImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2303")];
    topBackImageView.userInteractionEnabled = YES;
    [self.view addSubview:topBackImageView];
    [topBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(WS(104));
        make.top.mas_equalTo(WS(5));
    }];
    [topBackImageView addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(25));
        make.left.mas_equalTo(WS(32));
        make.width.height.mas_equalTo(WS(40));
    }];
    [topBackImageView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WS(25));
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(7));
        make.height.mas_equalTo(WS(22));
    }];
    [topBackImageView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLab.mas_bottom);
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(WS(7));
        make.height.mas_equalTo(WS(14));
    }];
    UIButton *rankBtn = [[UIButton alloc]init];
    [rankBtn setBackgroundImage:UTONImage(@"rankBtnImage") forState:UIControlStateNormal];
    [rankBtn addTarget:self action:@selector(rankBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topBackImageView addSubview:rankBtn];
    [rankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headerImageView.mas_centerY);
        make.right.mas_equalTo(-WS(32));
        make.width.mas_equalTo(WS(69));
        make.height.mas_equalTo(WS(24));
    }];
    
    UIButton *setRoomBtn = [[UIButton alloc]init];
    [setRoomBtn setBackgroundImage:UTONImage(@"setRoomBtnImage") forState:UIControlStateNormal];
    [setRoomBtn addTarget:self action:@selector(setStudyRoom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setRoomBtn];
    [setRoomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WS(32));
        make.top.mas_equalTo(topBackImageView.mas_bottom).offset(WS(2));
        make.width.mas_equalTo(WS(105));
        make.right.mas_equalTo(-WS(16));
    }];
    
    searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = @"可以搜索ID查找自习室";
    if (@available(iOS 13.0, *)) {
        searchBar.searchTextField.font = kLabelSize14;
    } else {
        // Fallback on earlier versions
    }
    searchBar.delegate = self;
    searchBar.barTintColor = kColorWhiteColor;
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(6));
        make.height.mas_equalTo(WS(36));
        make.top.mas_equalTo(topBackImageView.mas_bottom);
        make.right.mas_equalTo(setRoomBtn.mas_left).offset(-WS(5));
    }];
    [self.view addSubview:self.rechargeCollectionView];
    [self.rechargeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(searchBar.mas_bottom).offset(WS(12));
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    studyRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"studyRoomCell" forIndexPath:indexPath];
    NSArray *backImageAry = @[@"roombackImageOne",@"roombackImageTwo",@"roombackImageThree",@"roombackImageFour",@"roombackImageOne",@"roombackImageTwo"];
    NSArray *btnImageAry = @[@"idbtnImageOne",@"idbtnImageOne",@"idbtnImageTwo",@"idbtnImageTwo",@"",@""];
    NSArray *btnStrAry = @[@"ID:123456",@"ID:123456",@"ID:123456",@"ID:123456",@"ID:123456",@"ID:123456"];
    cell.backImageView.image = UTONImage(backImageAry[indexPath.row]);
    [cell.idBtn setImage:UTONImage(btnImageAry[indexPath.row]) forState:UIControlStateNormal];
    [cell.idBtn setTitle:btnStrAry[indexPath.row] forState:UIControlStateNormal];
    [cell.idBtn setTitleColor:UIColorFromRGB(0x696C7A) forState:UIControlStateNormal];
    cell.idBtn.titleLabel.font = kLabelSize12;
    cell.idBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    cell.nameLab.text = @"8~23 全天学习每日稳定";
    cell.studyNumLab.text = @"6人正在学习";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    studyRoomDetailVC *vc = [[studyRoomDetailVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rankBtnAction{
    roomRankViewController *vc = [[roomRankViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setStudyRoom{
    setUpStudyRoomVC *vc = [[setUpStudyRoomVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithImage:UTONImage(@"commandUserHeader")];
    }
    return _headerImageView;
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"嘟嘟嘟";
        _nameLab.textColor = kColorBlackColor;
        _nameLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    }
    return _nameLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"累计学习 0.00h";
        _timeLab.textColor = UIColorFromRGB(0xA7A6B3);
        _timeLab.font = kLabelSize13;
    }
    return _timeLab;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([searchBar becomeFirstResponder]) {
        [searchBar resignFirstResponder];
    }
    
}

- (UICollectionView *)rechargeCollectionView{
    if (!_rechargeCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(5, 16, 5, 16);
        layout.minimumLineSpacing = 5;
        layout.itemSize = CGSizeMake((mScreenWidth-32-10)/2 , 176);
        _rechargeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _rechargeCollectionView.showsVerticalScrollIndicator = YES;
        _rechargeCollectionView.backgroundColor = kColorWhiteColor;
        _rechargeCollectionView.delegate = self;
        _rechargeCollectionView.dataSource = self;
        _rechargeCollectionView.pagingEnabled = YES;
        [_rechargeCollectionView registerClass:[studyRoomCell class] forCellWithReuseIdentifier:@"studyRoomCell"];
    }
    return _rechargeCollectionView;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
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
