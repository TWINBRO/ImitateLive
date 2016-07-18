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
#import "DLTabedSlideView.h"
#import "BriefViewController.h"
#import "VideoModel.h"
#import "HistoryVideoViewController.h"

#define HLS_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"

@interface LiveDetailViewController ()<DLTabedSlideViewDelegate>

@property (strong, nonatomic) PlayerView *playerView;

@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) DLTabedSlideView *tabedSlideView;

@property (strong, nonatomic) BriefViewController *briefVC;

@property (strong, nonatomic) HistoryVideoViewController *historyVideoVC;

@end

@implementation LiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,self.liveModel.videoId]];
    filePath=[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSURL *videoUrl = [NSURL URLWithString: filePath ];
    self.playerView = [[PlayerView alloc]initWithUrl:filePath frame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
    
    [self addView];
    [self.view.layer addSublayer:self.playerView.playerLayer];
    
    // 添加通知观测是否确定播放历史视频
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideo) name:@"PLAYVIDEO" object:nil];
    
}

//- (void)palyVideo {
//    
//    [self.playerView.playerLayer removeFromSuperlayer];
//    
//    
//}

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
            
            
            self.briefVC.liveModel = self.liveModel;
            
            
            
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
