//
//  ZYGroupItem.m
//  城觅
//
//  Created by ZYP OnTheRoad on 2020/6/1.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYGroupItem.h"

@implementation ZYGroupItem

- (instancetype)initWithRowItems:(NSArray *)items {
    
    if (self = [super init]) {
        self.rowItems = items;
    }
    return self;
}

+ (instancetype)groupItemWithRowItems:(NSArray *)items {
    
    return [[self alloc] initWithRowItems:items];
}
@end
