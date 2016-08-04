//
//  LiveRequest.m
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "LiveRequest.h"

@implementation LiveRequest
// 直播页面
- (void)liveRequestWithParameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure {

    NetworkRequest *request = [[NetworkRequest alloc] init];
    NSString *ID = [parameter objectForKey:@"id"];
    [request requestWithUrl:LiveRequest_Url(ID) parameters:parameter successResponse:^(NSDictionary *dic) {
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

// 直播间历史视频(ID为uid)
- (void)historyVideoRequestWithID:(NSString *)ID success:(SuccessResponse)success failure:(FailureResponse)failure {
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@",AuthorHistoryVideoRequest_Url(ID)]];
    filePath=[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [request requestWithUrl:filePath parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}

//// 单个历史视频（url为请求到的model中的url）
//- (void)singleHistoryVideoWithUrl:(NSString *)url success:(SuccessResponse)success failure:(FailureResponse)failure {
//    
//    NetworkRequest *request = [[NetworkRequest alloc] init];
//    
//    [request requestWithUrl:SingleHistoryVideo_Url(url) parameters:nil successResponse:^(NSDictionary *dic) {
//        success(dic);
//    } failureResponse:^(NSError *error) {
//        failure(error);
//    }];
//    
//}


@end
