//
//  ZYContentViewController.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/18.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 顶部标签栏控制器
@interface ZYTopTabBarController : UIViewController

/// 根据角标，选中对应的控制器
@property (nonatomic, assign) NSInteger selectIndex;

@end

NS_ASSUME_NONNULL_END
