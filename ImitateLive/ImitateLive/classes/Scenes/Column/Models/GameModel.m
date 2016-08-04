//
//  GameModel.m
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _gameID = value;
    }
//    NSLog(@"%@",key);
}

@end
