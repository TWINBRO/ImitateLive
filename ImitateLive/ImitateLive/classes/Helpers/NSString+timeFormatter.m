//
//  NSString+timeFormatter.m
//  GXMusicPlayer
//
//  Created by lanou3g on 16/5/17.
//  Copyright © 2016年 郭旭. All rights reserved.
//

#import "NSString+timeFormatter.h"

@implementation NSString (timeFormatter)

// “150”-》"02：30"
+ (NSString *)getStringFormatByTime:(CGFloat)seconds
{
    // seconds/60 分钟
    // seconds%60 秒数
    NSInteger hour = (NSInteger) seconds / 3600;
    NSInteger minute = (NSInteger) (seconds - hour * 3600) / 60;
    NSInteger second = (NSInteger) seconds % 60;
    return [NSString stringWithFormat:@"%01ld:%02ld:%02ld",hour,minute,second];
}
// "02:03"->"150"
- (CGFloat)getSecondsFormatByString
{
    NSArray * tempArray = [self componentsSeparatedByString:@":"];
    return [[tempArray firstObject] integerValue] * 60.0 * 60.0+ [tempArray[2] integerValue] * 60.0 + [[tempArray lastObject] integerValue];
}

@end
