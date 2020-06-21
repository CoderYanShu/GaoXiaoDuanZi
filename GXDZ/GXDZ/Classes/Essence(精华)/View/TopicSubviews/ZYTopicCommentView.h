//
//  ZYTopicCommentView.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZYTopicItem;
/// 最热评论视图
@interface ZYTopicCommentView : UIView

@property (nonatomic, strong) ZYTopicItem *topicItem;

@end

NS_ASSUME_NONNULL_END
