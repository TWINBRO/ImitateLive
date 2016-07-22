//
//  CarouselCollectionViewCell.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "CarouselCollectionViewCell.h"
#import "WheelImageModel.h"
#import "HomeRequest.h"
#import "WTImageScroll.h"
#import "HomeViewController.h"
#import "RoomModel.h"

@implementation CarouselCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self requestCarouselData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        // [self setup];
    }
    return self;
}
#pragma mark 轮播图
// 请求轮播图数据
- (void)requestCarouselData {
    self.carousels = [NSMutableArray array];
    self.roomArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    HomeRequest *home = [[HomeRequest alloc] init];
    [home carouselRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        NSArray *data = [dic objectForKey:@"data"];
        for (NSDictionary *tempDic in data) {
            WheelImageModel *model = [[WheelImageModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.carousels addObject:model.spic];
            
            
            LiveModel *live = [LiveModel new];
//            NSLog(@"***************%@",model.room);
            [live setValuesForKeysWithDictionary:model.room];
            [weakSelf.roomArr addObject:live];
            
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf addCarousel];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"carousel error = %@",error);
    }];
    
}
// 获取图片并且添加轮播图
- (void)addCarousel {
    
    UIView *imageScorll=[WTImageScroll ShowNetWorkImageScrollWithFream:CGRectMake(0, -30, WindownWidth, 230) andImageArray:self.carousels andBtnClick:^(NSInteger tagValue) {
//        NSLog(@"点击的图片--%@",@(tagValue));

        if (_carouselDelegate != nil && [_carouselDelegate respondsToSelector:@selector(changeController:)]) {
            [_carouselDelegate changeController:self.roomArr[tagValue]];
        }
        
        
    }];
    imageScorll.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lun"]];
    [self.contentView addSubview:imageScorll];
}




@end
