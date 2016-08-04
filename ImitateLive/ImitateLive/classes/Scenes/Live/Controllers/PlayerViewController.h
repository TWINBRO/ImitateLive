//
//  PlayerViewController.h
//  ImitateLive
//
//  Created by ssx on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseViewController.h"
#import "PlayerView.h"
#import "LiveModel.h"
#import "VideoRelationModel.h"
typedef void(^continuePlaying)(PlayerView *player);
@interface PlayerViewController : BaseViewController

@property (strong, nonatomic) PlayerView *playerView;
@property (strong, nonatomic) LiveModel *liveModel;
@property (strong, nonatomic) VideoRelationModel *videoRelationModel;
@property (copy, nonatomic) continuePlaying continuePlaying;
// 是否是历史视频
@property (assign, nonatomic) BOOL isHistory;

@end
