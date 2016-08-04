//
//  ColumnRequest.m
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "ColumnRequest.h"

@implementation ColumnRequest
// 所有栏目
- (void)allColumnRequestWithParameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure {

    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    NSString *ID = [parameter objectForKey:@"id"];
    [request requestWithUrl:AllColumnRequest_Url(ID) parameters:parameter successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}
// 每个栏目详情
- (void)columnRequestWithParameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure {

    NetworkRequest *request = [[NetworkRequest alloc] init];
    NSString *ID = [parameter objectForKey:@"id"];
    [request requestWithUrl:ColumnDetailRequest_Url(ID) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}

@end
