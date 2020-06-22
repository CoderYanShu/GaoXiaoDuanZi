//
//  ZYPhotoManager.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/22.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

/// 保存相片到自己定义的相册
@interface ZYPhotoManager : NSObject

/// 保存相片到指定的相册
/// @param image 相片
/// @param albumTitel 相册
/// @param completed 完成后的任务
+ (void)savePhotoWithImage:(UIImage *)image albumTitel:(NSString *)albumTitel completed:(void(^)(BOOL success, NSError *error))completed;
@end

NS_ASSUME_NONNULL_END
