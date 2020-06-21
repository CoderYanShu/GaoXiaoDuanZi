//
//  ZYUserItme.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 用户模型
@interface ZYUserItem : NSObject

@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *icon;
@property (nonatomic ,strong) NSString *number;
@property (nonatomic ,strong) NSString *userName;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)userItemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
