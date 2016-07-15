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
float kDeviceFactor = 1.0;
float kDeviceWidth = 320.0;
float kDeviceHeight = 568.0;

@interface PlayerViewController ()
<
    BigInteractiveViewDelegate,
    DefinitionViewDelegate,
    settingViewDelegate
>

@property (assign, nonatomic) CATransform3D myTransform;// 旋转屏幕

@property (strong, nonatomic) BigInteractiveView *interactiveView;// 控件视图

@property (assign, nonatomic) BOOL isPlaying;// 判断是否正在播放
@property (assign, nonatomic) BOOL isLockingScreen;// 判断是否锁屏

@property (strong, nonatomic) NSTimer *timer;// 定时器

@property (strong, nonatomic) DefinitionView *definitionView;// 清晰度视图
@property (strong, nonatomic) SettingView *settingView;// 设置视图
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self.view addSubview:self.interactiveView];
    
    self.interactiveView.titleLabel.text = self.liveModel.title;
    
    // 清晰度调整视图
    self.definitionView = [[DefinitionView alloc] initWithFrame:CGRectMake(0, self.playerView.frame.size.height, self.playerView.frame.size.width, self.playerView.frame.size.height)];
    self.definitionView.delegate = self;
    [self.view addSubview:self.definitionView];
    
    // 设置按钮视图
    self.settingView = [[SettingView alloc] initWithFrame:CGRectMake(self.playerView.frame.size.height, 0, self.view.frame.size.width / 2.0, self.view.frame.size.height)];
    self.settingView.delegate = self;
    [self.view addSubview:self.settingView];
    
    [self timerBegin];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.playerView.player play];
    self.isPlaying = YES;
    self.isLockingScreen = NO;
    if (self.isHistory) {
        self.interactiveView.nowTimeLabel.text = self.videoRelationModel.duration;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.playerView.player pause];
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
    
}
// 分享按钮
- (void)shareVideoAction:(UIButton *)button
{
    
}
// 播放按钮
- (void)playOrPauseAction:(UIButton *)buttton
{
    if (self.isPlaying) {
        [self.playerView.player pause];
        [buttton setImage:[UIImage imageNamed:@"movie_playsmall@2x"] forState:UIControlStateNormal];
        self.isPlaying = NO;
    }else{
        [self.playerView.player play];
        [buttton setImage:[UIImage imageNamed:@"movie_pausesmall@2x"] forState:UIControlStateNormal];
        self.isPlaying = YES;
    }
}
// 锁屏按钮
- (void)lockScreenAction:(UIButton *)button
{
    if (!self.isLockingScreen) {
        self.isLockingScreen = YES;
        
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setTitle:@"锁屏" forState:UIControlStateNormal];
        self.interactiveView.topBackgroundView.hidden = YES;
        self.interactiveView.bottomBackgroundView.hidden = YES;
        self.interactiveView.shareBtn.hidden = YES;
    }else{
        self.isLockingScreen = NO;
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
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
}
// 清晰度按钮
- (void)definitionAction:(UIButton *)button
{
    self.definitionView.frame = self.view.frame;
    [self.timer invalidate];
    self.interactiveView.hidden = YES;
}
// 是否打开弹幕
- (void)isBarrageAction:(UIButton *)button
{
    
}
// 拖动进度条
- (void)progressSLiderValueChangedAction:(UISlider *)progress
{
    [self.timer invalidate];
    CGFloat longTime = [self.videoRelationModel.duration getSecondsFormatByString];
    [self.playerView.player seekToTime:CMTimeMakeWithSeconds(progress.value * longTime, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        NSLog(@"Complete. Current Time: %f", CMTimeGetSeconds(self.playerView.player.currentTime));
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
#pragma mark --清晰度代理方法
// 超清
- (void)superDefinitionAction:(UIButton *)buttton
{
    [self definitionClick];
}
// 高清
- (void)highDefinitionAction:(UIButton *)buttton
{
    [self definitionClick];
}
// 标清
- (void)standardDefinition:(UIButton *)buttton
{
    [self definitionClick];
}
- (void)definitionClick
{
    self.definitionView.frame = CGRectMake(0, self.playerView.frame.size.height, self.playerView.frame.size.width, self.playerView.frame.size.height);
    [self timerBegin];
    self.interactiveView.hidden = NO;
}
#pragma mark --设置按钮代理方法
// 弹幕大小
- (void)barrageSizeAction:(UIButton *)button size:(barrageSize)size
{
    
}
// 弹幕透明度
- (void)barrageTransparencySliderValueChanged:(UISlider *)slider
{
    
}
// 弹幕位置
- (void)barragePositionAction:(UIButton *)button position:(barragePosition)position
{
    
}
#pragma mark --定时休眠
- (void)timeSleepSwitchAction:(UISwitch *)timeSwitch
{
    
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
    if (i % 5 == 0) {
        self.interactiveView.hidden = YES;
    }
    i++;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
