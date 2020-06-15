//
//  ZYSubTagItem.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/15.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYSubTagItem : NSObject

@property (nonatomic ,strong) NSString *icon;
@property (nonatomic ,strong) NSString *theme;
@property (nonatomic ,strong) NSString *number;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)subTagItemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
