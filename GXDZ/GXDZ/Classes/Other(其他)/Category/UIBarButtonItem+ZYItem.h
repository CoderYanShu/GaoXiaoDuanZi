//
//  UIBarButtonItem+ZYItem.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (ZYItem)

+ (instancetype)itemWithNormalImage:(NSString *)normal highlightImage:(NSString *)highlight target:(id)target action:(SEL)action;

+ (instancetype)itemWithNormalImage:(NSString *)normal selectedImage:(NSString *)selected target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
