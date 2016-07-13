//
//  ColumnCollectionViewCell.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameModel.h"


#define ColumnCollectionViewCell_Identifier @"ColumnCollectionViewCell_Identifier"

@interface ColumnCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *gameImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) GameModel *model;

@end
