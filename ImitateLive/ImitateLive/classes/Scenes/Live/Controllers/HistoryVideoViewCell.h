//
//  HistoryVideoViewCell.h
//  ImitateLive
//
//  Created by ssx on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoRelationModel.h"

@interface HistoryVideoViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *playNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) VideoRelationModel *model;

@end
