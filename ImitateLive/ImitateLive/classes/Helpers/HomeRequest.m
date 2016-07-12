//
//  HomeRequest.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "HomeRequest.h"

@implementation HomeRequest
// 首页
- (void)homeRequestWithParameter:(NSDictionary *)parameter
                         success:(SuccessResponse)success
                         failure:(FailureResponse)failure {

    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request requestWithUrl:HomeRequest_Url parameters:parameter successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}
// 首页轮播图数据
- (void)carouselRequestWithParameter:(NSDictionary *)parameter
                             success:(SuccessResponse)success
                             failure:(FailureResponse)failure {

    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request requestWithUrl:CarouselRequest_Url parameters:parameter successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}

@end
