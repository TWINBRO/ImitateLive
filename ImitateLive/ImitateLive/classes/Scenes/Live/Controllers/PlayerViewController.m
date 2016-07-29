//
//  PlayerViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "PlayerViewController.h"
#import "BigInteractiveView.h"
#import "NSString+timeFormatter.h"
#import "DefinitionView.h"
#import "SettingView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <UMSocialSnsService.h>
#import <UMSocial.h>
#import "SendBarrageView.h"

// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_ENUM(NSInteger, PanDirection){
    PanDirectionHorizontalMoved, // 横向移动
    PanDirectionVerticalMoved    // 纵向移动
};
//播放器的几种状态
typedef NS_ENUM(NSInteger, ZFPlayerState) {
    ZFPlayerStateFailed,     // 播放失败
    ZFPlayerStateBuffering,  // 缓冲中
    ZFPlayerStatePlaying,    // 播放中
    ZFPlayerStateStopped,    // 停止播放
    ZFPlayerStatePause       // 暂停播放
};

@interface PlayerViewController ()
<
    BigInteractiveViewDelegate,
    DefinitionViewDelegate,
    settingViewDelegate,
    UIGestureRecognizerDelegate,
    UMSocialUIDelegate,
    sendBarrageViewDelegate
>

@property (assign, nonatomic) CATransform3D myTransform;// 旋转屏幕

@property (strong, nonatomic) BigInteractiveView *interactiveView;// 控件视图

@property (assign, nonatomic) BOOL isPlaying;// 判断是否正在播放
@property (assign, nonatomic) BOOL isLockingScreen;// 判断是否锁屏

@property (strong, nonatomic) NSTimer *timer;// 定时器

@property (strong, nonatomic) DefinitionView *definitionView;// 清晰度视图
@property (strong, nonatomic) SettingView *settingView;// 设置视图
@property (assign, nonatomic) BOOL isBarrage;// 是否打开弹幕

/** 定义一个实例变量，保存枚举值 */
@property (nonatomic, assign) PanDirection        panDirection;
/** 用来保存快进的总时长 */
@property (nonatomic, assign) CGFloat             sumTime;
/** 播发器的几种状态 */
@property (nonatomic, assign) ZFPlayerState       state;
/** 从xx秒开始播放视频跳转 */
@property (nonatomic, assign) NSInteger            seekTime;
/** 是否在调节音量*/
@property (nonatomic, assign) BOOL                isVolume;
/** 音量滑杆 */
@property (nonatomic, strong) UISlider            *volumeViewSlider;
@property (strong, nonatomic) UIImageView *volumnImage;// 音量图标

@property (strong, nonatomic) SendBarrageView *sendView;// 写弹幕的视图
@property (strong, nonatomic) NSMutableArray *danMuArr;
@property (strong, nonatomic) UIView *showDanmuView;// 显示弹幕的视图
@property (assign, nonatomic) CGFloat DanmuSize;// 弹幕大小
@property (assign, nonatomic) CGFloat DanmuAlpha;// 弹幕透明度
// 聊天室
@property (strong, nonatomic) AVIMClient *client;
@property (strong, nonatomic) AVIMConversation *conversation;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
    
    // 清晰度调整视图
    self.definitionView = [[DefinitionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.height, self.view.frame.size.width)];
    self.definitionView.delegate = self;
    [self.view addSubview:self.definitionView];
    self.definitionView.hidden = YES;// 隐藏清晰度视图
    
    // 设置按钮视图
    self.settingView = [[SettingView alloc] initWithFrame:CGRectMake(self.playerView.frame.size.height - 45, 0, self.view.frame.size.width / 2.0, self.view.frame.size.height)];
    self.settingView.delegate = self;
    [self.view addSubview:self.settingView];
    self.settingView.hidden = YES;// 隐藏设置按钮视图
    
    self.isBarrage = YES;// 是否打开弹幕
    
    [self addGestureRecognizer];
    
    // 获取系统音量
    [self configureVolume];
    
    [self timerBegin];
    
    // 写弹幕的视图
    self.sendView = [[SendBarrageView alloc] initWithFrame:CGRectMake(0, 0, WindowHeight, WindownWidth)];
    self.sendView.delegate = self;
    [self.view addSubview:self.sendView];
    self.sendView.hidden = YES;
    
    self.DanmuSize = 30.0;
    self.DanmuAlpha = 1.0;
    
    [self queryConversationByConditions];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didreceiveMessageNotification:) name:@"message" object:nil];
}

