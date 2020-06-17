//
//  ZYSettingCell.m
//  城觅
//
//  Created by ZYP OnTheRoad on 2020/6/1.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYSettingCell.h"

#import "ZYRowItem.h"
#import "ZYArrowItem.h"
#import "ZYSwitchItem.h"

@interface ZYSettingCell ()

/// 开关视图
@property (nonatomic, weak) UISwitch *switchView;
/// 箭头视图
@property (nonatomic, weak) UIImageView *arrowView;

@end

@implementation ZYSettingCell

#pragma mark- 懒加载
- (UISwitch *)switchView {
    if (!_switchView) {
        UISwitch *swith = [[UISwitch alloc] init];
        [self.contentView addSubview:swith];
        _switchView = swith;
    }
    return _switchView;
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
        [self.contentView addSubview:img];
        _arrowView = img;
    }
    return _arrowView;
}

#pragma mark- setter
- (void)setItem:(ZYRowItem *)item {
    _item = item;
    
    [self setUpData];
    [self setUpAccessoryView];
}

#pragma mark- 设置数据
- (void)setUpData {
    self.textLabel.text = _item.title;
    self.imageView.image = _item.image;
    self.detailTextLabel.text = _item.subTitle;
}

#pragma mark- 设置辅助视图
- (void)setUpAccessoryView {
    
    if ([_item isKindOfClass:[ZYArrowItem class]]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryView = self.arrowView;
    }
    else if ([_item isKindOfClass:[ZYSwitchItem class]]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = self.switchView;
    }
    else{
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryView = nil;
    }
}

#pragma mark- 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        // 背景
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GroupCellSelected"]];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GroupCell"]];
    }
    return self;
}

@end
