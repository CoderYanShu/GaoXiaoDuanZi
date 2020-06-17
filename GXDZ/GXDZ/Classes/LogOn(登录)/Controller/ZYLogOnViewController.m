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
        make.top.offset(kSTATUS_BAR_HEIGHT + 20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@40);
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