- (void)addView
{
    self.playerView.frame = CGRectMake(0, 0, WindowHeight, WindownWidth);
    // 用户交互视图
    self.interactiveView = [[BigInteractiveView alloc] initWithFrame:self.playerView.frame];
    self.interactiveView.isHistory = self.isHistory;
    self.interactiveView.delegate = self;
    self.playerView.playerLayer.frame = self.playerView.frame;
    [UIView animateWithDuration:0.3 animations:^{
        CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
        //
        _playerView.layer.transform  =  transform;
        _playerView.center = self.view.center;
        
    } completion:^(BOOL finished) {
        _playerView.center = self.view.center;
    }];
    
    [self.view.layer addSublayer:self.playerView.playerLayer];
    
    // 显示弹幕视图
    self.showDanmuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowHeight, WindownWidth)];
    [self.view addSubview:self.showDanmuView];
    self.showDanmuView.hidden = NO;
    [self.view addSubview:self.interactiveView];
    
    self.interactiveView.titleLabel.text = self.liveModel.title;
    self.volumnImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.volumnImage.center = CGPointMake(self.view.frame.size.height / 2.0, self.view.frame.size.width / 2.0);
    [self.view addSubview:self.volumnImage];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.playerView.player play];
    self.isPlaying = YES;
    self.isLockingScreen = NO;
    // 判断是否是历史相关视频
    if (self.isHistory) {
        self.interactiveView.onlineImage.image = [UIImage imageNamed:@"ic_broadcastroom_video_pressed@2x"];
        self.interactiveView.onlineLabel.text = self.videoRelationModel.playCnt;
        self.interactiveView.longTimeLabel.text = self.videoRelationModel.duration;
    }else{
        self.interactiveView.onlineImage.image = [UIImage imageNamed:@"ic_broadcastroom_intro_pressed@2x"];
        self.interactiveView.onlineLabel.text = self.liveModel.online;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.playerView.player pause];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}
#pragma mark -- 代理方法
// 返回按钮
- (void)backLastViewController:(UIButton *)button
{
    self.continuePlaying(self.playerView);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
// 全屏按钮
- (void)fullScreenAction:(UIButton *)button
{
    self.continuePlaying(self.playerView);
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 分享按钮
- (void)shareVideoAction:(UIButton *)button
{
    [UMSocialData defaultData].extConfig.title = @"转发到微博";
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.liveModel.spic];
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"578c804167e58e5c90000c6b"
                                      shareText:[NSString stringWithFormat:@"我正在#战旗TV#观看大神%@的现场直播：【%@】，精彩炫酷，大家速速来围观！http://www.zhanqi.tv%@（分享自@战旗TV直播平台）",self.liveModel.nickname,self.liveModel.title,self.liveModel.url] // 分享的内容
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:self];
}
// 播放按钮
- (void)playOrPauseAction:(UIButton *)buttton
{
    [self playOrPause:buttton];
}
- (void)playOrPause:(UIButton *)button
{
    if (self.isPlaying) {
        [self.playerView.player pause];
        [button setImage:[UIImage imageNamed:@"movie_playsmall@2x"] forState:UIControlStateNormal];
        self.isPlaying = NO;
    }else{
        [self.playerView.player play];
        [button setImage:[UIImage imageNamed:@"movie_pausesmall@2x"] forState:UIControlStateNormal];
        self.isPlaying = YES;
    }
}
// 锁屏按钮
- (void)lockScreenAction:(UIButton *)button
{
    if (!self.isLockingScreen) {
        self.isLockingScreen = YES;
        
        [button setImage:[UIImage imageNamed:@"movie_lock@2x"] forState:UIControlStateNormal];
        [button setTitle:@"锁屏" forState:UIControlStateNormal];
        self.interactiveView.topBackgroundView.hidden = YES;
        self.interactiveView.bottomBackgroundView.hidden = YES;
        self.interactiveView.shareBtn.hidden = YES;
    }else{
        self.isLockingScreen = NO;
        [button setImage:[UIImage imageNamed:@"movie_unlock@2x"] forState:UIControlStateNormal];
        [button setTitle:@"解锁" forState:UIControlStateNormal];
        self.interactiveView.topBackgroundView.hidden = NO;
        self.interactiveView.bottomBackgroundView.hidden = NO;
        self.interactiveView.shareBtn.hidden = NO;
    }
    
}

