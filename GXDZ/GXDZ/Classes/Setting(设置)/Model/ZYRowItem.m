//
//  ZYRowItem.m
//  城觅
//
//  Created by ZYP OnTheRoad on 2020/6/1.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYRowItem.h"

@implementation ZYRowItem

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title {
    if (self = [super init]) {
        self.image = image;
        self.title = title;
    }
    return self;
}

+ (instancetype)rowItemWithImage:(UIImage *)image title:(NSString *)title {
    
    return [[self alloc] initWithImage:image title:title];
}
@end
