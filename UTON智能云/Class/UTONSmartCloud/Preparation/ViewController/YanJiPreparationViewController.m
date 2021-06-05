//
//  YanJiPreparationViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/25.
//

#import "YanJiPreparationViewController.h"
#import "studyRoomViewController.h"
#import "courseViewController.h"
#import "resourseDownloadViewController.h"

@interface YanJiPreparationViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>
@property (nonatomic,strong) XLPageViewController *pageViewController;
@property (nonatomic,strong) XLPageViewControllerConfig *config;

@end

@implementation YanJiPreparationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat statusBarHeight = 0.0f;
    if (@available(iOS 13, *)) {
        statusBarHeight = UIApplication.sharedApplication.delegate.window.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    
    UIView *topBackView = [[UIView alloc]init];
    topBackView.backgroundColor = UIColorFromRGB(0xFF6D00);
    [self.view addSubview:topBackView];
    
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(WS(80)+statusBarHeight);
        make.top.mas_equalTo(-statusBarHeight);
    }];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(WS(20)+statusBarHeight);
    }];
    
}

- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    if (index==0) {
        studyRoomViewController *roomVC = [[studyRoomViewController alloc]init];
        return roomVC;
    }else if (index==1){
        courseViewController *courseVC = [[courseViewController alloc]init];
        return courseVC;
    }else{
        resourseDownloadViewController *downLoadVC = [[resourseDownloadViewController alloc]init];
        return downLoadVC;
    }
}

- (NSInteger)pageViewControllerNumberOfPage{
    return 3;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    NSArray *array = @[@"自习室",@"课程",@"资源下载"];
    return array[index];
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
//    NSLog(@"切换到了");
    
    
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
        _config.titleSelectedColor = kColorWhiteColor;
        _config.titleNormalColor = UIColorFromRGB(0xCECED6);
        _config.segmentedTintColor = kColorWhiteColor;
        _config.shadowLineColor = kColorWhiteColor;
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
