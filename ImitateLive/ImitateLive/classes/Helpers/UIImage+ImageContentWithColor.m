//
//  UIImage+ImageContentWithColor.m
//  DouBanProject
//
//  Created by lanou3g on 16/5/6.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "UIImage+ImageContentWithColor.h"

@implementation UIImage (ImageContentWithColor)

+(UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 绘制图片
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
