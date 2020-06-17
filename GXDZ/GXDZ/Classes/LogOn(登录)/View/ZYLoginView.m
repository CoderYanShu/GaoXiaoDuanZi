//
//  ZYLoginView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYLoginView.h"

@implementation ZYLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        self.actionType = ZYActionTypelLogin;
    }
    return self;
}
@end
