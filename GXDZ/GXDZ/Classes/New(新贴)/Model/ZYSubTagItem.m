//
//  ZYSubTagItem.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/15.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYSubTagItem.h"

@implementation ZYSubTagItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.icon = dict[@"image_list"];
        self.theme = dict[@"theme_name"];
        self.number = dict[@"sub_number"];
    }
    return self;
}

+ (instancetype)subTagItemWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}
@end
