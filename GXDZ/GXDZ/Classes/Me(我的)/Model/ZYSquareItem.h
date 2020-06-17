//
//  ZYSquareItem.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/17.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYSquareItem : NSObject

@property (nonatomic ,strong) NSString *url;
@property (nonatomic ,strong) NSString *icon;
@property (nonatomic ,strong) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
