//
//  roomRankViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/6/3.
//

#import "roomRankViewController.h"
#import "roomRankListVC.h"

@interface roomRankViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>
@property (nonatomic,strong) XLPageViewController *pageViewController;
@property (nonatomic,strong) XLPageViewControllerConfig *config;
@end

@implementation roomRankViewController
///自习室排行榜
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
}

- (void)creatUI{
    CGFloat statusBarHeight = 0.0f;
    if (@available(iOS 13, *)) {
        statusBarHeight = UIApplication.sharedApplication.delegate.window.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:UTONImage(@"studyRoomRank")];
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(-statusHeight);
        make.height.mas_equalTo(WS(238));
    }];
    UIButton *goBackBtn = [[UIButton alloc]init];
    [goBackBtn setImage:UTONImage(@"navigationBack") forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(goBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:goBackBtn];
    [goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WS(16));
        make.width.height.mas_equalTo(WS(20));
        make.top.mas_equalTo(WS(54));
    }];
    UIImageView *whiteBackImage = [[UIImageView alloc]initWithImage:UTONImage(@"Rectangle_2144")];
    [self.view addSubview:whiteBackImage];
    [whiteBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(WS(50));
        make.top.mas_equalTo(WS(180));
    }];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(whiteBackImage.mas_top).offset(WS(10));
    }];
}

- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    roomRankListVC *vc = [[roomRankListVC alloc]init];
    return vc;
}

- (NSInteger)pageViewControllerNumberOfPage{
    return 3;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    NSArray *array = @[@"日榜",@"周榜",@"总榜"];
    return array[index];
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
//    NSLog(@"切换到了");
    
    
}

- (void)goBackBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (XLPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[XLPageViewController alloc]initWithConfig:self.config];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

- (XLPageViewControllerConfig *)config{
    if (!_config) {
        _config = [XLPageViewControllerConfig defaultConfig];
        _config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
        _config.titleSpace = 35;
        _config.titleSelectedColor = kColorBlackColor;
        _config.titleNormalColor = UIColorFromRGB(0xA7A6B3);
        _config.segmentedTintColor = UIColorFromRGB(0xFF6D00);
        _config.shadowLineColor = UIColorFromRGB(0xFF6D00);
        _config.titleNormalFont = kLabelSize16;
        _config.titleSelectedFont = kLabelSize18;
        _config.shadowLineWidth = 10;
        _config.separatorLineHidden = YES;
    }
    return _config;
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
