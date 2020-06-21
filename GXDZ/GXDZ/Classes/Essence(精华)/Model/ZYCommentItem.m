//
//  ZYCYommentItme.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYCommentItem.h"
#import "ZYUserItem.h"

@implementation ZYCommentItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _content = dict[@"content"];
        _voiceUrl = dict[@"voiceuri"];
        _voiceTime = dict[@"voicetime"];
        _userItem = [ZYUserItem userItemWithDict:dict[@"user"]];
    }
    return self;
}

+ (instancetype)commentItemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (NSString *)totalCContent {
    return  [NSString stringWithFormat:@"%@: %@",self.userItem.name,self.content];
}
@end
