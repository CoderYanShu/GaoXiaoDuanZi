//
//  UIImage+ZYRevised.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZYRevised)

/// 从指定图像名称创建拉伸的图像。
/// @param named 图像的名称
+ (UIImage *)imageRevisedWithNamed:(NSString *)named;

@end

NS_ASSUME_NONNULL_END
