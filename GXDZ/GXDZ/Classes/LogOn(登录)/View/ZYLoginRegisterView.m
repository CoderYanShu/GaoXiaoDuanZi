//
//  ZYLoginRegisterView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYLoginRegisterView.h"
#import "UIImage+ZYRevised.h"
#import "ZYTextField.h"

@implementation ZYLoginRegisterView

#pragma mark- 懒加载
- (ZYTextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [[ZYTextField alloc] init];
        //设置输入框提示占位符
        _accountTextField.placeholder = @"手机号";
    
        //监听输入框内容改变事件
        [_accountTextField addTarget:self action:@selector(editingChanged) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _accountTextField;
}

- (ZYTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[ZYTextField alloc] init];
        
        _passwordTextField.placeholder = @"密码";
        //设置密码输入框为安全文本输入
       // _passwordTextField.secureTextEntry = YES;
        //键盘类型
        //_passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
       
        //监听输入框内容改变事件
        [_passwordTextField addTarget:self action:@selector(editingChanged) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _passwordTextField;
}


- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        UIImage *imageN = [UIImage imageRevisedWithNamed:@"loginBtnBg"];
        UIImage *imageH = [UIImage imageRevisedWithNamed:@"loginBtnBgClick"];
    
        [_loginButton setBackgroundImage:imageN forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:imageH forState:UIControlStateHighlighted];
        
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [[UIButton alloc] init];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_forgetButton setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
        
         [_forgetButton addTarget:self action:@selector(forgetButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_forgetButton sizeToFit];
    }
    return _forgetButton;
}

#pragma mark- 输入框编辑
- (void)editingChanged {
    //当两个输入框不都有内容时,不启用登录按钮
    self.loginButton.enabled = self.accountTextField.text.length && self.passwordTextField.text.length;
}

#pragma mark- 点击按钮(调用代理方法)
- (void)loginButtonClick {
    if (self.actionType == ZYActionTypelLogin) {
        if ([self.delegate respondsToSelector:@selector(loginRegisterViewDidClickLoginButton)]) {
            [self.delegate loginRegisterViewDidClickLoginButton];
        }
    }
    else if (self.actionType == ZYActionTypeRegister) {
        if ([self.delegate respondsToSelector:@selector(loginRegisterViewDidClickRegisterButton)]) {
            [self.delegate loginRegisterViewDidClickRegisterButton];
        }
    }
}

- (void)forgetButtonClick {
    
    if ([self.delegate respondsToSelector:@selector(loginRegisterViewDidClickForgetButton)]) {
        [self.delegate loginRegisterViewDidClickForgetButton];
    }
    
}

#pragma mark- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self editingChanged];
        //背景
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"login_rgister_textfield_bg"];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(@266);
            make.height.equalTo(@92);
            make.top.equalTo(self);
        }];
        //账号
        [imageView addSubview:self.accountTextField];
        [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(imageView).multipliedBy(0.5);
            make.top.equalTo(imageView);
            make.right.equalTo(@-5);
            make.left.equalTo(@5);
        }];
        //密码
        [imageView addSubview:self.passwordTextField];
        [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(imageView).multipliedBy(0.5);
            make.top.equalTo(self.accountTextField.mas_bottom);
            make.right.equalTo(@-5);
            make.left.equalTo(@5);
        }];
        
        //登录按钮
        [self addSubview:self.loginButton];
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(15);
            make.width.equalTo(imageView.mas_width);
            make.centerX.equalTo(self);
        }];
        
        //忘记密码
        [self addSubview:self.forgetButton];
        [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginButton.mas_bottom).offset(5);
            make.right.equalTo(imageView.mas_right);
        }];
    }
    return self;
}

@end
