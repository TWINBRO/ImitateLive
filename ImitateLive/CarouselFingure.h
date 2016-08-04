//
//  CarouselFingure.h
//  cUItest
//
//  Created by ssx on 16/3/29.
//  Copyright © 2016年 史京辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselFingure : UIView

@property (strong,nonatomic) NSArray *images;
@property (assign,nonatomic) NSTimeInterval duration;

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;
@property (strong,nonatomic) NSTimer *timer;

+ (UIView *)addNetScrollViewWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr;

@end
