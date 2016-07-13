//
//  LiveCollectionViewCell.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "LiveCollectionViewCell.h"

@implementation LiveCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setLiveModel:(LiveModel *)liveModel {
    
    _liveModel = liveModel;
    [_backgroundImageView setImageWithURL:[NSURL URLWithString:liveModel.spic]];
    _liveNameLabel.text = liveModel.title;
    _authorNameLabel.text = liveModel.nickname;
    _onlineNumberLabel.text = liveModel.online;
    
    if ([liveModel.gender isEqualToString:@"2"]) {
        _sexImageView.image = [UIImage imageNamed:@"male"];
    }else {
        _sexImageView.image = [UIImage imageNamed:@"female"];
    }
    
}

@end
