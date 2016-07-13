//
//  CarouselFingure.m
//  cUItest
//
//  Created by lanou3g on 16/3/29.
//  Copyright © 2016年 史京辉. All rights reserved.
//

#import "CarouselFingure.h"

@interface CarouselFingure ()<UIScrollViewDelegate>

@end

#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height

@implementation CarouselFingure

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _duration = 2.0;
        _timer = [NSTimer new];
    }
    return self;
}

- (void)drawView {

    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];

}

- (void)setImages:(NSArray *)images{

    [_timer invalidate];
    _timer = nil;
    if (_images != images) {
        _images = nil;
        _images = images;
    }
    [self drawView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(handleMovePage) userInfo:nil repeats:YES];

}

- (void)setDuration:(NSTimeInterval)duration{

    [_timer invalidate];
    _timer = nil;
    _duration = duration;
    _timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(handleMovePage) userInfo:nil repeats:YES];

}

NSInteger number;
- (void)handleMovePage{

    number = self.pageControl.currentPage;
    number++;
    if (number == self.images.count) {
        number = 0;
    }
    
    self.pageControl.currentPage = number;
    self.scrollView.contentOffset = CGPointMake(kWidth*self.pageControl.currentPage, 0);
    

}

- (UIScrollView *)scrollView{

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [_scrollView setContentSize:CGSizeMake(kWidth*self.images.count, kHeight)];
        
        for (int i = 0; i < self.images.count; i ++) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth*i, 0, kWidth, kHeight)];
            imgView.userInteractionEnabled = YES;
            imgView.image = self.images[i];
            imgView.contentMode = UIViewContentModeScaleToFill;
            [_scrollView addSubview:imgView];
            
        }
        
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{

    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.images.count*15, 20)];
        _pageControl.center = CGPointMake(kWidth/2, kHeight-15);
        [_pageControl setNumberOfPages:self.images.count];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    }
    return _pageControl;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [_timer invalidate];
    _timer = nil;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    self.pageControl.currentPage = self.scrollView.contentOffset.x/kWidth;
    number = self.pageControl.currentPage;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(handleMovePage) userInfo:nil repeats:YES];

}

@end
