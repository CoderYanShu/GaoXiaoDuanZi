//
//  ZYSettingBaseViewController.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/17.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZYGroupItem.h"
#import "ZYRowItem.h"
#import "ZYArrowItem.h"
#import "ZYSwitchItem.h"

#import "ZYSettingCell.h"

NS_ASSUME_NONNULL_BEGIN

/// 设置控制器 基类
@interface ZYSettingBaseViewController : UITableViewController

/// 组模型数组
@property (nonatomic, strong) NSMutableArray *groups;

@end

NS_ASSUME_NONNULL_END
