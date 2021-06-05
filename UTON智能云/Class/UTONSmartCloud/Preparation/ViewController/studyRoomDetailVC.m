//
//  studyRoomDetailVC.m
//  UTON智能云
//
//  Created by UTON on 2021/6/5.
//

#import "studyRoomDetailVC.h"
#import "studyRoomDetailCell.h"

@interface studyRoomDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *roomCollectionView;
@end

@implementation studyRoomDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)creatUI{
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2327")];
    [self.view addSubview:backImageView];
    CGFloat statusBarHeight = 0.0f;
    if (@available(iOS 13, *)) {
        statusBarHeight = UIApplication.sharedApplication.delegate.window.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(-statusHeight);
        make.height.mas_equalTo(WS(230));
    }];
    
    UIButton *backNavBtn = [[UIButton alloc]init];
    [backNavBtn setImage:UTONImage(@"navigationBack_white") forState:UIControlStateNormal];
    [backNavBtn addTarget:self action:@selector(backnavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backNavBtn];
    [backNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(WS(30));
        make.left.mas_equalTo(WS(12));
        make.top.mas_equalTo(WS(34));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"自习室房间名称";
    titleLabel.textColor = kColorWhiteColor;
    titleLabel.font = kLabelSize15;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(WS(37));
    }];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = kColorBlackColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(WS(94));
    }];
    UIButton *startBtn = [[UIButton alloc]init];
    startBtn.backgroundColor = UIColorFromRGB(0xFF6D00);
    startBtn.layer.cornerRadius = 22;
    [startBtn setTitle:@"开始自习" forState:UIControlStateNormal];
    [startBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    startBtn.titleLabel.font = kLabelSize15;
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.right.mas_equalTo(-WS(16));
        make.bottom.mas_equalTo(-WS(35));
        make.height.mas_equalTo(WS(44));
    }];
    [self.view addSubview:self.roomCollectionView];
    [self.roomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(WS(105));
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    studyRoomDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"studyRoomDetailCell" forIndexPath:indexPath];
    cell.backgroundColor = kColorClearColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UICollectionView *)roomCollectionView{
    if (!_roomCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(mScreenWidth/3 , 106);
        _roomCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _roomCollectionView.showsVerticalScrollIndicator = YES;
        _roomCollectionView.backgroundColor = kColorWhiteColor;
        _roomCollectionView.delegate = self;
        _roomCollectionView.dataSource = self;
        _roomCollectionView.pagingEnabled = YES;
        _roomCollectionView.backgroundColor = kColorClearColor;
        [_roomCollectionView registerClass:[studyRoomDetailCell class] forCellWithReuseIdentifier:@"studyRoomDetailCell"];
    }
    return _roomCollectionView;
}

- (void)backnavBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
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
