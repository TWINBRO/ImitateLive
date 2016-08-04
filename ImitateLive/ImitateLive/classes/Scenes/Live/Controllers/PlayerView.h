//
//  PlayerView.h
//  ImitateLive
//
//  Created by ssx on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
// 引入视频播放器框架
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView

@property (strong, nonatomic) AVPlayerItem *playerItem;

@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@property (strong, nonatomic) AVPlayer *player;

@property (strong, nonatomic) UIView *interactiveView;// 添加控件的页面

- (id)initWithUrl:(NSString *)url frame:(CGRect)frame;

@property (assign, nonatomic) BOOL isPlaying;

@end
