//
//  ZYMiddleBar.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/15.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYMiddleBar.h"
#import "ZYTopBar.h"
#import "ZYLoginView.h"
#import "ZYRegisterView.h"


@interface ZYMiddleBar ()< ZYLoginRegisterViewDelegate>

@property (nonatomic, strong) ZYLoginView *loginView;
@property (nonatomic, strong) ZYRegisterView *registerView;

@end

@implementation ZYMiddleBar

#pragma mark- 懒加载
- (ZYLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[ZYLoginView alloc] init];
        [self addSubview:_loginView];
    }
    return _loginView;
}

- (ZYRegisterView *)registerView {
    if (!_registerView) {
        _registerView = [[ZYRegisterView alloc] init];
        [self addSubview:_registerView];
    }
    return _registerView;
}

#pragma mark- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(0.5);
            make.height.equalTo(@200);
            make.top.left.equalTo(self);
        }];
        
        [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(0.5);
            make.height.equalTo(@200);
            make.top.right.equalTo(self);
        }];
        
    }
    return self;
}

@end
