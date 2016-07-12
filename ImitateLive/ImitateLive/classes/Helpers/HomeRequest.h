//
//  HomeRequest.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeRequest : NSObject

- (void)homeRequestWithParameter:(NSDictionary *)parameter
                         success:(SuccessResponse)success
                         failure:(FailureResponse)failure;

- (void)carouselRequestWithParameter:(NSDictionary *)parameter
                             success:(SuccessResponse)success
                             failure:(FailureResponse)failure;

@end
