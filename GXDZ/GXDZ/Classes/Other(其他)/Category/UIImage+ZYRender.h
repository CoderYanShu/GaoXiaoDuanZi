//
//  UIImage+ZYRender.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZYRender)

/// 未经渲染的原始图片
/// @param named 图片名称
+ (UIImage *)imageOriginalWithNamed:(NSString *)named;

@end

NS_ASSUME_NONNULL_END
