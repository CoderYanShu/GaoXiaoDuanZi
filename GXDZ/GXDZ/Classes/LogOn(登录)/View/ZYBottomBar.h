//
//  ZYBottomBar.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/15.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZYBottomBarDelegate <NSObject>

@optional

/// 告诉代理 底部栏已点击 QQ登录 按钮;
- (void)bottomBarDidClickQqButton;
/// 告诉代理 底部栏已点击 新浪微博 按钮;
- (void)bottomBarDidClickSinaButton;
/// 告诉代理 底部栏已点击 腾讯微博 按钮;
- (void)bottomBarDidClickTencentButton;

@end
/// 底部工具栏(快速登录)
@interface ZYBottomBar : UIView

@property (nonatomic, weak) id<ZYBottomBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
