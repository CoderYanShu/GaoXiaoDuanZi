//
//  ZYHeadRefreshView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/22.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYHeadRefreshView.h"

@interface ZYHeadRefreshView ()

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UIView *didRefreshView;
@property (nonatomic ,strong) UIView *willRefreshView;
@property (nonatomic ,strong) UIActivityIndicatorView *indicatorView;

@end
@implementation ZYHeadRefreshView
#pragma mark- 懒加载
- (UIView *)didRefreshView {
    if (!_didRefreshView) {
        _didRefreshView = [[UIView alloc] init];
        _didRefreshView.hidden = YES;
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"正在刷新...";
        [_didRefreshView addSubview:titleLabel];
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.hidesWhenStopped = NO;
       
        [_didRefreshView addSubview:_indicatorView];
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(0);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_indicatorView.mas_right);
            make.centerY.right.mas_equalTo(0);
        }];
    }
    return _didRefreshView;
}

- (UIView *)willRefreshView {
    if (!_willRefreshView) {
        _willRefreshView = [[UIView alloc] init];
        
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
        [_willRefreshView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(15);
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"下拉刷新";
        [_willRefreshView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_imageView.mas_right).offset(5);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
    return _willRefreshView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        [self addSubview:self.didRefreshView];
        [_didRefreshView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        
        [self addSubview:self.willRefreshView];
        [_willRefreshView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
    }
    return self;
}


- (void)setIsRefreshing:(BOOL)isRefreshing {
    _isRefreshing = isRefreshing;
    _didRefreshView.hidden = !isRefreshing;
    _willRefreshView.hidden = isRefreshing;
    if (isRefreshing) {
        [_indicatorView startAnimating];
    }
    else {
        [_indicatorView stopAnimating];
    }
}

- (void)setIsCanRefresh:(BOOL)isCanRefresh {
    _isCanRefresh = isCanRefresh;
    _titleLabel.text = isCanRefresh?@"释放更新":@"下拉刷新";
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.transform = isCanRefresh? CGAffineTransformMakeRotation(-M_PI+0.00001):CGAffineTransformIdentity;
    }];
}
@end
