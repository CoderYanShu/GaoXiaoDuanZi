//
//  ZYUserItme.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYUserItem.h"

@implementation ZYUserItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _name = dict[@"username"];
        _icon = dict[@"header"];
        _number = dict[@"fans_count"];
        _userName = dict[@"screen_name"];
    }
    return self;
}

+ (instancetype)userItemWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}
@end
