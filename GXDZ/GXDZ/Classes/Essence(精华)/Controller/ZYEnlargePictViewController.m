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

@interface ZYEnlargePictViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIButton *backButton;
@property (nonatomic ,strong) UIImageView *imageView ;
@property (nonatomic ,strong) UIButton *downloadButton;
@property (nonatomic ,strong) UIScrollView *enlargPictView;
@property (nonatomic ,strong) ZYProgressView *progressView;

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
    //将指定的图像添加到用户的相机滚动相册中。
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
- (void)backButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
