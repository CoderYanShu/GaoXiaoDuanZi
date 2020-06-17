//
//  ZYFooterCell.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/17.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYFooterCell.h"
#import "ZYSquareItem.h"
#import <SDWebImage.h>

@interface ZYFooterCell ()

@property (nonatomic ,strong) NSString *url;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *iconView;

@end
@implementation ZYFooterCell
#pragma mark- 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLabel];
    } return _titleLabel;
}
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconView];
    } return _iconView;
}

#pragma mark- setter
- (void)setSquareItem:(ZYSquareItem *)squareItem {
    
    _squareItem = squareItem;
    
    self.url = squareItem.url;
    
    self.titleLabel.text = squareItem.name;
    
    NSURL *url = [NSURL URLWithString:squareItem.icon];
    
    [self.iconView sd_setImageWithURL:url];
}

#pragma mark- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.whiteColor;
        CGFloat margin = 10;
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.titleLabel.mas_top).offset(-margin);
            make.top.mas_equalTo(margin);
            make.left.mas_equalTo(margin);
            make.right.mas_equalTo(-margin);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-margin);
            make.centerX.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
@end
