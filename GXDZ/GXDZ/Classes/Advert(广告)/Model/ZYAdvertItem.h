//
//  ZYAdvertItem.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/12.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 广告模型
@interface ZYAdvertItem : NSObject

@property (nonatomic ,strong) NSString *pic;
@property (nonatomic ,strong) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
/// 根据字典创建模型
/// @param dict 字典
+ (instancetype)advertItemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
