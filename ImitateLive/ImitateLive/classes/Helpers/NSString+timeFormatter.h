//
//  NSString+timeFormatter.h
//  GXMusicPlayer
//
//  Created by lanou3g on 16/5/17.
//  Copyright © 2016年 郭旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (timeFormatter)

// “150”-》"02：30"
+ (NSString *)getStringFormatByTime:(CGFloat)seconds;
// "02:03"->"150"
- (CGFloat)getSecondsFormatByString;

@end
