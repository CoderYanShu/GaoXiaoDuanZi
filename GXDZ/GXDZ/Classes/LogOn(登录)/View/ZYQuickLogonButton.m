//
//  ZYQuickLogonButton.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYQuickLogonButton.h"


@implementation ZYQuickLogonButton

//添加子控件
//控件的init方法内部会自动调用initWithFrame:
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return self;
}

//布局子控件,设置子控件的位置和尺寸
// 当前控件的尺寸(size)发生改变的时候会自动调用这个方法
// 这个控件第一次显示的时候会调用这个方法
- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;

    self.imageView.frame = CGRectMake(0, 0, W, W);
    self.titleLabel.frame = CGRectMake(0, W, W, H - W);
}
@end
