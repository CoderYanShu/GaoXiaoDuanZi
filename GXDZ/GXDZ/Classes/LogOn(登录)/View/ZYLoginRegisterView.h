//
//  ZYLoginRegisterView.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZYTextField;

typedef NS_ENUM(NSUInteger, ZYActionType) {
    ZYActionTypelLogin,
    ZYActionTypeRegister,
};

@protocol ZYLoginRegisterViewDelegate <NSObject>

@optional

- (void)loginRegisterViewDidClickLoginButton;
- (void)loginRegisterViewDidClickForgetButton;
- (void)loginRegisterViewDidClickRegisterButton;

@end

@interface ZYLoginRegisterView : UIView

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic, assign) ZYActionType actionType;
@property (nonatomic, strong) ZYTextField *accountTextField;
@property (nonatomic, strong) ZYTextField *passwordTextField;
@property (nonatomic, weak) id<ZYLoginRegisterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
