//
//  HomeViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 sjp. All rights reserved.
//

#import "HomeViewController.h"
#import "CarouselFingure.h"
#import "HomeRequest.h"
#import "WheelImageModel.h"
#import "WTImageScroll.h"
#import "HomeModel.h"
#import "ListModel.h"
#import "LiveCollectionViewCell.h"
#import "HeaderView.h"
#import "CarouselCollectionViewCell.h"
#import "LiveDetailViewController.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CarouselDelegate>
//@property (strong, nonatomic) NSMutableArray *carousels;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIImage *img;
// 存放首页分区model
@property (strong, nonatomic) NSMutableArray *homeDataArr;
// 存放分区内cell的model
@property (strong, nonatomic) NSMutableArray *homeDataDetail;
// collectionView
@property (strong, nonatomic) UICollectionView *homeCollectionView;

@property (strong, nonatomic) NSMutableDictionary *sectionDic;

@property (strong, nonatomic) HeaderView *header;

@end
#define LiveCollectionViewCell_Identifier @"LiveCollectionViewCell_Identifier"
#define CarouselCollectionViewCell_Identifier @"CarouselCollectionViewCell_Identifier"
static NSString * const headerID = @"headerReuseIdentifier";
static NSString * const headID = @"head";
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    // 初始化数组
//    self.carousels = [NSMutableArray array];
    self.homeDataArr = [NSMutableArray array];
    self.homeDataDetail = [NSMutableArray array];
    self.sectionDic = [NSMutableDictionary dictionary];
    
    
    
    [self requestHomeData];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.bounds.size.width/2.0, 174);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    
    self.homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-105) collectionViewLayout:layout];
    self.homeCollectionView.delegate = self;
    self.homeCollectionView.dataSource = self;
    self.homeCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.homeCollectionView registerClass:[CarouselCollectionViewCell class] forCellWithReuseIdentifier:CarouselCollectionViewCell_Identifier];
    
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"LiveCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:LiveCollectionViewCell_Identifier];
    
    //增补视图
    //注册增补视图
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"HeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    
    [self.view addSubview:self.homeCollectionView];
    
    // 下拉刷新
    self.homeCollectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.homeDataArr removeAllObjects];
        [self.homeDataDetail removeAllObjects];
        [self requestHomeData];
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 首页其他数据
- (void)requestHomeData {

    __weak typeof(self) weakSelf = self;
    HomeRequest *homerequest = [[HomeRequest alloc] init];
    [homerequest homeRequestWithParameter:nil success:^(NSDictionary *dic) {
//        NSLog(@"home data success = %@",dic);
        NSArray *dataArr = [dic objectForKey:@"data"];
        for (NSDictionary *tempDic in dataArr) {
            HomeModel *homeModel = [[HomeModel alloc] init];
            [homeModel setValuesForKeysWithDictionary:tempDic];
            [weakSelf.homeDataArr addObject:homeModel];
     
            NSMutableArray *array = [NSMutableArray array];
            NSArray *dataDetail = [tempDic objectForKey:@"lists"];
            for (NSDictionary *dictory in dataDetail) {
                
//                ListModel *listModel = [[ListModel alloc]init];
//                [listModel setValuesForKeysWithDictionary:dictory];
//                [weakSelf.homeDataDetail addObject:listModel];
//                [array addObject:listModel];
                
                LiveModel *liveModel = [LiveModel new];
                [liveModel setValuesForKeysWithDictionary:dictory];
                [weakSelf.homeDataDetail addObject:liveModel];
                [array addObject:liveModel];
            }
            [weakSelf.sectionDic setObject:array forKey:homeModel.title];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.homeCollectionView.mj_header endRefreshing];
            [weakSelf.homeCollectionView reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"home data error =  %@",error);
    }];
    
}

//分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.homeDataArr.count+1;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return CGSizeMake(WindownWidth,200);
    }else {
        
        return CGSizeMake(self.view.bounds.size.width/2.0, 174);
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
    HomeModel *model = self.homeDataArr[section-1];
    return model.lists.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CarouselCollectionViewCell_Identifier forIndexPath:indexPath];
        
        cell.carouselDelegate = self;
        return cell;
    }
    else{
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LiveCollectionViewCell_Identifier forIndexPath:indexPath];
    
    HomeModel *model = self.homeDataArr[indexPath.section-1];

    cell.liveModel = [self.sectionDic objectForKey:model.title][indexPath.item];
    
       // cell.liveModel = self.homeDataDetail[indexPath.row];
    
    return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        _header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        if (indexPath.section == 0) {
        
            _header.imgView.image = [UIImage imageNamed:@""];
            _header.headerTitleLabel.text = @"";
            
        }else {
        
            _header.homeModel = self.homeDataArr[indexPath.section-1];
        }
        
        reusableView = _header;
    }
        return reusableView;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(WindownWidth, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        LiveDetailViewController *liveDetailVC = [LiveDetailViewController new];
        liveDetailVC.liveModel = (LiveModel *)self.roomModel;
        [self presentViewController:liveDetailVC animated:YES completion:nil];
        
    }else{
    LiveDetailViewController *liveDetailVC = [LiveDetailViewController new];
    HomeModel *model = self.homeDataArr[indexPath.section-1];
    liveDetailVC.liveModel = [self.sectionDic objectForKey:model.title][indexPath.item];
    //    [self.navigationController pushViewController:liveDetailVC animated:YES];
    [self presentViewController:liveDetailVC animated:YES completion:nil];
    }
}

- (void)changeController:(LiveModel *)model {

    LiveDetailViewController *liveDetailVC = [LiveDetailViewController new];
    liveDetailVC.liveModel = model;
    [self presentViewController:liveDetailVC animated:YES completion:nil];
    
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
