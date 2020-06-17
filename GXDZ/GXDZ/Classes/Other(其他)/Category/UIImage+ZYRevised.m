//
//  UIImage+ZYRevised.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "UIImage+ZYRevised.h"

@implementation UIImage (ZYRevised)

+ (UIImage *)imageRevisedWithNamed:(NSString *)named {
    
    UIImage *image = [UIImage imageNamed:named];
    
    CGFloat leftRight = image.size.width * 0.5;
    CGFloat topBottom = image.size.height * 0.5;
    UIEdgeInsets insets = UIEdgeInsetsMake(topBottom, leftRight, topBottom, leftRight);
    
    return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
}
@end
