//
//  ZYTopBar.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/15.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTopBar.h"


@interface ZYTopBar ()

@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) UIButton *registerButton;

@end

@implementation ZYTopBar

#pragma mark- 懒加载
- (UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"login_close_icon"];
        [_dismissButton setImage:image forState:UIControlStateNormal];
        [_dismissButton addTarget:self action:@selector(dismissButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_dismissButton sizeToFit];
        [self addSubview:_dismissButton];
    }
    return _dismissButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registerButton setTitle:@"已有账号?" forState:UIControlStateSelected];
        [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton sizeToFit];
        [self addSubview:_registerButton];
    }
    return _registerButton;
}

#pragma mark- 按钮点击(调用代理方法)
- (void)dismissButtonClick {
    //判断登录是否实现代理方法
    if ([self.delegate respondsToSelector:@selector(topBarDidClickDismissButton)]) {
        [self.delegate topBarDidClickDismissButton];
    }
}

- (void)registerButtonClick:(UIButton *)button {
    //设置按钮状态
    button.selected = !button.selected;
    //判断登录是否实现代理方法
    if ([self.delegate respondsToSelector:@selector(topBarDidClickRegisterButton:)]) {
        [self.delegate topBarDidClickRegisterButton:button];
    }
}

#pragma mark- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // dismissButton
        [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(20);
        }];
        
        // registerButton
        [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.offset(-20);
        }];
    }
    return self;
}
@end
