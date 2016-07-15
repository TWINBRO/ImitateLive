//
//  HomeViewController.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 sjp. All rights reserved.
//

#import "BaseViewController.h"
#import "WheelImageModel.h"
#import "RoomModel.h"
#import "LiveModel.h"
@interface HomeViewController : BaseViewController
@property (strong, nonatomic) WheelImageModel *carouselModel;
@property (strong, nonatomic) RoomModel *roomModel;
@property (strong, nonatomic) LiveModel *livemodel;
@end
