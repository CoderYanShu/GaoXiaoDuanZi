//
//  ZYTopicPictView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/20.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTopicPictView.h"
#import "ZYProgressView.h"
#import "ZYTopicItem.h"

#import "ZYEnlargePictViewController.h"

@interface ZYTopicPictView ()

@property (nonatomic ,strong) UIImageView *gifView;
@property (nonatomic ,strong) UIImageView *titleView;
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UIButton *bigPictButton;
@property (nonatomic ,strong) ZYProgressView *progressView;

@end

@implementation ZYTopicPictView

#pragma mark - 懒加载
- (UIImageView *)gifView {
    if (!_gifView) {
        _gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common-gif"]];
    }
    return _gifView;
}

- (UIImageView *)titleView {
    if (!_titleView) {
        _titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageBackground"]];
    }
    return _titleView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIButton *)bigPictButton {
    if (!_bigPictButton) {
        _bigPictButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigPictButton.titleLabel.font = [UIFont systemFontOfSize:19];
        [_bigPictButton setImage:[UIImage imageNamed:@"see-big-picture"] forState:UIControlStateNormal];
        _bigPictButton.userInteractionEnabled = NO;
        [_bigPictButton setTitle:@"点击查看全图" forState:UIControlStateNormal];
        [_bigPictButton setBackgroundImage:[UIImage imageNamed:@"see-big-picture-background"] forState:UIControlStateNormal];
    }
    return _bigPictButton;
}

- (ZYProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[ZYProgressView alloc] init];
        _progressView.progressLabel.textColor = UIColor.grayColor;
    }
    return _progressView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //titleView
        [self addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(@(kTOPIC_MARGIN));
            make.width.equalTo(@150);
            make.height.equalTo(@30);
        }];
        //progressView
        [self addSubview:self.progressView];
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom).offset(2 * kTOPIC_MARGIN);
            make.width.height.equalTo(@40);
            make.centerX.equalTo(self);
        }];
        //imageView
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        //gifView
        [self addSubview:self.gifView];
        [self.gifView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@30);
            make.top.left.equalTo(self);
        }];
        // bigPictButton
        [self addSubview:self.bigPictButton];
        [self.bigPictButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@40);
        }];
    }
    return self;
}

#pragma mark- setter
- (void)setTopicItem:(ZYTopicItem *)topicItem {
    _topicItem = topicItem;
    
    _gifView.hidden = !topicItem.isGif;
    
    _bigPictButton.hidden = !topicItem.isBigPict;
    
    [self setUpPict:topicItem];
}

#pragma mark - 加载图片
- (void)setUpPict:(ZYTopicItem *)tpicItem {
    //判断是否为大图,改变内容模式
    if (tpicItem.isBigPict) {
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    else {
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.clipsToBounds = NO;
    }
    //加载图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:tpicItem.image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
        
        if (expectedSize == -1) return ;
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        //设置进度
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = progress;
        });
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.imageView.image = image;
    }];
}

#pragma mark- 点击查看大图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ZYEnlargePictViewController *enlargePictVc = [[ZYEnlargePictViewController alloc] init];
    enlargePictVc.topicItem = _topicItem;
    
    enlargePictVc.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:enlargePictVc animated:YES completion:nil];
}
@end
