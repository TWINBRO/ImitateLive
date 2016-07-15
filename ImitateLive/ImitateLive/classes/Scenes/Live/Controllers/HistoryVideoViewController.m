//
//  HistoryVideoViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
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
    
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(WindownWidth/2.0, 174);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    
    self.videoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -2, WindownWidth, WindowHeight-280) collectionViewLayout:layout];
    
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
