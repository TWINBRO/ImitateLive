//
//  HomeModel.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _homeID = value;
    }
    NSLog(@"%@",value);
}

@end
