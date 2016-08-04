//
//  HistoryVideoViewController.m
//  ImitateLive
//
//  Created by ssx on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "HistoryVideoViewController.h"
#import "HistoryVideoViewCell.h"
#import "LiveRequest.h"
#import "VideoRelationModel.h"

@interface HistoryVideoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

#define HistoryVideoViewCell_Identify @"HistoryVideoViewCell_Identify"


@implementation HistoryVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.historyVideos = [NSMutableArray array];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, WindownWidth, 20)];
    label.text = @"相关视频";
    [self.view addSubview:label];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(WindownWidth/2.0, 174);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    
    self.videoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 25, WindownWidth, WindowHeight-280) collectionViewLayout:layout];
    
    self.videoCollectionView.delegate = self;
    self.videoCollectionView.dataSource = self;
    
    [self.videoCollectionView registerNib:[UINib nibWithNibName:@"HistoryVideoViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:HistoryVideoViewCell_Identify];
    
    
    
    self.videoCollectionView.backgroundColor = [UIColor whiteColor];
    [self requestHistotyVideo];
    
    [self.view addSubview:_videoCollectionView];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    NSLog(@"%lu",(unsigned long)_historyVideos.count);
    return self.historyVideos.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryVideoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HistoryVideoViewCell_Identify forIndexPath:indexPath];
    
    cell.model = self.historyVideos[indexPath.row];
    
   // NSLog(@"%@",cell.model.pv);
    return cell;
    
}

- (void)requestHistotyVideo{
    
    LiveRequest *request = [[LiveRequest alloc] init];
    [request historyVideoRequestWithID:self.uID success:^(NSDictionary *dic) {
        
        NSArray *array = [[dic objectForKey:@"data"] objectForKey:@"videos"];
        for (NSDictionary *tmpDic in array) {
            VideoRelationModel *model = [VideoRelationModel new];
            [model setValuesForKeysWithDictionary:tmpDic];
            [self.historyVideos addObject:model];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.videoCollectionView reloadData];
            });
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"观看视频将退出直播" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (_delegate && [_delegate respondsToSelector:@selector(returnVideoRelationModel:)]) {
            [_delegate returnVideoRelationModel:self.historyVideos[indexPath.row]];
        }
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
//    if (_delegate && [_delegate respondsToSelector:@selector(returnVideoRelationModel:)]) {
//        [_delegate returnVideoRelationModel:self.historyVideos[indexPath.row]];
//    }
    
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
