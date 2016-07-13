//
//  LiveViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 sjp. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveCollectionViewCell.h"
#import "LiveDetailViewController.h"
#import "LiveRequest.h"

@interface LiveViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *liveCollectionView;

@property (strong, nonatomic) NSMutableArray *allLivesArray;

@property (assign, nonatomic) NSInteger page;

@end

#define LiveCollectionViewCell_Identify @"LiveCollectionViewCell_Identify"

@implementation LiveViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"直播";
    
    self.allLivesArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.bounds.size.width/2.0, 174);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    
    self.liveCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 105) collectionViewLayout:layout];
    self.liveCollectionView.delegate = self;
    self.liveCollectionView.dataSource = self;
    self.liveCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.liveCollectionView registerNib:[UINib nibWithNibName:@"LiveCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:LiveCollectionViewCell_Identify];
    
    [self.view addSubview:self.liveCollectionView];
    [self loadTop];
    // 下拉刷新
    self.liveCollectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadTop];
    }];
    // 上拉刷新
    self.liveCollectionView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
}

// 判断是否是顶部
- (void)loadTop
{
    self.page = 1;
    [self loadDataPageIndex:self.page top:YES];
}

- (void)loadMore
{
    self.page += 1;
    [self loadDataPageIndex:self.page top:NO];
}
// 判断请求的方式
- (void)loadDataPageIndex:(NSInteger)page top:(BOOL)isTop
{
    NSString *ID = [NSString stringWithFormat:@"%ld",page];
    if (isTop) {
        [self.allLivesArray removeAllObjects];
        [self requestAllLives:ID];
        
    }else{
        [self requestAllLives:ID];
    }
    
}

// 获取直播界面
- (void)requestAllLives:(NSString *)ID {
    
    __weak typeof(self) weakSelf = self;
    LiveRequest *request = [[LiveRequest alloc] init];
    NSDictionary *parmar = [NSDictionary dictionaryWithObject:ID forKey:@"id"];
    [request liveRequestWithParameter:parmar success:^(NSDictionary *dic) {
        
        NSArray *tmpArray = [[dic objectForKey:@"data"] objectForKey:@"rooms"];
        for (NSDictionary *tmpDic in tmpArray) {
            LiveModel *liveModel = [LiveModel new];
            [liveModel setValuesForKeysWithDictionary:tmpDic];
            [weakSelf.allLivesArray addObject:liveModel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.liveCollectionView.mj_header endRefreshing];
                [weakSelf.liveCollectionView.mj_footer endRefreshing];
                [weakSelf.liveCollectionView reloadData];
            });
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _allLivesArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LiveCollectionViewCell_Identify forIndexPath:indexPath];
    
    cell.liveModel = self.allLivesArray[indexPath.row];
    
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
