//
//  LiveCollectionViewCell.m
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "LiveCollectionViewCell.h"

@implementation LiveCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setLiveModel:(LiveModel *)liveModel {
    
    _liveModel = liveModel;
    if ([_isLive isEqualToString:@"0"]) {
        _backgroundImageView.image = [UIImage imageNamed:@"avatar"];
    }else{
        [_backgroundImageView setImageWithURL:[NSURL URLWithString:liveModel.spic]];}
    _liveNameLabel.text = liveModel.title;
    _authorNameLabel.text = liveModel.nickname;
    _onlineNumberLabel.text = [NSString stringWithFormat:@"%@",[self number]];
    
    if ([liveModel.gender isEqualToString:@"2"]) {
        _sexImageView.image = [UIImage imageNamed:@"male"];
    }else {
        _sexImageView.image = [UIImage imageNamed:@"female"];
    }
    
}

- (NSString *)number
{
    int number = [self.liveModel.online intValue];
    int value = number / 10000;
    
    NSString *string = [NSString string];
    if (value > 0) {
        string = [NSString stringWithFormat:@"%d万",value];
    }else{
        string = [NSString stringWithFormat:@"%d",number];
    }
    return string;
}

@end
