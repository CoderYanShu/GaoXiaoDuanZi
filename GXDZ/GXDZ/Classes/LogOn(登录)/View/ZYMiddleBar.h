//
//  ZYMiddleBar.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/15.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZYMiddleBarDelegate <NSObject>

@optional

- (void)middleBarDidClickLoginButton;
- (void)middleBarDidClickRegisterButton;

@end
/// 中部工具栏(登录/注册)
@interface ZYMiddleBar : UIView

@property (nonatomic, weak) id<ZYMiddleBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