// 设置按钮
- (void)settingAction:(UIButton *)button
{
    self.settingView.frame = CGRectMake(self.view.frame.size.width /2.0, 0, self.view.frame.size.width / 2.0, self.view.frame.size.height);
    [self.timer invalidate];
    self.interactiveView.hidden = YES;
    self.settingView.hidden = NO;
}
// 清晰度按钮
- (void)definitionAction:(UIButton *)button
{
    self.definitionView.frame = self.view.frame;
    [self.timer invalidate];
    self.interactiveView.hidden = YES;
    self.definitionView.hidden = NO;
}
#pragma mark -- 弹幕视图
/**
 *  创建界面上显示的弹幕Label
 *
 *  @param titleString 显示的字幕
 */
- (void)createLabelWithTitle:(NSString *)titleString {
    
    NSString *waitDisplayString = titleString;
    if (!(titleString && titleString.length != 0)) {
        u_int32_t index = arc4random_uniform((u_int32_t)self.danMuArr.count);
        waitDisplayString = self.danMuArr[index];
    }
    
    // y 坐标
    int yPoint = arc4random_uniform(CGRectGetHeight(self.showDanmuView.bounds)-45-25)+45;
    // 当期弹幕Label的长度
    float labelLength = waitDisplayString.length*self.DanmuSize;
    
    UILabel *waitDisplayLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds), yPoint, labelLength, self.DanmuSize)];
    waitDisplayLabel.text = waitDisplayString;
    waitDisplayLabel.backgroundColor = [UIColor clearColor];
    waitDisplayLabel.textColor = [self randomColor];
    waitDisplayLabel.font = [UIFont systemFontOfSize:self.DanmuSize];
    // 若弹幕为自己发送的，将Label的边框显示为白色并且宽带为1
    if (titleString && titleString.length != 0) {
        waitDisplayLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        waitDisplayLabel.layer.borderWidth = 1.0f;
    }
    
    [self.showDanmuView addSubview:waitDisplayLabel];
    
    // 给当前弹幕Label增加向左移动的动画
    [self moveAnimation:waitDisplayLabel];
}

/**
 *  产生随意的Label颜色
 *
 *  @return 对应的Label颜色
 */
- (UIColor *)randomColor {
    UIColor *randomColorSend = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:self.DanmuAlpha];
    return randomColorSend;
}

/**
 *  弹幕Label向左滚动动作
 *
 *  @param waitMoveLabel 待滚动的Label的距离
 */
- (void)moveAnimation:(UILabel *)waitMoveLabel {
    [UIView animateWithDuration:4 animations:^{
        waitMoveLabel.center = CGPointMake(waitMoveLabel.center.x-CGRectGetMaxX(waitMoveLabel.frame), waitMoveLabel.center.y);
    } completion:^(BOOL finished) {
        if (finished) {
            [waitMoveLabel removeFromSuperview];
        }
    }];
}

