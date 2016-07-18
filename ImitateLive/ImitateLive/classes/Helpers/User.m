//
//  User.m
//  DouBanProject
//
//  Created by 李泽 on 14-9-16.
//  Copyright (c) 2016年 蓝鸥科技. All rights reserved.
//

#import "User.h"

@implementation User


#pragma mark - 重写
#pragma mark description

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", _userName, _password];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
