//
//  ColumnDetailCollectionViewCell.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "ColumnDetailCollectionViewCell.h"

@implementation ColumnDetailCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(ColumnDetailModel *)model
{
    _model = model;
    [self.backImageView setImageWithURL:[NSURL URLWithString:model.spic] placeholderImage:nil];
    self.titleLabel.text = model.title;
    
    self.titleLabel.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    if ([model.gender isEqualToString:@"1"]) {
        self.genderImageView.image = [UIImage imageNamed:@"icon_room_female@2x"];
    }else{
        self.genderImageView.image = [UIImage imageNamed:@"icon_room_male@2x"];
    }
    self.nicknameLabel.text = model.nickname;
    self.peopleNamuberLabel.text = [NSString stringWithFormat:@"%@",model.online];
}

@end
