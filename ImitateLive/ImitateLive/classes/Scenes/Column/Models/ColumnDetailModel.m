//
//  ColumnDetailModel.m
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "ColumnDetailModel.h"

@implementation ColumnDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _columnDetailID = value;
    }
//    NSLog(@"%@",key);
}

@end
