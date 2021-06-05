//
//  invitation_myIssueAndQuestionVC.m
//  UTON智能云
//
//  Created by UTON on 2021/6/1.
//

#import "invitation_myIssueAndQuestionVC.h"
#import "myIssueAndQuestionCell.h"
#import "XRWaterfallLayout.h"

@interface invitation_myIssueAndQuestionVC ()<UICollectionViewDataSource,XRWaterfallLayoutDelegate>
@property (nonatomic,strong) NSArray *dataAry;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation invitation_myIssueAndQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    //设置代理，实现代理方法
    waterfall.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[myIssueAndQuestionCell class] forCellWithReuseIdentifier:@"myIssueAndQuestionCell"];
    self.collectionView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.collectionView];
    self.dataAry = @[@"Rectangle_35",@"Rectangle_352",@"Rectangle_35",@"Rectangle_35",@"Rectangle_35"];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
    UIImage *image = UTONImage(self.dataAry[indexPath.item]);
    return (image.size.height+70) / 165 * itemWidth;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    myIssueAndQuestionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myIssueAndQuestionCell" forIndexPath:indexPath];
    
    cell.invitImageView.image = UTONImage(self.dataAry[indexPath.item]);
    return cell;
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
