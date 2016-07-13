//
//  LiveCollectionViewCell.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"

@interface LiveCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@property (weak, nonatomic) IBOutlet UILabel *liveNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *onlineNumberLabel;

@property (strong, nonatomic) LiveModel *liveModel;

@end
