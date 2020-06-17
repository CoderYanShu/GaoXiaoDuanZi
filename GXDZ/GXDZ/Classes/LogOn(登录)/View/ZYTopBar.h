//
//  ZYTopBar.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/15.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZYTopBarDelegate <NSObject>

@optional

/// 告诉代理 顶部栏已点击 Dismiss 按钮;
- (void)topBarDidClickDismissButton;

/// 告诉代理 顶部栏已点击 login 按钮;
/// @param button login 按钮
- (void)topBarDidClickRegisterButton:(UIButton *)button;

@end

/// 顶部工具栏
@interface ZYTopBar : UIView

@property (nonatomic, weak) id<ZYTopBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
