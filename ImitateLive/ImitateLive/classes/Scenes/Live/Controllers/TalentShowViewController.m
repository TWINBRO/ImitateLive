//
//  TalentShowViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "TalentShowViewController.h"
#import "PlayerView.h"
#import <UMSocialSnsService.h>
#import <UMSocial.h>

@interface TalentShowViewController ()<UMSocialUIDelegate>
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIButton *heartButton;
@property (strong, nonatomic) PlayerView *playerView;
@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UILabel *personLabel;
@property (strong, nonatomic) UILabel *numberLabel;
@property (strong, nonatomic) UILabel *nickNameLabel;

@end
#define HLS_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"
@implementation TalentShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,self.liveModel.videoId]];
    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSURL *videoUrl = [NSURL URLWithString: filePath ];
    self.playerView = [[PlayerView alloc]initWithUrl:filePath frame:self.view.frame];
    if (!self.playerView.isPlaying) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
        imgView.image = [UIImage imageNamed:@"load"];
        
        [self.view addSubview:imgView];
        
        [self.view.layer addSublayer:self.playerView.playerLayer];
        
    }else{
        
        [self.view.layer addSublayer:self.playerView.playerLayer];
        
    }
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame = CGRectMake(WindownWidth - 50, 30, 30, 30);
    [self.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.heartButton.frame = CGRectMake(WindownWidth - 50, WindowHeight - 50, 30, 30);
    [self.heartButton setImage:[UIImage imageNamed:@"heartB"] forState:UIControlStateNormal];
    [self.heartButton addTarget:self action:@selector(heartButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.personLabel = [[UILabel alloc] initWithFrame:CGRectMake(-15, 100, 85, 30)];
    self.personLabel.text = [NSString stringWithFormat:@"%@",self.liveModel.online];
    self.personLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.personLabel.layer.cornerRadius = 15;
    self.personLabel.clipsToBounds = YES;
    self.personLabel.textColor = [UIColor whiteColor];
    self.personLabel.textAlignment = UITextAlignmentCenter;
    
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, WindowHeight - 40, 300, 21)];
    self.numberLabel.text = [NSString stringWithFormat:@"欢迎来到%@的直播间",self.liveModel.nickname];
    self.numberLabel.textColor = [UIColor colorWithRed:14.0/255.0 green:192.0/255.0 blue:228.0/255.0 alpha:1];
    

    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(WindownWidth - 100, WindowHeight - 47, 25, 25)];
    shareBtn.layer.masksToBounds = YES;
    shareBtn.layer.cornerRadius = 5;
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareBtn];

    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 30)];
    self.nickNameLabel.text = [NSString stringWithFormat:@"%@",self.liveModel.nickname];
    self.nickNameLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.nickNameLabel.layer.cornerRadius = 15;
    self.nickNameLabel.clipsToBounds = YES;
    self.nickNameLabel.textColor = [UIColor whiteColor];
    self.nickNameLabel.font = [UIFont systemFontOfSize:13.0];
    self.nickNameLabel.textAlignment = UITextAlignmentCenter;
    
    [self.view addSubview:self.nickNameLabel];

    [self.view addSubview:self.numberLabel];
    [self.view addSubview:self.personLabel];
    [self.view addSubview:self.heartButton];
    [self.view addSubview:self.closeButton];
}

- (void)closeButtonClicked:(UIButton *)button {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)heartButtonClicked:(UIButton *)button {

    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(WindownWidth - 50, WindowHeight - 50, 30, 30)];
    self.imgView.image = [UIImage imageNamed:@"heart"];
    [self.view addSubview:self.imgView];
    [UIView animateWithDuration:2 animations:^{
        self.imgView.alpha = 0;
        
    }];

    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        // 动画主体部分
        self.imgView.frame = CGRectMake(300, 100, 30, 30);
        
    } completion:^(BOOL finished) {
        // 动画完成后执行的代码
//        [self.imgView removeFromSuperview];
        
    }];
    
}

// 分享
- (void)shareAction {
    
    [UMSocialData defaultData].extConfig.title = @"转发到微博";
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.liveModel.spic];
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"578c804167e58e5c90000c6b"
                                      shareText:[NSString stringWithFormat:@"我正在#战旗TV#观看%@的现场直播：【%@】，精彩炫酷，大家速速来围观！http://www.zhanqi.tv%@（分享自@战旗TV直播平台）",self.liveModel.nickname,self.liveModel.title,self.liveModel.url] // 分享的内容
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:self];
    
}

// 实现回调方法
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    
    // 根据responseCode得到发送的结果
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"分享成功");
    }else {
        NSLog(@"%d",response.responseCode);
    }
    
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
