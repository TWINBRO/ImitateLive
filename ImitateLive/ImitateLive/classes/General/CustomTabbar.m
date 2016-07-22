//
//  CustomTabbar.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 sjp. All rights reserved.
//

#import "CustomTabbar.h"

@implementation CustomTabbar

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    
    CGFloat buttonW = barWidth/4;
    CGFloat buttonH = barHeight - 2;
    
    CGFloat buttonY = 1;
    
    NSInteger index = 0;
    for (UIView *view in self.subviews) {
        NSString *viewClass = NSStringFromClass([view class]);
        if ([viewClass isEqualToString:@"UITabBarButton"]) {
            CGFloat buttonX = index * buttonW;
            if (index >= 2) {
                buttonX += buttonW;
            }
            view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index++;
        }
    }
    
}






















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