// 是否打开弹幕
- (void)isBarrageAction:(UIButton *)button
{
    if (self.isBarrage) {
        [self.interactiveView.isBarrage setImage:[UIImage imageNamed:@"movie_subtitle_off@2x"] forState:UIControlStateNormal];
        self.showDanmuView.hidden = YES;
        self.isBarrage = NO;
    }else{
        [self.interactiveView.isBarrage setImage:[UIImage imageNamed:@"movie_subtitle_on@2x"] forState:UIControlStateNormal];
        self.showDanmuView.hidden = NO;
        self.isBarrage = YES;
    }
}
// 弹出发送弹幕界面
- (void)sendBarrageAction:(UIButton *)button
{
    self.sendView.hidden = NO;
    [self.sendView.barrageTextView becomeFirstResponder];
}
// 拖动进度条
- (void)progressSLiderValueChangedAction:(UISlider *)progress
{
    [self.timer invalidate];
    CGFloat longTime = [self.videoRelationModel.duration getSecondsFormatByString];
    [self.playerView.player seekToTime:CMTimeMakeWithSeconds(progress.value * longTime, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
//        NSLog(@"Complete. Current Time: %f", CMTimeGetSeconds(self.playerView.player.currentTime));
    }];
    if (progress.value == 1) {
        [self.playerView.player seekToTime:kCMTimeZero];
        [self.playerView.player pause];
        [self.interactiveView.playOrPauseBtn setImage:[UIImage imageNamed:@"movie_playsmall@2x"] forState:UIControlStateNormal];
        progress.value = 0;
    }
    else {
        //        [self.player pause];
    }
    [self timerBegin];
}
#pragma mark -- 发送弹幕代理
- (void)sendBarrageClickAction:(UIButton *)button
{
    self.sendView.hidden = YES;
    NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    
    __weak typeof(self) weakSelf = self;
    
    AVIMTextMessage *message = [AVIMTextMessage messageWithText:self.sendView.barrageTextView.text attributes:@{@"userName":currentUsername}];
    
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        [weakSelf.conversation sendMessage:message  callback:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"发送成功！");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.danMuArr addObject:message];
                    [weakSelf createLabelWithTitle:message.text];
                });
            }else if (error){
                NSLog(@"%@",error);
            }
        }];
    }];
}
// 查询聊天室
- (void)queryConversationByConditions {
    // Tom 创建了一个 client，用自己的名字作为 clientId
    __weak typeof(self) weakSelf = self;
    self.client = [[AVIMClient alloc] initWithClientId:@"tom"];
    // Tom 打开 client
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // Tom 创建属性中 topic 是 movie 的查询
        AVIMConversationQuery *query = [weakSelf.client conversationQuery];
        [query whereKey:@"name" equalTo:weakSelf.liveModel.nickname];
        // 额外调用一次确保查询的是聊天室而不是普通对话
        [query whereKey:@"tr" equalTo:@(YES)];
        [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"queryConversation error = %@",error);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (objects.count != 0) {
                    weakSelf.conversation = [objects firstObject];
                    //   [weakSelf joinConversation];// 加入聊天室
                    
                }else{
                    
                }
            });
            
        }];
    }];
    
}
- (void)didreceiveMessageNotification:(NSNotification *)notify
{
    NSDictionary *userInfo = notify.userInfo;
    [self createLabelWithTitle:[userInfo objectForKey:@"message"]];
}
#pragma mark --清晰度代理方法
- (void)adjustDefinitionAction:(UIButton *)button definition:(Definition)definition
{
    self.definitionView.frame = CGRectMake(0, self.playerView.frame.size.height, self.playerView.frame.size.width, self.playerView.frame.size.height);
    
    switch (definition) {
            case superDefinition:
            [self.interactiveView.definitionBtn setImage:[UIImage imageNamed:@"btn_cq_pressed@2x"] forState:UIControlStateNormal];
            break;
            case highDefinition:
            [self.interactiveView.definitionBtn setImage:[UIImage imageNamed:@"btn_gq_pressed@2x"] forState:UIControlStateNormal];
            break;
            case standardDefinition:
            [self.interactiveView.definitionBtn setImage:[UIImage imageNamed:@"btn_bq_pressed@2x"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    //TODO: 记录切换分辨率的时刻
//    NSInteger currentTime = (NSInteger)CMTimeGetSeconds([self.playerView.player currentTime]);
    
//    NSString *videoStr = self.videoURLArray[button.tag-200];
//    NSURL *videoURL = [NSURL URLWithString:videoStr];
//    if ([videoURL isEqual:self.videoURL]) { return; }
//    self.isChangeResolution = YES;
//    // reset player
//    [self resetToPlayNewURL];
//    self.videoURL = videoURL;
//    // 从xx秒播放
//    self.seekTime = currentTime;
//    // 切换完分辨率自动播放
//    [self autoPlayTheVideo];
    
    [self timerBegin];
    self.interactiveView.hidden = NO;
}
#pragma mark --设置按钮代理方法
// 弹幕大小
- (void)barrageSizeAction:(UIButton *)button size:(barrageSize)size
{
    switch (size) {
        case bigBarrageSize:
            self.DanmuSize = 50.0;
            break;
        case middleBarrageSize:
            self.DanmuSize = 30.0;
            break;
        case littleBarrageSize:
            self.DanmuSize = 17.0;
            break;
        default:
            break;
    }
}
// 弹幕透明度
- (void)barrageTransparencySliderValueChanged:(UISlider *)slider
{
    float alpha = slider.value;
    self.DanmuAlpha = alpha;
}
// 弹幕位置
- (void)barragePositionAction:(UIButton *)button position:(barragePosition)position
{
    switch (position) {
        case topScreen:
            self.showDanmuView.frame = CGRectMake(0, 0, WindownWidth, WindowHeight / 2.0);
            break;
        case fullScreen:
            self.showDanmuView.frame = CGRectMake(0, 0, WindowHeight, WindownWidth);
            break;
        case bottomScreen:
            self.showDanmuView.frame = CGRectMake(0, WindowHeight / 2.0, WindownWidth, WindowHeight / 2.0);
            break;
        default:
            break;
    }
}
#pragma mark --定时休眠
- (void)timeSleepSwitchAction:(UISwitch *)timeSwitch
{
    if (timeSwitch.isOn) {
        [UIApplication sharedApplication].idleTimerDisabled = NO;
    }else{
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
}
/**
 *  定时器
 */
- (void)timerBegin
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
}
- (void)timeAction:(NSTimer *)timer
{
    // 改变播放的进度
    CMTime current = self.playerView.player.currentTime;
    CGFloat f = current.value/current.timescale;
    self.interactiveView.nowTimeLabel.text = [NSString getStringFormatByTime:f];
    self.interactiveView.progressSlider.value = f / CMTimeGetSeconds(self.playerView.playerItem.duration);
    static int i = 1;
    if (i % 7 == 0) {
        self.interactiveView.hidden = YES;
    }
    i++;
}
#pragma mark -- UIPanGestureRecognizer
#pragma mark -- 添加手势
- (void)addGestureRecognizer
{
    // 滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDirection:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    // 添加轻拍手势
    // 单击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    // 双击(播放/暂停)
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    [tap requireGestureRecognizerToFail:doubleTap];
}

/**
 *  pan拖动手势事件
 *
 *  @param pan UIPanGestureRecognizer
 */
- (void)panDirection:(UIPanGestureRecognizer *)pan
{
    //根据在view上Pan的位置，确定是调音量还是亮度
    CGPoint locationPoint = [pan locationInView:self.view];
    // 我们要响应水平移动和垂直移动
    // 根据上次和本次移动的位置，算出一个速率的point
    CGPoint veloctyPoint = [pan velocityInView:self.view];
    // 判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{// 开始移动
            // 使用绝对值来判断移动方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) {// 水平移动
                // 取消隐藏
                self.interactiveView.horizontalLabel.hidden = NO;// 快进快退label
                self.panDirection = PanDirectionHorizontalMoved;
                // 给sumTime初值
                CMTime time = self.playerView.player.currentTime;
                self.sumTime = time.value / time.timescale;
                // 暂停视频播放
                [self.playerView.player pause];
                // 暂停timer
                [self.timer invalidate];
            }else if (x < y){ // 垂直移动
                self.volumnImage.hidden = NO;
                self.panDirection = PanDirectionVerticalMoved;
                // 开始滑动的时候，状态改为正在控制音量
                if (locationPoint.x > self.view.bounds.size.width / 2) {
                    self.isVolume = YES;
                }else{// 状态改为显示亮度
                    self.isVolume = NO;
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{// 正在移动
            switch (self.panDirection) {
                case PanDirectionHorizontalMoved:{
                    [self horizontalMoved:veloctyPoint.x];// // 水平移动的方法只要x方向的值
                    break;
                }
                case PanDirectionVerticalMoved:{
                    [self verticalMoved:veloctyPoint.y]; // 垂直移动方法只要y方向的值
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{ // 移动停止
            // 移动结束也需要判断垂直或者平移
            // 比如水平移动结束时，要快进到指定位置，如果这里没有判断，当我们调节音量完之后，会出现屏幕跳动的bug
            switch (self.panDirection) {
                case PanDirectionHorizontalMoved:{
                    // 继续播放
                    [self.playerView.player play];
                    [self timerBegin];
                    // 隐藏视图
                    self.interactiveView.horizontalLabel.hidden = YES;
                    
                    [self seekToTime:self.sumTime completionHandler:nil];
                    // 把sumTime滞空，不然会越加越多
                    self.sumTime = 0;
                    break;
                }
                case PanDirectionVerticalMoved:{
                    // 垂直移动结束后，把状态改为不再控制音量
                    self.isVolume = NO;
                    self.interactiveView.horizontalLabel.hidden = YES;
                    self.volumnImage.hidden = YES;
                    break;
                }
                default:
                    break;
            }
        }
        default:
            break;
    }
}
/**
 *  从xx秒开始播放视频跳转
 *
 *  @param dragedSeconds 视频跳转的秒数
 */
- (void)seekToTime:(NSInteger)dragedSeconds completionHandler:(void (^)(BOOL finished))completionHandler
{
    if (self.playerView.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        // seekTime:completionHandler:不能精确定位
        // 如果需要精确定位，可以使用seekToTime:toleranceBefore:toleranceAfter:completionHandler:
        // 转换成CMTime才能给player来控制播放进度
        CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
        [self.playerView.player seekToTime:dragedCMTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
            // 视频跳转回调
            if (completionHandler) { completionHandler(finished); }
            // 如果点击了暂停按钮
            if (!self.isPlaying) return ;
            [self.playerView.player play];
            self.seekTime = 0;
            if (!self.playerView.playerItem.isPlaybackLikelyToKeepUp) {
                self.state = ZFPlayerStateBuffering;
            }
            
        }];
    }
}
/**
 *  设置播放的状态
 *
 *  @param state ZFPlayerState
 */
- (void)setState:(ZFPlayerState)state
{
    _state = state;
    if (state == ZFPlayerStatePlaying) {
        // 改为黑色的背景，不然站位图会显示
        UIImage *image = [self buttonImageFromColor:[UIColor blackColor]];
        self.playerView.layer.contents = (id) image.CGImage;
    } else if (state == ZFPlayerStateFailed) {
        
    }
    // 控制菊花显示、隐藏
    state == ZFPlayerStateBuffering ? ([self.interactiveView.activity startAnimating]) : ([self.interactiveView.activity stopAnimating]);
}
/**
 *  通过颜色来生成一个纯色图片
 */
- (UIImage *)buttonImageFromColor:(UIColor *)color
{
    CGRect rect = self.view.bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}
/**
 *  pan水平移动的方法
 *
 *  @param value void
 */
- (void)horizontalMoved:(CGFloat)value
{
    // 快进快退的方法
    NSString *style = @"";
    if (value < 0) { style = @"<<"; }
    if (value > 0) { style = @">>"; }
    // 每次滑动需要叠加时间
    self.sumTime += value / 200;
    
    // 需要限定sumTime的范围
    CMTime totalTime           = self.playerView.playerItem.duration;
    CGFloat totalMovieDuration = (CGFloat)totalTime.value/totalTime.timescale;
    if (self.sumTime > totalMovieDuration) { self.sumTime = totalMovieDuration;}
    if (self.sumTime < 0){ self.sumTime = 0; }
    
    // 当前快进的时间
    NSString *nowTime         = [NSString getStringFormatByTime:self.sumTime];
    // 总时间
    NSString *durationTime    = [NSString getStringFormatByTime:totalMovieDuration];
    // 给label赋值
    self.interactiveView.horizontalLabel.text = [NSString stringWithFormat:@"%@ %@ / %@",style, nowTime, durationTime];
}
/**
 *  pan垂直移动的方法
 *
 *  @param value void
 */
- (void)verticalMoved:(CGFloat)value
{
    
    if (self.isVolume) {
        self.volumeViewSlider.value -= value / 10000;
        NSInteger volumeNumber = (NSInteger)(self.volumeViewSlider.value * 3);
//        NSLog(@"%f",self.volumeViewSlider.value);
        self.volumnImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"volume_%ld@2x",volumeNumber]];
    }else{
        [UIScreen mainScreen].brightness -= value / 10000;
        NSInteger brightNumber = (NSInteger)([UIScreen mainScreen].brightness * 4);
//        NSLog(@"%f",[UIScreen mainScreen].brightness);
        self.volumnImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"brightness_%ld@2x",(long)brightNumber]];
    }
}
/**
 *  获取系统音量
 */
- (void)configureVolume
{
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    _volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    
    // 使用这个category的应用不会随着手机静音键打开而静音，可在手机静音下播放声音
    NSError *setCategoryError = nil;
    BOOL success = [[AVAudioSession sharedInstance]
                    setCategory: AVAudioSessionCategoryPlayback
                    error: &setCategoryError];
    
    if (!success) { /* handle the error in setCategoryError */ }
    
    // 监听耳机插入和拔掉通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:) name:AVAudioSessionRouteChangeNotification object:nil];
}

/**
 *  耳机插入、拔出事件
 */
- (void)audioRouteChangeListenerCallback:(NSNotification*)notification
{
    NSDictionary *interuptionDict = notification.userInfo;
    
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
            
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // 耳机插入
            break;
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
            // 耳机拔掉
            // 拔掉耳机继续播放
            [self.playerView.player play];
            break;
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
            break;
    }
}
- (void)tapAction:(UITapGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    UIView *hitView = [self.view hitTest:point withEvent:nil];
    if (point.x < self.view.frame.size.width / 2.0 || hitView != self.settingView) {
        self.settingView.hidden = YES;
        self.settingView.frame = CGRectMake(self.playerView.frame.size.height, 0, self.view.frame.size.width / 2.0, self.view.frame.size.height);
        [self.timer invalidate];
        self.interactiveView.hidden = NO;
        if (self.isLockingScreen) {
            self.interactiveView.topBackgroundView.hidden = YES;
            self.interactiveView.bottomBackgroundView.hidden = YES;
            self.interactiveView.shareBtn.hidden = YES;
        }else{
            self.interactiveView.topBackgroundView.hidden = NO;
            self.interactiveView.bottomBackgroundView.hidden = NO;
            self.interactiveView.shareBtn.hidden = NO;
        }
        [self timerBegin];
    }else{
        
    }
    
}
- (void)doubleTapAction:(UITapGestureRecognizer *)gesture
{
    [self playOrPause:self.interactiveView.playOrPauseBtn];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
