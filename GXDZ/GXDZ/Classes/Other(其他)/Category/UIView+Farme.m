//
//  UIView+Farme.m
//  GaoXiao
//
//  Created by ZYP OnTheRoad on 2019/10/20.
//  Copyright © 2019 ZYP OnTheRoad. All rights reserved.
//

#import "UIView+Farme.h"

@implementation UIView (Farme)


- (void)setX:(CGFloat)x
{
    CGRect farme = self.frame;
    farme.origin.x = x;
    self.frame = farme;
}

- (void)setY:(CGFloat)y
{
    CGRect farme = self.frame;
    farme.origin.y = y;
    self.frame = farme;
}


- (void)setWidth:(CGFloat)width
{
    CGRect farme = self.frame;
    farme.size.width = width;
    self.frame = farme;
}

- (void)setHeight:(CGFloat)height
{
    CGRect farme = self.frame;
    farme.size.height = height;
    self.frame = farme;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (CGFloat)centerY
{
    return self.center.y;
}
@end
