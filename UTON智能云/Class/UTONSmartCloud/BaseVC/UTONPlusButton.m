//
//  UTONPlusButton.m
//  UTON智能云
//
//  Created by mac on 2021/3/10.
//

#import "UTONPlusButton.h"

#import <CTAssetsPickerController/CTAssetsPickerController.h>

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface UTONPlusButton ()<CTAssetsPickerControllerDelegate>
@property (nonatomic,strong)UTONBaseViewController *tempViewController;

@property (nonatomic,assign) BOOL isphoto;
@end

@implementation UTONPlusButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

+ (id)plusButton{
//    CYLPlusButtonSubclass *button = [[CYLPlusButtonSubclass alloc] init];
//    UIImage *normalButtonImage = [UIImage imageNamed:@"UTON_upload"];
//    UIImage *hlightButtonImage = [UIImage imageNamed:@"UTON_upload"];
//    [button setImage:normalButtonImage forState:UIControlStateNormal];
//    [button setImage:[hlightButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
//    [button setImage:[hlightButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
////    [button setTintColor:  [UIColor colorWithRed:0/255.0f green:255/255.0f blue:189/255.0f alpha:1]];
//    
//    //    UIImage *normalButtonBackImage = [UIImage imageNamed:@"videoback"];
//    //    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateNormal];
//    //    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateSelected];
//    button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, -5, 0);
//    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
//    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
//    button.frame = CGRectMake(0.0, 0.0, 55, 59);
//    
//    // if you use `+plusChildViewController` , do not addTarget to plusButton.
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//    return button;
    UTONPlusButton *button = [[UTONPlusButton alloc] init];
        ///中间按钮图片
        UIImage *buttonImage = [UIImage imageNamed:@"addTarBar"];
        [button setImage:buttonImage forState:UIControlStateNormal];
    
        button.titleLabel.font = [UIFont systemFontOfSize:9.5];
        [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
        //    button.frame = CGRectMake(0.0, 0.0, 250, 100);
        //    button.backgroundColor = [UIColor redColor];
        
        // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish:) forControlEvents:UIControlEventTouchUpInside];
    
        return button;
}

- (void)clickPublish:(UIButton *)btn{
    
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

// constantOfPlusButtonCenterYOffset 大于 0 会向下偏移，小于 0 会向上偏移。
+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (-4);
}

- (void)utonPlusButtonAction:(UIButton *)uploadBtn{
    
    NSLog(@"点击----");

    if (uploadBtn.tag==111) {
//        AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [myDelegate utonUploadFileBtnAction:uploadBtn];
        self.isphoto = YES;
        [self upLoading:NO];
    }else if (uploadBtn.tag==112){
        
    }else if (uploadBtn.tag==113){
        [self uploadAudioFile];
    }else{
        self.isphoto = NO;
        [self upLoading:YES];
    }
}



- (void)upLoading:(BOOL)isVedio {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc]init];
            picker.delegate = self;
            picker.showsSelectionIndex =YES;
            picker.showsEmptyAlbums =NO;
            picker.modalPresentationStyle = UIModalPresentationFullScreen;
            if (isVedio) {
                picker.assetCollectionSubtypes =@[@(PHAssetCollectionSubtypeSmartAlbumVideos)];
            }else{
                PHFetchOptions *fetchOptions = [PHFetchOptions new];
                fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeImage];
                picker.assetsFetchOptions = fetchOptions;
            }
            
            [[AppDelegate delegate].window.rootViewController presentViewController:picker animated:YES completion:^{

            }];
        });
    }];

}

-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    // 关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    CGFloat scale = [UIScreen mainScreen].scale;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode   = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        // 遍历选择的所有图片
    NSMutableArray *imageAry = [[NSMutableArray alloc]init];
    NSMutableArray *vedioAry = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        if (asset.mediaType==PHAssetMediaTypeImage) {
            CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
            // 获取图片
        
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {

                [imageAry addObject:result];
                
            }];
        }else{
            
            PHAssetResource * resource;
            NSArray * assetResources = [PHAssetResource assetResourcesForAsset: asset];
            for (PHAssetResource * assetRes in assetResources) {
                if (@available(iOS 9.1, *)) {
                    if (assetRes.type == PHAssetResourceTypePairedVideo || assetRes.type == PHAssetResourceTypeVideo) {
                        resource = assetRes;
                    }else if (assetRes.type == PHAssetResourceTypeAudio){
//                        [audioAry addObject:assets];
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
            [vedioAry addObject:resource];
        }
        
    }
    
    
    
//    [self.window.rootViewController.navigationController pushViewController:vc animated:YES];
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset{
    NSInteger max = 9;
    if (picker.selectedAssets.count>=9) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%zd张图片", max] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
        [picker presentViewController:alert animated:YES completion:nil];
                // 这里不能使用self来modal别的控制器，因为此时self.view不在window上
        return NO;
    }
    return YES;
}

//获取本地歌曲文件---iphone不支持，建议砍掉此功能
- (void)uploadAudioFile{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status != AVAuthorizationStatusAuthorized&&status != AVAuthorizationStatusNotDetermined) {
            NSLog(@"提示用户发开访问媒体库的权限");
        }else{
            [self getLocalMusicItem];
        }
}

- (void)getLocalMusicItem{
    //只能获取上传从ituns手动导入的音乐文件
    MPMediaQuery *_musicQuery = [MPMediaQuery songsQuery];      //获取查询队列   注：这里获取的是以歌曲名称排序的查询队列
        //创建筛选条件
    MPMediaPropertyPredicate *albumNamePredicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInt:MPMediaTypeMusic] forProperty: MPMediaItemPropertyMediaType];
        [_musicQuery addFilterPredicate:albumNamePredicate];
        //获取对应的集合  注：你可以注意一下items和collections和的区别，下面也会给出二者的区别
        NSArray *dataCollectionArr = _musicQuery.collections;
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (MPMediaItemCollection *songCollection in dataCollectionArr) {
            MPMediaItem *songItem = songCollection.representativeItem;
            //NSString *songTitle = song.title;   等价于 NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
            [dataArr addObject:songItem];
        }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
