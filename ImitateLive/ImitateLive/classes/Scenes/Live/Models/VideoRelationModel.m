//
//  VideoRelationModel.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "VideoRelationModel.h"

@implementation VideoRelationModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
         _videoRelationID = value;
    }
//    NSLog(@"%@",value);
}

@end
