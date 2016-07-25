//
//  BriefTableViewCell.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BriefTableViewCell.h"

//#import "DataBaseHandle.h"
#import "SeverHandle.h"

@implementation BriefTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLiveModel:(LiveModel *)liveModel {

    _liveModel = liveModel;
    
}


-(void)setVideoModel:(VideoModel *)videoModel {
    
    _videoModel = videoModel;
    _titleLabel.text = videoModel.title;
    _nicknameLabel.text = videoModel.nickname;
    _levelLabel.text = [NSString stringWithFormat:@"lv%@",videoModel.hotsLevel];
    _gameNameLabel.text = [NSString stringWithFormat:@"正在直播:%@",videoModel.gameName];
    _onlineNumberLabel.text = videoModel.online;
    
}
- (IBAction)collectButtonClicked:(id)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] isEqualToString:@"0"]) {
        
        if (_alertDelegate != nil && [_alertDelegate respondsToSelector:@selector(addAlertController)]) {
            [_alertDelegate addAlertController];
        }
        
    }else {
    
        // 判断是否已经收藏
        BOOL isFavorite = [[SeverHandle shareInstance] isFavoriteLiveModelWithID:_liveModel.liveID];
        
        // 是否已经收藏
        if (YES == isFavorite) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"取消订阅" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            [self.contentView addSubview:alert];
            [self.collectButton setTitle:@"订阅" forState:UIControlStateNormal];
            self.collectButton.backgroundColor = [UIColor colorWithRed:18/255.0 green:186/255.0 blue:255/255.0 alpha:1];
            [[SeverHandle shareInstance] deleteLiveModel:_liveModel];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION" object:nil];
            return;
        }
        
        //操作数据库，收藏活动
        [[SeverHandle shareInstance] insertNewLiveModel:_liveModel];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"订阅成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [self.collectButton setTitle:@"已订阅" forState:UIControlStateNormal];
        self.collectButton.backgroundColor = [UIColor lightGrayColor];
        
    }
    
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION" object:nil];
   
}


@end
