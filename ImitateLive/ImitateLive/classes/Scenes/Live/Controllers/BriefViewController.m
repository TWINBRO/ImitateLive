//
//  BriefViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BriefViewController.h"
#import "BriefTableViewCell.h"
#import "DataBaseHandle.h"

@interface BriefViewController ()<UITableViewDataSource,UITableViewDelegate>

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
    
    
    // 判断是否已经收藏
    BOOL isFavorite = [[DataBaseHandle shareInstance] isFavoriteLiveModelWithID:_liveModel.liveID];
    
        if (isFavorite) {
            [cell.collectButton setTitle:@"已订阅" forState:UIControlStateNormal];
            cell.collectButton.backgroundColor = [UIColor lightGrayColor];
            
        }else {
            [cell.collectButton setTitle:@"订阅" forState:UIControlStateNormal];
            cell.collectButton.backgroundColor = [UIColor colorWithRed:18/255.0 green:186/255.0 blue:255/255.0 alpha:1];
        }
    
    cell.videoModel = self.videoModel;
    
    cell.liveModel = self.liveModel;
    
    return cell;
    
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
