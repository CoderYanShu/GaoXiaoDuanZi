//
//  ZYFootRefreshView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/22.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYFootRefreshView.h"

@interface ZYFootRefreshView ()

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIView *didRefreshView;
@property (nonatomic ,strong) UIView *willRefreshView;
@property (nonatomic ,strong) UIActivityIndicatorView *indicatoriView;

@end
@implementation ZYFootRefreshView
#pragma mark- 懒加载
- (UIView *)didRefreshView {
    if (!_didRefreshView) {
        _didRefreshView = [[UIView alloc] init];
        _didRefreshView.backgroundColor = UIColor.redColor;
        _didRefreshView.hidden = YES;
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"正在加载更多数据...";
        
        _indicatoriView = [[UIActivityIndicatorView alloc] init];
        _indicatoriView.hidesWhenStopped = NO;
       
        [_didRefreshView addSubview:_indicatoriView];
        [_indicatoriView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(0);
        }];
        
        [_didRefreshView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_indicatoriView.mas_right);
            make.centerY.right.mas_equalTo(0);
        }];
    }
    return _didRefreshView;
}

- (UIView *)willRefreshView {
    if (!_willRefreshView) {
        _willRefreshView = [[UIView alloc] init];
        _willRefreshView.backgroundColor = UIColor.yellowColor;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"上拉加载更多数据";
        
        [_willRefreshView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
    }
    return _willRefreshView;
}

#pragma mark- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.willRefreshView];
        [_willRefreshView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        
        [self addSubview:self.didRefreshView];
        [_didRefreshView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
    }
    return self;
}

#pragma mark- setter
- (void)setIsRefreshing:(BOOL)isRefreshing {
    _isRefreshing = isRefreshing;
    
    _didRefreshView.hidden = !isRefreshing;
    
    _willRefreshView.hidden = isRefreshing;
    
    if (isRefreshing) {
           [_indicatoriView startAnimating];
       }
       else {
           [_indicatoriView stopAnimating];
       }
}

- (void)setIsCanRefresh:(BOOL)isCanRefresh {
    _isCanRefresh = isCanRefresh;
    _titleLabel.text = isCanRefresh?@"松开立即加载":@"上拉加载更多数据";
}
@end
