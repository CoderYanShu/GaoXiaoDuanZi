//
//  ZYNetworkTool.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/12.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYNetworkTool.h"
#import <AFNetworking.h>

@implementation ZYNetworkTool

+ (void)rquestWithType:(ZYRequestType)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
     // 1.获得请求管理者
    AFHTTPSessionManager *manager = AFHTTPSessionManager.manager;
    
    //设置AFN中的安全配置
    manager.securityPolicy.allowInvalidCertificates = YES; //01 允许接收无效的证书
    manager.securityPolicy.validatesDomainName = YES;      //02 不做域名验证
    
    if (type == ZYRequestTypeGet) {
        
        [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if (success) success(responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            if (failure) failure(error);
        }];
    }
    if (type == ZYRequestTypePost) {
        
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {\
            
            if (success) success(responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            if (failure) failure(error);
        }];
    }
}
@end
