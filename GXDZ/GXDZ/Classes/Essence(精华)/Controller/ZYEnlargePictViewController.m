//
//  ZYEnlargePictViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYEnlargePictViewController.h"
#import <SDWebImage.h>
#import "ZYProgressView.h"
#import "ZYTopicItem.h"
#import <SVProgressHUD.h>
#import <Photos/Photos.h>
#define kALBUM_TITLEL @"搞笑段子"

@interface ZYEnlargePictViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIButton *backButton;
@property (nonatomic ,strong) UIImageView *imageView ;
@property (nonatomic ,strong) UIButton *downloadButton;
@property (nonatomic ,strong) UIScrollView *enlargPictView;
@property (nonatomic ,strong) ZYProgressView *progressView;
@property (nonatomic, strong) UIImage *enlargImage;

@end

@implementation ZYEnlargePictViewController
#pragma mark - 懒加载
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView =  [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _downloadButton.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6];
        [_downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

- (UIScrollView *)enlargPictView {
    if (!_enlargPictView) {
        _enlargPictView = [[UIScrollView alloc] init];
        _enlargPictView.backgroundColor = UIColor.blackColor;
        
        [_enlargPictView addSubview:self.imageView];
    }
    return _enlargPictView;
}

- (ZYProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[ZYProgressView alloc] init];
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildView];
    
    [self loadPicture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
#pragma mark - 添加子控件
- (void)addChildView {
    [self.view addSubview:self.enlargPictView];
    [_enlargPictView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
     [self.view  addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.downloadButton];
    [_downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(40);
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(50);
    }];
}

- (void)downloadButtonClick {
    
    PHAuthorizationStatus status = PHPhotoLibrary.authorizationStatus;
    
    if (status == PHAuthorizationStatusNotDetermined) {//授权状态未确定
        //请求授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) [self savePhoto];
        }];
    }
    else if (status == PHAuthorizationStatusRestricted) {//授权状态受限
         [SVProgressHUD showErrorWithStatus:@"保存失败!进入设置修改权限"];
    }
    else if (status == PHAuthorizationStatusDenied) {//授权状态被拒绝
         [SVProgressHUD showErrorWithStatus:@"保存失败!进入设置修改权限"];
    }
    else if (status == PHAuthorizationStatusAuthorized) {//授权状态授权
        [self savePhoto];
    }
    
    //将指定的图像添加到用户的相机滚动相册中。
    //UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
#pragma mark- 保存照片到系统相簿完成时调用
//UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!!!!"];
    }
}

#pragma mark- 获取相册
/// 获取指定标题的相册
/// @param albumTitel 指定的相册标题
- (PHAssetCollection *)fetchAlbumWithAlbumTitel:(NSString *)albumTitel {
    //检索指定类型和子类型的相册
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //遍历所有检索到的相册
    for (PHAssetCollection *album in result) {
        //检索到的相册的本地化名称是否与指定的相册名称一致
        if ([album.localizedTitle isEqualToString:albumTitel]) return album;
    }
    return nil;
}

#pragma mark- 保存相片到自己定义的相册
- (void)savePhoto {
    // PHPhotoLibrary 相簿(所有相册的集合)
    // PHAssetCollection 相册(所有相片的集合)
    // PHAsset 相片

    //PHAssetCollectionChangeRequest
    //创建、删除或修改照片资源集合的请求，用于照片库更改块中 PHAssetCollectionChangeRequest
    //PHAssetChangeRequest
    //创建、删除、更改照片资源的元数据或编辑照片资源内容的请求，以便在照片库更改块中使用。

    
    //保存相片到自己定义的相册
    //1.创建自定义相册
    //2.添加相片到系统相册
    //3.拷贝系统相册相册到自定义相册
    
    [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
        //1. 创建(修改)相册的请求
        PHAssetCollectionChangeRequest *createAlbumRequest = nil;
        //根据相册名称尝试获取相册
        PHAssetCollection *album = [self fetchAlbumWithAlbumTitel:kALBUM_TITLEL];
        if (album) {
            //创建修改指定相册的请求
            createAlbumRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
        }
        else {
            createAlbumRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:kALBUM_TITLEL];
        }
        
        //2.创建向照片库添加新相片的请求
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self.enlargImage];
     
        //3.将指定的相片添加到相册。
        PHObjectPlaceholder *placeholder = assetChangeRequest.placeholderForCreatedAsset;
        [createAlbumRequest addAssets:@[placeholder]];
        
    } completionHandler:^(BOOL success, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            [SVProgressHUD showErrorWithStatus:@"保存失败"];
        }
        else {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        }
    }];
    
  
}
#pragma mark- 返回
- (void)backButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- 下载图片
- (void)loadPicture {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_topicItem.image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
        
        if (expectedSize == -1) return;
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        //设置进度
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = progress;
        });
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        self.imageView.image = image;
        self.enlargImage = image;
    }];
    
    CGFloat height = kSCREEN_WIDTH / self.topicItem.width * self.topicItem.height;
    self.imageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, height);
    
    if (self.topicItem.isBigPict) {
        self.enlargPictView.contentSize = CGSizeMake(0, height);
        self.enlargPictView.delegate = self;
        self.enlargPictView.maximumZoomScale = 2;
        self.enlargPictView.minimumZoomScale = 0.5;
        
           if (kSCREEN_WIDTH < self.topicItem.width) {
               self.enlargPictView.maximumZoomScale = self.topicItem.width / kSCREEN_WIDTH;
           }
       }
       else {
           self.imageView.center = CGPointMake(kSCREEN_WIDTH * 0.5, kSCREEN_HEIGHT * 0.5);
       }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
@end
