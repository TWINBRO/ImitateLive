//
//  ColumnDetailCollectionViewCell.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnDetailModel.h"

#define ColumnDetailCollectionViewCell_Identifier @"ColumnDetailCollectionViewCell_Identifier"

@interface ColumnDetailCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UILabel *peopleNamuberLabel;

@property (nonatomic, strong) ColumnDetailModel *model;
@end
