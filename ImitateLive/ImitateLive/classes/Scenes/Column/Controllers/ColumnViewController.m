//
//  ColumnViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 sjp. All rights reserved.
//

#import "ColumnViewController.h"
#import "ColumnRequest.h"
#import "ColumnModel.h"
#import "GameModel.h"
#import "ColumnCollectionViewCell.h"
#import "ColumnDetailViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface ColumnViewController ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) NSMutableArray *allColumnArr;

@property (nonatomic, strong) NSMutableArray *allGamesArr;

@property (nonatomic, strong) UICollectionView *columnCollectionView;

@property (nonatomic, assign) NSInteger page;

@end

@implementation ColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"栏目";
    // 初始化数组
    self.allColumnArr = [NSMutableArray array];
    self.allGamesArr = [NSMutableArray array];
    // 请求数据
    [self loadTop];
    // 下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTop)];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    
    [header setImages:nil forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    
//    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 设置普通状态的动画图片
    
//    [header setImages:idleImages forState:MJRefreshStateIdle];
    self.columnCollectionView.mj_header = header;
    
    // 上拉刷新
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    self.columnCollectionView.mj_footer = footer;
    
    // 创建UICollerctionView
    
    [self creatColumnCollectionView];
}
// 创建collectionView
- (void)creatColumnCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.columnCollectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, WindownWidth, WindowHeight - 64 - 49) collectionViewLayout:flowLayout];
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.columnCollectionView.backgroundColor = [UIColor whiteColor];
    self.columnCollectionView.delegate = self;
    self.columnCollectionView.dataSource = self;
    // 可以下拉
    self.columnCollectionView.alwaysBounceVertical = YES;
    
    [self.columnCollectionView registerNib:[UINib nibWithNibName:@"ColumnCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ColumnCollectionViewCell_Identifier];
    
    [self.view addSubview:self.columnCollectionView];
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
        [self.allGamesArr removeAllObjects];
        [self requestColumnData:ID];
        
    }else{
        [self requestColumnData:ID];
    }
    
}

// 请求数据
- (void)requestColumnData:(NSString *)ID
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parmar = [NSDictionary dictionaryWithObject:ID forKey:@"id"];
    ColumnRequest *columnRequest = [[ColumnRequest alloc] init];
    [columnRequest allColumnRequestWithParameter:parmar success:^(NSDictionary *dic) {
//        NSLog(@"%@",dic);
        NSDictionary *tempDict = [dic objectForKey:@"data"];
        NSArray *tempArr = [tempDict objectForKey:@"games"];
        for (NSDictionary *tempdic in tempArr) {
            // item数组赋值
            GameModel *model = [[GameModel alloc] init];
            [model setValuesForKeysWithDictionary:tempdic];
            [weakSelf.allGamesArr addObject:model];
//            NSLog(@"%@",weakSelf.allGamesArr);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.columnCollectionView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"%ld",self.allGamesArr.count);
    return self.allGamesArr.count;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = WindownWidth / 3.0 - 20;
    CGFloat height = WindowHeight / 3.0 - 20;
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ColumnCollectionViewCell_Identifier forIndexPath:indexPath];
    
    cell.model = self.allGamesArr[indexPath.row];
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColumnDetailViewController *columnDetailVC = [[ColumnDetailViewController alloc] init];
    columnDetailVC.model = self.allGamesArr[indexPath.row];
    [self.navigationController pushViewController:columnDetailVC animated:YES];
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
