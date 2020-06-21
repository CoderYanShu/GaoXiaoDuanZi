//
//  ZYTopicTextView.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/20.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZYTopicItem;

/// 顶部视图, 显示头像, 名称, 发帖时间, 按钮, 正文
@interface ZYTopicTextView : UIView

@property (nonatomic, strong) ZYTopicItem *topicItem;

@end

NS_ASSUME_NONNULL_END
