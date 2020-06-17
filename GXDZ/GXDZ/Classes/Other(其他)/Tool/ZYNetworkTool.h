//
//  ZYNetworkTool.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/12.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZYRequestType) {
    ZYRequestTypeGet,
    ZYRequestTypePost,
  
};



@interface ZYNetworkTool : NSObject

+ (void)rquestWithType:(ZYRequestType)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
