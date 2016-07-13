//
//  LiveRequest.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveRequest : NSObject

- (void)liveRequestWithParameter:(NSDictionary *)parameter
                         success:(SuccessResponse)success
                         failure:(FailureResponse)failure;

- (void)liveDetailRequestWithParameter:(NSDictionary *)parameter
                               success:(SuccessResponse)success
                               failure:(FailureResponse)failure;

@end
