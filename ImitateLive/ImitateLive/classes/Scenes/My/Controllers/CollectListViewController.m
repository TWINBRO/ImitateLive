//
//  CollectListViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "CollectListViewController.h"
#import "LiveCollectionViewCell.h"
#import "LiveDetailViewController.h"
#import "DataBaseHandle.h"
#import "LiveRequest.h"
#import "VideoModel.h"
@interface CollectListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectCollectionView;
@property (strong, nonatomic) NSMutableArray *allLivesArray;
//@property (strong, nonatomic) NSMutableArray *allIDArr;
//@property (strong, nonatomic) NSMutableArray *presentLivesArr;

@end
#define LiveCollectionViewCell_Identify @"LiveCollectionViewCell_Identify"
@implementation CollectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订阅列表";

    
    self.allLivesArray = [NSMutableArray array];
    
    
//    self.allIDArr = [NSMutableArray array];
//    self.presentLivesArr = [NSMutableArray array];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.bounds.size.width/2.0, 174);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    
    
    self.collectCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 105) collectionViewLayout:layout];
    self.collectCollectionView.backgroundColor = [UIColor whiteColor];
    self.collectCollectionView.dataSource = self;
    self.collectCollectionView.delegate = self;
    [self.collectCollectionView registerNib:[UINib nibWithNibName:@"LiveCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:LiveCollectionViewCell_Identify];
    
    [self.view addSubview:self.collectCollectionView];
    [self getAllLives];
    
}

//获取当前用户收藏过的活动
- (void)getAllLives
{
    // 从数据库中读取活动对象数据
    self.allLivesArray = [[DataBaseHandle shareInstance] selectAllLiveModel];
    if (_allLivesArray.count == 0) {
        NSLog(@"暂无收藏！");
    }
    
//    for (int i = 0; i < self.allLivesArray.count; i ++) {
//        LiveModel *model = [LiveModel new];
//        model = self.allLivesArray[i];
//        
//        NSLog(@"===========%@",model.title);
//        [self.allIDArr addObject:model.liveID];
////        [self requestListDetail:model.liveID];
//    }
//    
//        for (int i = self.allIDArr.count-1; i >= 0; i --) {
//            [self requestListDetail:self.allIDArr[i]];
//    
//        }
    
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _allLivesArray.count;
    
}

// 请求直播间简介
//- (void)requestListDetail:(NSString *)ID {
//    
//    __weak typeof(self) weakSelf = self;
//    LiveRequest *request = [[LiveRequest alloc] init];
//    [request liveDetailRequestWithParameter:@{@"id":ID} success:^(NSDictionary *dic) {
//        
//        VideoModel *model = [VideoModel new];
//        [model setValuesForKeysWithDictionary:dic[@"data"]];
//        [weakSelf.presentLivesArr addObject:model.status];
//        
//        NSLog(@"=======&&&%@",self.presentLivesArr);
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.collectCollectionView reloadData];
//        });
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"error = %@",error);
//        
//    }];
//    
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LiveCollectionViewCell_Identify forIndexPath:indexPath];
    
    
    cell.liveModel = self.allLivesArray[indexPath.row];
    
    
//    cell.isLive = self.presentLivesArr[indexPath.row];

//    if (self.presentLivesArr[indexPath.row] == 0) {
//        cell.backgroundImageView.image = [UIImage imageNamed:@"avatar.png"];
//    }
    

    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LiveDetailViewController *liveDetailVC = [LiveDetailViewController new];
    liveDetailVC.liveModel = self.allLivesArray[indexPath.row];
    //    [self.navigationController pushViewController:liveDetailVC animated:YES];
    [self presentViewController:liveDetailVC animated:YES completion:nil];
    
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
