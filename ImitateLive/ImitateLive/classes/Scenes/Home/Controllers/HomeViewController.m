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
@interface HomeViewController ()
@property (strong, nonatomic) NSMutableArray *carousels;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIImage *img;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.carousels = [NSMutableArray array];
    
    [self requestCarouselData];
//    [self addCarousel];
}

// 请求轮播图数据
- (void)requestCarouselData {

    __weak typeof(self) weakSelf = self;
    HomeRequest *home = [[HomeRequest alloc] init];
    [home carouselRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        NSArray *data = [dic objectForKey:@"data"];
        for (NSDictionary *tempDic in data) {
            WheelImageModel *model = [[WheelImageModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.carousels addObject:model.bpic];
        }
        
       dispatch_async(dispatch_get_main_queue(), ^{
           [weakSelf addCarousel];
       });
        
    } failure:^(NSError *error) {
        NSLog(@"carousel error = %@",error);
    }];
    
}
// 获取图片并且添加轮播图
- (void)addCarousel {

//    NSMutableArray *viewsArray = [@[] mutableCopy];
//    NSLog(@"%@",self.carousels);
//    
//    for (int i = 0; i < self.carousels.count-1; i ++) {
//        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindownWidth, 200)];
//        [img sd_setImageWithURL:[NSURL URLWithString:self.carousels[i+1]]];
//        
//        [viewsArray addObject:img.image];
//    }
//    
//    CarouselFingure *cf = [[CarouselFingure alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, 200)];
//    cf.backgroundColor = [UIColor redColor];
//    cf.images = viewsArray;
//    [self.view addSubview:cf];
    
    UIView *imageScorll=[WTImageScroll ShowNetWorkImageScrollWithFream:CGRectMake(0, 0, WindownWidth, 200) andImageArray:self.carousels andBtnClick:^(NSInteger tagValue) {
        NSLog(@"点击的图片--%@",@(tagValue));
    }];
    [self.view addSubview:imageScorll];
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
