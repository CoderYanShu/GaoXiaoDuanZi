//
//  ZYAdvertItem.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/12.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYAdvertItem.h"

@implementation ZYAdvertItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _pic = dict[@"pic"];
        _url = dict[@"url"];
    }
    return self;
}

+ (instancetype)advertItemWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}
@end
