//
//
//  
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "LBXScanViewController.h"


@interface LBXScanViewController ()


@end

@implementation LBXScanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(erweihuoStopScan) name:@"stopScan" object:nil];
    self.view.backgroundColor = [UIColor blackColor];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self drawScanView];
//    if (self.isloadErweihuo == YES) {
//        [self.scanObj stopScan];
//    }else{
        [self performSelector:@selector(startScan) withObject:nil afterDelay:0.2];
//    }
    
}

- (void)erweihuoStopScan{
    [self.scanObj stopScan];
}

//绘制扫描区域
- (void)drawScanView
{
    if (!_qRScanView)
    {
        CGRect rect = self.view.frame;
        rect.origin = CGPointMake(0, 0);
        
        self.qRScanView = [[LBXScanView alloc]initWithFrame:rect style:_style];
        
        [self.view addSubview:_qRScanView];
    
    }
    
//      [_qRScanView startDeviceReadyingWithText:@"相机启动中"];
    
    
}

- (void)reStartDevice
{
    [_scanObj startScan];
}

- (void)alertViewDidClickedButtonAtIndex:(NSInteger)index
       title:(nullable NSString *)title
     message:(nullable NSString *)message
                            buttonTitles:(nullable NSArray *)buttonTitles{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CCBCallCenter navigationController] popViewControllerAnimated:YES];
    });
}

//启动设备
- (void)startScan
{
    if ( ![LBXScanWrapper isGetCameraPermission] )
    {
        [_qRScanView stopDeviceReadying];
//        CCBBaseError *error = [[CCBBaseError alloc] initWithErrorMsg:@"   请到设置隐私中开启本程序相机权限   " ErrorCode:@"MCLWi15002010"];
//        [self showError:error];
        [self showWithTitle:@"" message:@"   请到设置隐私中开启本程序相机权限   " btnTitleArray:@[@"确定"] alertType:BaseAlertViewDefault];
        return;
    }
    
  NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
  AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
  [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
      if (granted) {
          NSLog(@"允许了");
      }else
      {
          dispatch_async(dispatch_get_main_queue(), ^{
              [[CCBCallCenter navigationController] popViewControllerAnimated:YES];
          });
          
      }
  }];
    
    if (!_scanObj )
    {
        __weak __typeof(self) weakSelf = self;
         // AVMetadataObjectTypeQRCode   AVMetadataObjectTypeEAN13Code
        
        CGRect cropRect = CGRectZero;
        
        if (_isOpenInterestRect) {
            
            cropRect = [LBXScanView getScanRectWithPreView:self.view style:_style];
        }
        
        UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        videoView.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:videoView atIndex:0];

        self.scanObj = [[LBXScanWrapper alloc]initWithPreView:videoView
                                              ArrayObjectType:nil
                                                     cropRect:CGRectZero
                                                      success:^(NSArray<LBXScanResult *> *array){
                                                          [weakSelf scanResultWithArray:array andScanType:scanPicture];
                                                      }];
            
        [_scanObj setNeedCaptureImage:_isNeedScanImage];
        
        [self cameraInitOver];
      
    }
    [_scanObj startScan];

//    CCBLogDebug(@"------怎么又扫了-----");
    [_qRScanView stopDeviceReadying];
    
    [_qRScanView startScanAnimation];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)cameraInitOver
{
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [_scanObj stopScan];
    [_qRScanView stopScanAnimation];
}



#pragma mark -实现类继承该方法，作出对应处理
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array andScanType:(ScanType)type
{
    
}





//开关闪光灯
- (void)openOrCloseFlash
{
    [_scanObj openOrCloseFlash];
    
    self.isOpenFlash =!self.isOpenFlash;
    
}


#pragma mark --打开相册并识别图片

/*!
 *  打开本地照片，选择图片识别
 */
- (void)openLocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
   
    
    picker.allowsEditing = YES;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}



//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
//    NSLog(@"--------------%@",info);
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak __typeof(self) weakSelf = self;
//    获取图片上的二维码
    [LBXScanWrapper recognizeImage:image success:^(NSArray<LBXScanResult *> *array) {
        
        [weakSelf scanResultWithArray:array andScanType:localPicture];
    }];
    
   
    
    //系统自带识别方法
    /*
     CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
     NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
     if (features.count >=1)
     {
     CIQRCodeFeature *feature = [features objectAtIndex:0];
     NSString *scanResult = feature.messageString;
     
     NSLog(@"%@",scanResult);
     }
     */
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    NSLog(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//子类继承必须实现的提示
- (void)showWithError:(NSString*)str
{

}

@end







