//
//  Color_marco.h
//  DouBanProject
//
//  Created by lanou3g on 16/5/6.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#ifndef Color_marco_h
#define Color_marco_h

// 设置颜色
#define YD_COLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机颜色
#define YD_RANDOM_COLOR YD_COLOR(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255),1.0)
// 主题颜色
#define NAV_THEME_COLOR YD_COLOR(245,111,34,1.0)

#define TAB_THEME_COLOR YD_COLOR(248,248,248,1.0)


#endif /* Color_marco_h */
