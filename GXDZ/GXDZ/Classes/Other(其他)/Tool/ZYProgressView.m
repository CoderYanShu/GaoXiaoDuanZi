//
//  ZYProgressView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/20.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYProgressView.h"

@implementation ZYProgressView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        _progressTintColor = UIColor.whiteColor;
        _backgroundTintColor = UIColor.lightGrayColor;
        
        _annularLineWidth = 4.f;
        
        _progressLabel = [[UILabel alloc] initWithFrame:self.bounds];
        
        _progressLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _progressLabel.textColor = UIColor.whiteColor;
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:11];
         _progressLabel.adjustsFontSizeToFitWidth = YES;
        _progressLabel.text = @"0.0%";
        
        [self addSubview:_progressLabel];
        
        self.opaque = NO;
        _progress = 0.f;
    }
    return self;
}

#pragma mark - 属性
- (void)setProgress:(float)progress {
    if (progress != _progress) {
        _progress = progress;
        _progressLabel.text = [NSString stringWithFormat:@"%.1f%%",_progress * 100];
        [self setNeedsDisplay];
    }
}

- (void)setAnnularLineWidth:(float)annularLineWidth {
    if (annularLineWidth != _annularLineWidth) {
        _annularLineWidth = annularLineWidth;
        [self setNeedsDisplay];
    }
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    if (![progressTintColor isEqual:_progressTintColor]) {
        _progressTintColor = progressTintColor;
        [self setNeedsDisplay];
    }
}

- (void)setBackgroundTintColor:(UIColor *)backgroundTintColor {
    if (![backgroundTintColor isEqual:_backgroundTintColor]) {
        _backgroundTintColor = backgroundTintColor;
        [self setNeedsDisplay];
    }
}

#pragma mark - 进度指示器
- (void)drawRect:(CGRect)rect {
    // Draw background
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = _annularLineWidth;
    processBackgroundPath.lineCapStyle = kCGLineCapButt;
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = (self.bounds.size.width - _annularLineWidth)/2;
    CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [_backgroundTintColor set];
    [processBackgroundPath stroke];
    // Draw progress
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapRound;
    processPath.lineWidth = _annularLineWidth;
    endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [_progressTintColor set];
    [processPath stroke];
}
@end
