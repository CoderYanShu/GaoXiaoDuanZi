//
//  ZYHeadRefreshView.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/22.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 下拉刷新
@interface ZYHeadRefreshView : UIView

@property (nonatomic ,assign) BOOL isRefreshing;
@property (nonatomic ,assign) BOOL isCanRefresh;

@end

NS_ASSUME_NONNULL_END
