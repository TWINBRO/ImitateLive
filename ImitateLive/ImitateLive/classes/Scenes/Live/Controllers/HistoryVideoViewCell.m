//
//  HistoryVideoViewCell.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "HistoryVideoViewCell.h"

@implementation HistoryVideoViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(VideoRelationModel *)model {
    
    _model = model;
    _titleLabel.text = model.title;
    _playNumberLabel.text = [NSString stringWithFormat:@"%@次播放",model.playCnt];
    
    _dateLabel.text = model.duration;
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:model.spic]];
    
}


@end
