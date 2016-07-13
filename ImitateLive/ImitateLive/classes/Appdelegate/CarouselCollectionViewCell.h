//
//  CarouselCollectionViewCell.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) NSMutableArray *carousels;
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (void)requestCarouselData;
- (void)addCarousel;
@end
