//
//  LiveRequest.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "LiveRequest.h"

@implementation LiveRequest
// 直播页面
- (void)liveRequestWithParameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure {

    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request requestWithUrl:LiveRequest_Url parameters:parameter successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}

// 直播间详情
- (void)liveDetailRequestWithParameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure {

    NetworkRequest *request = [[NetworkRequest alloc] init];
    // 此处id为主播id
    NSString *ID = [parameter objectForKey:@"id"];
    [request requestWithUrl:LiveDetailRequest_Url(ID) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}

@end
