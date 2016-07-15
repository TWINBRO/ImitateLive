//
//  LiveDetailViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 sjp. All rights reserved.
//

#import "LiveDetailViewController.h"
#import "LiveRequest.h"
#import "PlayerView.h"
#import "LittleInteractiveView.h"
#import "BigInteractiveView.h"
#import "PlayerViewController.h"
#import "NSString+timeFormatter.h"
#import "VideoRelationModel.h"

#define HLS_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"

@interface LiveDetailViewController ()<littleInteractiveViewDelegate>


@property (strong, nonatomic) VideoRelationModel *videoRelationModel;

@property (strong, nonatomic) PlayerView *playerView;

@property (strong, nonatomic) LittleInteractiveView *littleView;
@property (strong, nonatomic) BigInteractiveView *bigView;

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isPlaying;
// 是否是历史视频
@property (assign, nonatomic) BOOL isHistory;
@end

@implementation LiveDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,self.liveModel.videoId]];
    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSURL *videoUrl = [NSURL URLWithString: filePath ];
    self.playerView = [[PlayerView alloc]initWithUrl:filePath frame:CGRectMake(0, 20, 414, 250)];
    
    NSLog(@"%f",self.view.frame.size.height);
    [self.view.layer addSublayer:self.playerView.playerLayer];
    
    [self beginTimer];
    
    self.isHistory = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.playerView.player play];
    self.littleView = [[LittleInteractiveView alloc] initWithFrame:self.playerView.frame];
    [self isHistoryVideo];
    self.littleView.delegate = self;
    [self.view addSubview:self.littleView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.playerView.player pause];
}
#pragma mark -- 根据是否是历史视频更改UI
- (void)isHistoryVideo
{
    if (self.isHistory) {
        self.littleView.shareBtn.hidden = YES;
        self.littleView.bottonView.hidden = NO;
        self.littleView.longTimeLabel.text = self.videoRelationModel.duration;
    }else{
        self.littleView.shareBtn.hidden = NO;
        self.littleView.bottonView.hidden = YES;
        
    }
}
// 按钮代理
- (void)backLastViewController:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)fullScreenAction:(UIButton *)button
{
    PlayerViewController *playerVC = [[PlayerViewController alloc] init];
    playerVC.playerView = self.playerView;
    if (self.isHistory) {
        
    }else{
        playerVC.liveModel = self.liveModel;
    }
    playerVC.isHistory = self.isHistory;
    
    __weak typeof(self) weakSelf = self;
    playerVC.continuePlaying = ^(PlayerView *player){
        weakSelf.playerView = player;
        weakSelf.playerView.frame = CGRectMake(0, 20, 414, 250);
        weakSelf.playerView.playerLayer.frame = weakSelf.playerView.frame;
        [weakSelf.view.layer addSublayer:weakSelf.playerView.playerLayer];
    };
    [self presentViewController:playerVC animated:YES completion:nil];
}

- (void)shareVideoAction:(UIButton *)button
{
    
}
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
//进度条代理方法
- (void)progressSLiderValueChanged:(UISlider *)progress
{
    [self.timer invalidate];
    CGFloat longTime = [self.videoRelationModel.duration getSecondsFormatByString];
    [self.playerView.player seekToTime:CMTimeMakeWithSeconds(progress.value * longTime, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        NSLog(@"Complete. Current Time: %f", CMTimeGetSeconds(self.playerView.player.currentTime));
    }];
    if (progress.value == 1) {
        [self.playerView.player seekToTime:kCMTimeZero];
        [self.playerView.player pause];
        [self.littleView.playOrPauseBtn setTitle:@"播放" forState:UIControlStateNormal];
        progress.value = 0;
    }
    else {
        //        [self.player pause];
    }
    [self beginTimer];
}


//- (void)requestListDetail:(NSString *)ID {
//    
//    LiveRequest *request = [[LiveRequest alloc] init];
//    [request liveDetailRequestWithParameter:@{@"id":ID} success:^(NSDictionary *dic) {
//        
//        LiveModel *liveModel = [LiveModel new];
//        [liveModel setValuesForKeysWithDictionary:dic[@"data"]];
//        
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"error = %@",error);
//        
//    }];
//    
//}

/**
 *  定时器
 */
- (void)beginTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
}
- (void)timeAction:(NSTimer *)timer
{
    // 改变播放的进度
    CMTime current = self.playerView.player.currentTime;
    CGFloat f = current.value/current.timescale;
    self.littleView.nowTimeLabel.text = [NSString getStringFormatByTime:f];
    self.littleView.progressSlider.value = f / CMTimeGetSeconds(self.playerView.playerItem.duration);
    static int i = 1;
    if (i % 5 == 0) {
        self.littleView.hidden = YES;
    }
    i++;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.timer invalidate];
    self.littleView.hidden = NO;
    [self beginTimer];
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
