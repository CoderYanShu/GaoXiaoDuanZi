//
//  ZYRegisterView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYRegisterView.h"

@implementation ZYRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.forgetButton.hidden = YES;
        self.actionType = ZYActionTypeRegister;
        [self.loginButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    return self;
}

@end
