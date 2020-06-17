//
//  ZYGroupItem.h
//  城觅
//
//  Created by ZYP OnTheRoad on 2020/6/1.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 组模型
@interface ZYGroupItem : NSObject
/// 头部标题
@property (nonatomic, copy) NSString *header;
/// 尾部标题
@property (nonatomic, copy) NSString *footer;
/// 行模型数组
@property (nonatomic, strong) NSArray *rowItems;

/// 初始化指定行模型数组的组模型
/// @param items 指定的行模型数组
- (instancetype)initWithRowItems:(NSArray *)items;

/// 获取指定行模型数组的组模型
/// @param items 指定的行模型数组
+ (instancetype)groupItemWithRowItems:(NSArray *)items;

@end

NS_ASSUME_NONNULL_END
