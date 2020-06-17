//
//  ZYBottomBar.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/15.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYBottomBar.h"


#import "ZYQuickLogonButton.h"

@interface ZYBottomBar ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *quickLogonView;

@end
@implementation ZYBottomBar


#pragma mark- 懒加载
- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        [self addSubview:_titleView];
        
        //leftLine
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"login_register_left_line"];
        [_titleView addSubview:leftView];
        
        //rightLine
         UIImageView *rightView = [[UIImageView alloc] init];
        rightView.image = [UIImage imageNamed:@"login_register_right_line"];
        [_titleView addSubview:rightView];
        
        //title
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = UIColor.whiteColor;
        titleLabel.text = @"快速登录";
        [_titleView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_titleView);
        }];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(titleLabel.mas_left).offset(-10);
            make.centerY.equalTo(_titleView);
            make.height.equalTo(@1);
            make.width.equalTo(@103);
        }];
        
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(10);
            make.centerY.equalTo(_titleView);
            make.height.equalTo(@1);
            make.width.equalTo(@103);
        }];
    }
    return _titleView;
}

- (UIView *)quickLogonView {
    if (!_quickLogonView) {
        _quickLogonView = [[UIView alloc] init];
        [self addSubview:_quickLogonView];

        //创建按钮
        NSArray *titles = @[@"QQ登录", @"微博登录", @"腾讯微博"];
        NSArray *normalImages = @[@"login_QQ_icon", @"login_sina_icon", @"login_tecent_icon"];
        NSArray *highlImages = @[@"login_QQ_icon_click", @"login_sina_icon_click",@"login_tecent_icon_click"];
        
        CGFloat margin = 30;
        CGFloat buttonW = 70;
        CGFloat buttonH = 100;
        
        for (int i = 0; i < normalImages.count; i++) {
            
            ZYQuickLogonButton *button = [[ZYQuickLogonButton alloc] init];
            
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:normalImages[i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:highlImages[i]] forState:UIControlStateHighlighted];
            
            button.tag = i;
            
            [button addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_quickLogonView addSubview:button];
            
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_quickLogonView.mas_left).offset((buttonW + margin) *i);
                make.top.equalTo(_quickLogonView);
                make.height.equalTo(@(buttonH));
                make.width.equalTo(@(buttonW));
               
            }];
        }
    }
    return _quickLogonView;
}

#pragma mark- 按钮点击(调用代理方法)
- (void)loginButtonClick:(UIButton *)button {
    if (0 == button.tag) {
        if ([self.delegate respondsToSelector:@selector(bottomBarDidClickQqButton)]) {
            [self.delegate bottomBarDidClickQqButton];
        }
    }
    else if (1 == button.tag) {
        if ([self.delegate respondsToSelector:@selector(bottomBarDidClickSinaButton)]) {
            [self.delegate bottomBarDidClickSinaButton];
        }
    }
    else if (2 == button.tag) {
        if ([self.delegate respondsToSelector:@selector(bottomBarDidClickTencentButton)]) {
            [self.delegate bottomBarDidClickTencentButton];
        }
    }
}

#pragma mark- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@20);
        }];
        
        [self.quickLogonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom).offset(30);
            make.centerX.equalTo(self);
            make.height.equalTo(@100);
            make.width.equalTo(@270);
        }];
    }
    return self;
}
@end
