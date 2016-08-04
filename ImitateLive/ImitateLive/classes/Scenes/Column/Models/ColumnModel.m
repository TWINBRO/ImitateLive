//
//  ColumnModel.m
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "ColumnModel.h"

@implementation ColumnModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _columnID = value;
    }
//    NSLog(@"%@",key);
}

@end
