//
//  ChatViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -2, WindownWidth, WindowHeight-330) style:UITableViewStylePlain];
    
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    self.chatTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.chatTableView];
    
    [self addSendView];
    
    
}

- (void)addSendView {
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(70, WindowHeight-120, WindownWidth-140, 50)];
    
    
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
