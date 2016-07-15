//
//  LoginRequest.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (void)loginRequestWithUsername:(NSString *)username password:(NSString *)password success:(SuccessResponse)success failure:(FailureResponse)failure {

    NetworkRequest *request = [[NetworkRequest alloc]init];
    [request sendDataWithUrl:LoginRequest_Url parameters:@{@"userName":username,@"password":password} success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
