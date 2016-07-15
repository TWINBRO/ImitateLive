//
//  BriefTableViewCell.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BriefTableViewCell.h"

@implementation BriefTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setVideoModel:(VideoModel *)videoModel {
    
    _videoModel = videoModel;
    _titleLabel.text = videoModel.title;
    _nicknameLabel.text = videoModel.nickname;
    _levelLabel.text = [NSString stringWithFormat:@"lv%@",videoModel.hotsLevel];
    _gameNameLabel.text = [NSString stringWithFormat:@"正在直播:%@",videoModel.gameName];
    _onlineNumberLabel.text = videoModel.online;
    
}


@end
