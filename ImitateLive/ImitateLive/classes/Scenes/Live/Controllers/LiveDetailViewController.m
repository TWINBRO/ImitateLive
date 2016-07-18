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
#import "DLTabedSlideView.h"
#import "BriefViewController.h"
#import "VideoModel.h"
#import "HistoryVideoViewController.h"

#define HLS_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"


@interface LiveDetailViewController ()<DLTabedSlideViewDelegate,HistoryVideoDelegate,UIApplicationDelegate>

@interface LiveDetailViewController ()<DLTabedSlideViewDelegate,littleInteractiveViewDelegate>

@property (strong, nonatomic) VideoRelationModel *videoRelationModel;


@property (strong, nonatomic) PlayerView *playerView;


@property (strong, nonatomic) LittleInteractiveView *littleView;
@property (strong, nonatomic) BigInteractiveView *bigView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) DLTabedSlideView *tabedSlideView;

@property (strong, nonatomic) BriefViewController *briefVC;

@property (strong, nonatomic) HistoryVideoViewController *historyVideoVC;


@property (strong, nonatomic) UIApplication *application;


@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isPlaying;
// 是否是历史视频
@property (assign, nonatomic) BOOL isHistory;

@end

@implementation LiveDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,self.liveModel.videoId]];
    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    //NSURL *videoUrl = [NSURL URLWithString: filePath ];
    self.playerView = [[PlayerView alloc]initWithUrl:filePath frame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
    
    
    
    [self addView];
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
//        NSLog(@"Complete. Current Time: %f", CMTimeGetSeconds(self.playerView.player.currentTime));
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


//- (void)palyVideo {
//    
//    [self.playerView.playerLayer removeFromSuperlayer];
//    
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

- (void)addView {
    
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 260, WindownWidth, WindowHeight-270)];
    [self.view addSubview:_tabedSlideView];
    
    self.tabedSlideView.delegate = self;
    self.tabedSlideView.baseViewController = self;
    
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:15.0/255.0 green:186.0/255.0 blue:255.0/255.0 alpha:1];
    self.tabedSlideView.tabbarTrackColor = [UIColor blackColor];
    self.tabedSlideView.tabItemNormalColor = [UIColor whiteColor];
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageWithColor:[UIColor blackColor]];
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"简介" image: [UIImage imageNamed:@"ic_broadcastroom_chat_default"] selectedImage: [UIImage imageNamed:@"ic_broadcastroom_chat_pressed"]];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"聊天" image:[UIImage imageNamed:@"ic_broadcastroom_intro_default"]  selectedImage:[UIImage imageNamed:@"ic_broadcastroom_intro_pressed"] ];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"视频" image:[UIImage imageNamed:@"ic_broadcastroom_video_default"]  selectedImage:[UIImage imageNamed:@"ic_broadcastroom_video_pressed"] ];
    
    self.tabedSlideView.tabbarItems = @[item1,item2,item3];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.tabbarBottomSpacing = 1.0;
    self.tabedSlideView.selectedIndex = 1;
    
//    NSArray *array = @[@"简介",@"聊天",@"视频"];
//    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
//    self.segmentedControl.frame = CGRectMake(0, 270, WindownWidth, 20);
//    self.segmentedControl.backgroundColor = [UIColor blackColor];
//    self.segmentedControl.tintColor = [UIColor blueColor];
//    [self.segmentedControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
//    
//    UIView *briefView = [[UIView alloc] initWithFrame:CGRectMake(0, 290, WindownWidth, WindowHeight-290)];
    
    
}

// DLTabedSlideViewDelegate代理方法
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    
    switch (index) {
        case 0:{
            self.briefVC = [[BriefViewController alloc] init];
            [self requestListDetail:self.liveModel.liveID];
            return _briefVC;
        }
        case 1:{
            UIViewController *chatVC = [[UIViewController alloc] init];
            self.view.backgroundColor = [UIColor whiteColor];
            return chatVC;
        }
        case 2:{
            _historyVideoVC = [[HistoryVideoViewController alloc] init];
            _historyVideoVC.uID = self.liveModel.uid;
            _historyVideoVC.delegate = self;
            return _historyVideoVC;
        }
        default:
            return nil;
    }
}

// 请求直播间简介
- (void)requestListDetail:(NSString *)ID {
    
    LiveRequest *request = [[LiveRequest alloc] init];
    [request liveDetailRequestWithParameter:@{@"id":ID} success:^(NSDictionary *dic) {
        
        VideoModel *videoModel = [VideoModel new];
        [videoModel setValuesForKeysWithDictionary:dic[@"data"]];
        self.briefVC.videoModel = videoModel;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.briefVC.briefTableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"error = %@",error);
        
    }];
    
}


- (void)returnVideoRelationModel:(VideoRelationModel *)model {
    
    _application = [UIApplication sharedApplication];
    
    // 跳转到网页
    [_application openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.zhanqi.tv%@",model.url]]];
    
    _application.delegate = self;
    
//    [self.playerView.playerLayer removeFromSuperlayer];
//
//    self.playerView = [[PlayerView alloc]initWithUrl:[NSString stringWithFormat:@"http://www.zhanqi.tv%@",model.url] frame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
//    
//    [self.view.layer addSublayer:self.playerView.playerLayer];
    
}

// 程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [self.playerView.playerLayer removeFromSuperlayer];
    
}


// 程序返回
- (void)applicationWillEnterForeground:(UIApplication *)application{
    
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,self.liveModel.videoId]];
    filePath=[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    self.playerView = [[PlayerView alloc]initWithUrl:filePath frame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
    
    [self.view.layer addSublayer:self.playerView.playerLayer];
    
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
