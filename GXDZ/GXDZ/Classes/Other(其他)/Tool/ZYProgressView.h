//
//  ZYProgressView.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/20.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYProgressView : UIView
/// 指示器进度 环形进度
@property (nonatomic, assign) float progress;
/// 指示器进度 百分比进度
@property (nonatomic, strong) UILabel *progressLabel;
/// 环形线宽
@property (nonatomic, assign) float annularLineWidth;
/// 指示器进度颜色 默认白色
@property (nonatomic, strong) UIColor *progressTintColor;
/// 指示器背景（非进度）颜色
@property (nonatomic, strong) UIColor *backgroundTintColor;

@end

NS_ASSUME_NONNULL_END
