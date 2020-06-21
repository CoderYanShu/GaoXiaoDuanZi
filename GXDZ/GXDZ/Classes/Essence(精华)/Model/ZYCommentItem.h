//
//  ZYCYommentItme.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZYUserItem;

/// 评论模型
@interface ZYCommentItem : NSObject

@property (nonatomic ,strong) ZYUserItem *userItem;

//textLabel
@property (nonatomic ,strong) NSString *content;
@property (nonatomic ,readonly) NSString *totalContent;

//voiceView
@property (nonatomic ,strong) NSString *voiceUrl;
@property (nonatomic ,strong) NSString *voiceTime;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)commentItemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
