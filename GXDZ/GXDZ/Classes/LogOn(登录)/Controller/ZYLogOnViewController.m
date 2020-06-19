//
//  ZYLogOnViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYLogOnViewController.h"

#import "ZYTopBar.h"
#import "ZYMiddleBar.h"
#import "ZYBottomBar.h"

@interface ZYLogOnViewController ()<ZYTopBarDelegate, ZYMiddleBarDelegate, ZYBottomBarDelegate>

@property (nonatomic, strong) ZYTopBar *topBar;
@property (nonatomic, strong) ZYMiddleBar *middleBar;
@property (nonatomic, strong) ZYBottomBar *bottomBar;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZYLogOnViewController

#pragma mark- 懒加载
- (ZYTopBar *)topBar {
    if (!_topBar) {
        _topBar = [[ZYTopBar alloc] init];
        _topBar.delegate = self;
        [self.view addSubview:_topBar];
    }
    return _topBar;
}

- (ZYMiddleBar *)middleBar {
    if (!_middleBar) {
        _middleBar = [[ZYMiddleBar alloc] init];
        _middleBar.delegate = self;
        [self.view addSubview:_middleBar];
    }
    return _middleBar;
}

- (ZYBottomBar *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[ZYBottomBar alloc] init];
        [self.view addSubview:_bottomBar];
        _bottomBar.delegate = self;
    }
    return _bottomBar;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        UIImage *image = [UIImage imageNamed:@"login_register_background"];
        _imageView.image = image;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark- 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSubviews];
    
    [self setUpSwipeGesture];
    
    //有导航条,隐藏 topBar, 设置 NavigationItem
    if (self.navigationController) {
         self.topBar.hidden = YES;
        [self setUpNavigationItem];
    }
}

#pragma mark- 设置导航条 Item
- (void)setUpNavigationItem {
    
    self.navigationItem.title = @"登录/注册";
    
    UIButton *registerButton = [[UIButton alloc] init];
    [registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerButton setTitle:@"已有账号" forState:UIControlStateSelected];
    [registerButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [registerButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:registerButton];
}

#pragma mark- 监听视图点击(点击结束编辑)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark- 设置子视图
- (void)setUpSubviews {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.height.equalTo(@40);
        if (kNAVIGATION_BAR_HEIGHT) {
             make.top.offset(kSTATUS_BAR_HEIGHT + kNAVIGATION_BAR_HEIGHT + 0);
        }
        else {
             make.top.offset(kSTATUS_BAR_HEIGHT + 0);
        }
    }];
    
    [self.middleBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBar.mas_bottom).offset(60);
        make.width.equalTo(self.view).multipliedBy(2);
        make.left.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@160);
        make.bottom.equalTo(@-50);
    }];
}

#pragma mark- 点击注册按钮
- (void)registerButtonClick:(UIButton *)button {
    
    button.selected = !button.selected;
    
    [self loginRegistrationToggle:button];
}

#pragma mark- 切换 登录/注册 输入框
- (void)loginRegistrationToggle:(UIButton *)button {
        
    [self.middleBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBar.mas_bottom).offset(60);
        make.width.equalTo(self.view).multipliedBy(2);
        make.height.equalTo(@200);
        if (button.selected) {
            make.right.equalTo(self.view);
        }
        else {
             make.left.equalTo(self.view);
        }
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
}
#pragma mark- 设置轻扫手势
- (void)setUpSwipeGesture {
    
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(topBarDidClickDismissButton)];
    //设置轻扫的方向, 一个轻扫手势只能对应一个方向
    swipeGR.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGR];
}

#pragma mark- ZYTopBarDelegate
- (void)topBarDidClickDismissButton {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)topBarDidClickRegisterButton:(UIButton *)button {
    
    [self loginRegistrationToggle:button];
}

#pragma mark- ZYBottomBarDelegate
- (void)bottomBarDidClickQqButton {
    NSLog(@"点击了QQ登录");
}
- (void)bottomBarDidClickSinaButton {
    NSLog(@"点击了微博登录");
}
- (void)bottomBarDidClickTencentButton {
    NSLog(@"点击了腾讯登录");
}
@end

