//
//  ZYSubTagCell.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/15.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYSubTagCell.h"
#import "ZYSubTagItem.h"
#import <Masonry.h>

@interface ZYSubTagCell ()

/// 主题
@property (nonatomic, strong)  UILabel *themeLabel;
/// 订阅数
@property (nonatomic, strong)  UILabel *numberLabel;
/// 头像
@property (nonatomic, strong)  UIImageView *iconView;
/// 订阅
@property (nonatomic, strong)  UIButton *followButton;

@end
@implementation ZYSubTagCell
#pragma mark- 懒加载
- (UILabel *)themeLabel {
    if (!_themeLabel) {
        _themeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_themeLabel];
    }
    return _themeLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:15];
        _numberLabel.textColor = UIColor.systemGrayColor;
        [self.contentView addSubview:_numberLabel];
    }
    return _numberLabel;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UIButton *)followButton {
    if (!_followButton) {
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followButton setBackgroundImage:[UIImage imageNamed:@"FollowBtnBg"] forState:UIControlStateNormal];
        [_followButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_followButton setTitle:@"+ 订阅" forState:UIControlStateNormal];
        [self.contentView addSubview:_followButton];
    }
    return _followButton;
}

#pragma mark- 设置图片
- (void)setUpIcon:(ZYSubTagItem *)subTagItem {
    
    NSURL *url = [NSURL URLWithString:subTagItem.icon];
    
    UIImage *defaultImage = [UIImage imageNamed:@"defaultUserIcon"];
    
    [self.iconView sd_setImageWithURL:url placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //处理 CGContextAddPath: invalid context 0x0 的问题
        if(image.size.height <= 0 || image.size.width <= 0) return;
       
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        //1 开启位图上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        
        //2 设置裁剪区域
        //2.1 创建一个圆形路径
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        //2.2将圆形路径设置为裁剪区域
        [path addClip];
        
        //3 把图片绘制到上下文当中
        [image drawAtPoint:CGPointZero];
        
        //4 从上下文当中生成一张图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        //5 关闭上下文
        UIGraphicsEndImageContext();
        
        //显示图片
        self.iconView.image = image;
    }];
}

#pragma mark- 设置订阅数
- (void)setUpNumber:(ZYSubTagItem *)subTagItem {
    
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",subTagItem.number];
    
    CGFloat number = subTagItem.number.floatValue;
    
    if (number >= 10000) {
        number /= 10000;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",number];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.numberLabel.text = numStr;
}

#pragma mark- setter
- (void)setSubTagItem:(ZYSubTagItem *)subTagItem {
    
    _subTagItem = subTagItem;
    
    [self setUpIcon:subTagItem];
    [self setUpNumber:subTagItem];
    self.themeLabel.text = subTagItem.theme;
}

#pragma mark- 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.iconView.mas_height);
            make.left.top.mas_equalTo(15);
            make.bottom.mas_equalTo(-15);
        }];
        
        [self.themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right).offset(10);
            make.top.mas_equalTo(self.iconView);
        }];
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right).offset(10);
            make.bottom.mas_equalTo(self.iconView);
        }];
        
        [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(60);
            make.right.mas_equalTo(-10);
        }];
    }
    return self;
}
@end
