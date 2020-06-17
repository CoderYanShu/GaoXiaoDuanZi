//
//  ZYSquareItem.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/17.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYSquareItem.h"

@implementation ZYSquareItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.url = dict[@"url"];
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
    } return self;
}

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}
@end
