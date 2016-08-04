//
//  ColumnRequest.h
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnRequest : NSObject

- (void)allColumnRequestWithParameter:(NSDictionary *)parameter
                              success:(SuccessResponse)success
                              failure:(FailureResponse)failure;
- (void)columnRequestWithParameter:(NSDictionary *)parameter
                           success:(SuccessResponse)success
                           failure:(FailureResponse)failure;

@end
