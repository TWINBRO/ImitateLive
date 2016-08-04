//
//  ColumnCollectionViewCell.m
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "ColumnCollectionViewCell.h"

@implementation ColumnCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(GameModel *)model
{
    _model = model;
//    NSLog(@"%@",model);
    self.titleLabel.text = model.name;
    [self.gameImageView setImageWithURL:[NSURL URLWithString:model.spic] placeholderImage:nil];
}

@end
