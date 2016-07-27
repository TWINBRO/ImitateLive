//
//  BriefViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BriefViewController.h"
#import "BriefTableViewCell.h"
//#import "DataBaseHandle.h"
#import "SeverHandle.h"
#import "LoginViewController.h"
@interface BriefViewController ()<UITableViewDataSource,UITableViewDelegate,AddAlertControllerDelegate>

@end

#define BriefTableViewCell_Identify @"BriefTableViewCell_Identify"

@implementation BriefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    self.briefTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -2, WindownWidth, WindowHeight-280) style:UITableViewStylePlain];
    
    self.briefTableView.delegate = self;
    self.briefTableView.dataSource = self;
    self.briefTableView.separatorColor = [UIColor clearColor];
    self.briefTableView.scrollEnabled = NO;
    
    [self.briefTableView registerNib:[UINib nibWithNibName:@"BriefTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:BriefTableViewCell_Identify];
    
    [self.view addSubview:self.briefTableView];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BriefTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BriefTableViewCell_Identify];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.alertDelegate = self;
    
    // 判断是否已经收藏
    BOOL isFavorite = [[SeverHandle shareInstance] isFavoriteLiveModelWithID:_liveModel.liveID];
    
    if (isFavorite) {
        [cell.collectButton setTitle:@"已订阅" forState:UIControlStateNormal];
        cell.collectButton.backgroundColor = [UIColor lightGrayColor];
        
    }else {
        [cell.collectButton setTitle:@"订阅" forState:UIControlStateNormal];
        cell.collectButton.backgroundColor = [UIColor colorWithRed:18/255.0 green:186/255.0 blue:255/255.0 alpha:1];
    }
    
    cell.videoModel = self.videoModel;
    
    cell.liveModel = self.liveModel;
    cell.isFavorite = isFavorite;
    return cell;
    
}

- (void)addAlertController {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您未登录,登录后才能订阅" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LoginViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    // 添加按钮
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 126;
    
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
