//
//  ZYRowItem.h
//  城觅
//
//  Created by ZYP OnTheRoad on 2020/6/1.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef  void(^ZYSelectRowTask)(void);

/// 行模型
@interface ZYRowItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) ZYSelectRowTask selectRowTask;

- (instancetype)initWithImage:(nullable UIImage *)image title:(NSString *)title;
+ (instancetype)rowItemWithImage:(nullable UIImage *)image title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
