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
//#import "DataBaseHandle.h"
#import "SeverHandle.h"
#import "LiveRequest.h"
#import "VideoModel.h"
#import "FileDataHandle.h"
@interface CollectListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectCollectionView;
@property (strong, nonatomic) NSMutableArray *allLivesArray;
//@property (strong, nonatomic) NSMutableArray *allIDArr;
//@property (strong, nonatomic) NSMutableArray *presentLivesArr;
@property (strong, nonatomic) NSMutableArray * LiveModelArray;
@end

#define kLiveModelArchiverKey @"LiveModel"

#define LiveCollectionViewCell_Identify @"LiveCollectionViewCell_Identify"
@implementation CollectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订阅列表";
    self.allLivesArray = [NSMutableArray array];
    
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
    [self selectAllLiveModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:@"NOTIFICATION" object:nil];
}

- (void)refreshView{
    
    [self selectAllLiveModel];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NOTIFICATION" object:nil];
    
}

#pragma mark 获取所有活动
- (void)selectAllLiveModel
{
    NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    _LiveModelArray = [NSMutableArray array];
    NSString *cql = [NSString stringWithFormat:@"select ID,data from %@ where userName = '%@'", @"CollectList",currentUsername];
    [AVQuery doCloudQueryInBackgroundWithCQL:cql callback:^(AVCloudQueryResult *result, NSError *error)
     {
         NSLog(@"seleteLiveAll result = %@",result.results);
         NSLog(@"selectLiveAll error = %@",error);
         
         if (result.results) {
             LiveModel *livemodel = nil;
             NSMutableArray *mutArray = [NSMutableArray array];
             for (int i = 0; i < result.results.count; i++) {
                 NSDictionary *selectResult = [result.results[i] objectForKey:@"localData"];
                 NSString *ID = [selectResult objectForKey:@"ID"];
                 NSLog(@"%@",ID);
                 NSData * data = [selectResult objectForKey:@"data"];
                 NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kLiveModelArchiverKey,ID];
                 livemodel = [[FileDataHandle shareInstance] unarchiverObject:data forKey:archiverKey];
                 [mutArray addObject:livemodel];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 _LiveModelArray = mutArray;
                 NSLog(@"%@",_LiveModelArray);
                 self.allLivesArray = mutArray;
                 [self.collectCollectionView reloadData];
             });
         }
         
         
         
     }];
    //    return _LiveModelArray;
    
}



//获取当前用户收藏过的活动
//- (void)getAllLives
//{
//    // 从数据库中读取活动对象数据
//    [[SeverHandle shareInstance] selectAllLiveModel];
//    self.allLivesArray = [SeverHandle shareInstance] allLives:
//    NSLog(@"allLivesArray%@",_allLivesArray);
//    if (_allLivesArray.count == 0) {
//        NSLog(@"暂无收藏！");
//    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.collectCollectionView reloadData];
//    });
//
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _allLivesArray.count;
    
}

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
