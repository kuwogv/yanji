//
//  UTON_VC_Launch.m
//  UTON智能云
//
//  Created by mac on 2021/3/2.
//

#import "UTON_VC_Launch.h"
#import "UTONProtocolVC.h"
#import "CCB_2_LaunchImageCollectionViewCell.h"
#import "CCB_2_ImageCollectionViewCell.h"
#import "AdvertisementView.h"

@interface UTON_VC_Launch ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CCBLaunchImageCollectionViewDelegate>

/** *  引导页collection view */
@property (nonatomic, strong) UICollectionView *guideView;
@property (nonatomic, strong) NSArray *images;

//启动广告页
@property (nonatomic, strong) AdvertisementView *advertisementView;
@end

@implementation UTON_VC_Launch

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorWhiteColor;
    [self creatUI];
    
}

- (void)creatUI{
    
    [self.guideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.guideView registerClass:[CCB_2_ImageCollectionViewCell class]
       forCellWithReuseIdentifier:@"CCB_2_ImageCollectionViewCell"];
    
    if ([self firstRunApp]) {
        [self.guideView registerClass:[CCB_2_LaunchImageCollectionViewCell class]
           forCellWithReuseIdentifier:@"CCB_2_LaunchImageCollectionViewCell"];
    }else{
//        if ([self.delegate respondsToSelector:@selector(launchViewDidFinishLaunch:)]) {
//            [self.delegate launchViewDidFinishLaunch:self];
//        }
        WEAKSELF;
        UIImage *image = UTONImage(@"Rectangle_2279");
        self.advertisementView = [[AdvertisementView alloc]initWithImage:image];
        [self.view addSubview:self.advertisementView];
        self.advertisementView.cancelButtonClickCallBack = ^{
            [weakSelf.advertisementView removeFromSuperview];
            // 第一次启动完成
            [weakSelf setFinishFirstRun];
            if ([weakSelf.delegate respondsToSelector:@selector(launchViewDidFinishLaunch:)]) {
                [weakSelf.delegate launchViewDidFinishLaunch:weakSelf];
            }
        };
        self.advertisementView.clickImageViewCallBack = ^{
            [weakSelf.advertisementView removeFromSuperview];
            // 第一次启动完成
            [weakSelf setFinishFirstRun];
            if ([weakSelf.delegate respondsToSelector:@selector(launchViewDidFinishLaunch:)]) {
                [weakSelf.delegate launchViewDidFinishLaunch:weakSelf];
            }
        };
    }
}

- (void)launchImageCollectionViewCellDidClickButton:(CCB_2_LaunchImageCollectionViewCell *)cell {
    [self clickEnter];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CCB_2_LaunchImageCollectionViewCell *cell = nil;
    // 引导页最后一个cell底部带按钮
   
    if ( self.firstRunApp &&
        indexPath.row == [self numberOfGuidImages]-1) {
        cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"CCB_2_LaunchImageCollectionViewCell"
                                                  forIndexPath:indexPath];
        cell.delegate = self;
    } else {
        cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"CCB_2_ImageCollectionViewCell"
                                                  forIndexPath:indexPath];
    }

    cell.image = [self guidImageAtIndex:indexPath.row];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfGuidImages];
}

- (UIImage *)guidImageAtIndex:(NSInteger)index {
    if (index >= self.images.count) {
        return nil;
    }

    return [UIImage ccb_guideImageNamed:self.images[index]];
}

#pragma - mark Delegate UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat num = (scrollView.contentOffset.x/scrollView.frame.size.width);
//    CCBLogDebug(@"--------------scrollViewDidScroll = %@",@(num));
    if (num + 0.8 >= [self numberOfGuidImages]) {
//        self.isFirstIn = NO;
        [self launchImageCollectionViewCellDidClickButton:nil];
    }
}

- (void)clickEnter {
    WEAKSELF;
    UIImage *image = UTONImage(@"Rectangle_2279");
    self.advertisementView = [[AdvertisementView alloc]initWithImage:image];
    [self.view addSubview:self.advertisementView];
    self.advertisementView.cancelButtonClickCallBack = ^{
        [weakSelf.advertisementView removeFromSuperview];
        // 第一次启动完成
        [weakSelf setFinishFirstRun];
        if ([weakSelf.delegate respondsToSelector:@selector(launchViewDidFinishLaunch:)]) {
            [weakSelf.delegate launchViewDidFinishLaunch:weakSelf];
        }
    };
    self.advertisementView.clickImageViewCallBack = ^{
        [weakSelf.advertisementView removeFromSuperview];
        // 第一次启动完成
        [weakSelf setFinishFirstRun];
        if ([weakSelf.delegate respondsToSelector:@selector(launchViewDidFinishLaunch:)]) {
            [weakSelf.delegate launchViewDidFinishLaunch:weakSelf];
        }
    };
    
}

- (NSInteger)numberOfGuidImages {
    return self.images.count;
}

- (NSArray *)images {
    if (!_images) {
        // 首次打开，显示引导页
        
        if (self.firstRunApp) {
//            float screenHeight = mScreenHeight*[UIScreen mainScreen].scale;
            
            _images = @[@"2_Home_Launch_Image_1",
                        @"2_Home_Launch_Image_2",
                        @"2_Home_Launch_Image_3"];
            
//            [[CCBUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstRunApp"];
//            [[CCBUserDefaults standardUserDefaults]synchronize];
        } else {
            float screenHeight = mScreenHeight*[UIScreen mainScreen].scale;
            NSString *imageName = @"";
            if(screenHeight < 500){
                imageName = @"2_320-480";
            }else if(screenHeight < 1000){
                imageName = @"2_640-960";
            }else if(screenHeight < 1200){
                imageName = @"2_640-1136";
            }else if(screenHeight < 1500){
                imageName = @"2_750-1334";
            }else if(screenHeight >2400){
                imageName = @"2_1125-2436";
            }else{
                imageName = @"2_1242-2208";
            }
            
            _images = @[imageName];//@[KIMA_2_Home_Launch_Image_1];
//            [[CCBUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstRunApp"];
//            [[CCBUserDefaults standardUserDefaults]synchronize];
        }
    }

    return _images;
}

//判断是否要展示引导页，以及版本号判断
- (BOOL)firstRunApp {
    NSString *lastrunversion = [[NSUserDefaults standardUserDefaults] objectForKey:@"ccbmobilebanklastrunversion"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    version = [version stringByAppendingFormat:@"%@%@%@",@"(", build, @")"];

    if (lastrunversion == nil) {

        return YES;
    }

    return NO;
}

- (void)setFinishFirstRun {
    // 记录最近一次展示引导页的版本号
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    version = [version stringByAppendingFormat:@"%@%@%@",@"(", build, @")"];

    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"ccbmobilebanklastrunversion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UICollectionView *)guideView {
    if (!_guideView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _guideView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _guideView.showsHorizontalScrollIndicator = NO;
        _guideView.backgroundColor = kColorWhiteColor;
        _guideView.delegate = self;
        _guideView.dataSource = self;
        _guideView.pagingEnabled = YES;
        [self.view addSubview:_guideView];
        
    }

    return _guideView;
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
