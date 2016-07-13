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

#define HLS_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"

@interface LiveDetailViewController ()


@property (strong, nonatomic) PlayerView *playerView;


@end

@implementation LiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,self.liveModel.videoId]];
    filePath=[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSURL *videoUrl = [NSURL URLWithString: filePath ];
    self.playerView = [[PlayerView alloc]initWithUrl:filePath frame:CGRectMake(0, 20, 414, 250)];
    
    NSLog(@"%f",self.view.frame.size.height);
    [self.view.layer addSublayer:self.playerView.playerLayer];
    
    
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
