//
//  LiveDetailViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 sjp. All rights reserved.
//

#import "LiveDetailViewController.h"
#import "LiveRequest.h"


@interface LiveDetailViewController ()

@end

@implementation LiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestListDetail:self.videoModel.videoID];
    
}

- (void)requestListDetail:(NSString *)ID {
    
    LiveRequest *request = [[LiveRequest alloc] init];
    [request liveDetailRequestWithParameter:@{@"id":ID} success:^(NSDictionary *dic) {
        
        VideoModel *videoModel = [VideoModel new];
        [videoModel setValuesForKeysWithDictionary:dic[@"data"]];
        
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
