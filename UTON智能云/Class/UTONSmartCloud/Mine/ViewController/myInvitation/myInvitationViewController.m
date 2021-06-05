//
//  myInvitationViewController.m
//  UTON智能云
//
//  Created by UTON on 2021/5/31.
//

#import "myInvitationViewController.h"
#import "invitation_myIssueAndQuestionVC.h"
#import "invitation_otherReplyVC.h"

@interface myInvitationViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>
@property (nonatomic,strong) XLPageViewController *pageViewController;
@property (nonatomic,strong) XLPageViewControllerConfig *config;
@property (nonatomic,strong) invitation_myIssueAndQuestionVC *questionAndissueVC;
@property (nonatomic,strong) invitation_otherReplyVC *replyVC;
@end

@implementation myInvitationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"我的帖子";
    
    [self creatUI];
}

- (void)creatUI{
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    
}

- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    if (index==0 || index==1) {
        self.questionAndissueVC = [[invitation_myIssueAndQuestionVC alloc]init];
        return self.questionAndissueVC;
    }else{
        self.replyVC = [[invitation_otherReplyVC alloc]init];
        return self.replyVC;
    }
}

- (NSInteger)pageViewControllerNumberOfPage{
    return 3;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    NSArray *array = @[@"我的提问",@"我的发布",@"其他人回复"];
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
        _config.titleSelectedColor = kColorBlackColor;
        _config.titleNormalColor = UIColorFromRGB(0x696C7A);
        _config.segmentedTintColor = UIColorFromRGB(0xFF6D00);
        _config.shadowLineColor = UIColorFromRGB(0xFF6D00);
        _config.titleNormalFont = kLabelSize15;
        _config.titleSelectedFont = kLabelSize17;
        _config.shadowLineWidth = 10;
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
