//
//  WheelImageModel.m
//  zhanqi
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 guo. All rights reserved.
//

#import "WheelImageModel.h"

@implementation WheelImageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _wheelID = key;
    }
}

@end
