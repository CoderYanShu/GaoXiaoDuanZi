//
//  UIImage+ZYRender.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "UIImage+ZYRender.h"

@implementation UIImage (ZYRender)

+ (UIImage *)imageOriginalWithNamed:(NSString *)named {
    
    return [[UIImage imageNamed:named] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
