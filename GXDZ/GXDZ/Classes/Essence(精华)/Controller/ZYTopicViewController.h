//
//  ZYTopicViewController.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/23.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTopicItem.h"

NS_ASSUME_NONNULL_BEGIN

/// 帖子控制器
@interface ZYTopicViewController : UITableViewController
/// 帖子类型
@property (nonatomic, assign) ZYTopicItemType topicType;

- (void)reload;
//- (void)tabBarItemClickRefresh;

@end

NS_ASSUME_NONNULL_END
