//
//  MyViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 sjp. All rights reserved.
//

#import "MyViewController.h"
#import "MyHeaderTableViewCell.h"
#import "MyTableViewCell.h"
#import "LoginViewController.h"
#import "RegisterRequest.h"
#import "CollectListViewController.h"
#import "FileDataHandle.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *MyTableView;
@property (strong, nonatomic) NSArray *array;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    _array = @[@[@"Image_focus.png",@"我的关注"],@[@"crash.png",@"清除缓存"],@[@"back.png",@"退出登录"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.MyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -36, WindownWidth, WindowHeight) style:UITableViewStyleGrouped];
    self.MyTableView.delegate = self;
    self.MyTableView.dataSource = self;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.MyTableView registerNib:[UINib nibWithNibName:@"MyHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyHeaderTableViewCell_Identify];
    
    [self.MyTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyTableViewCell_Identify];
    [self addRightNavigationItem];
    [self.view addSubview:self.MyTableView];
}

- (void)addRightNavigationItem {
    
    // 自定义rightBarButton
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 40, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(rightBarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightBarItemClicked:(UIButton *)btn {
    
    self.hidesBottomBarWhenPushed = YES;
    //NSLog(@"..");
    // 跳转到登录页面
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 143;
    }
        return 45;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MyHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyHeaderTableViewCell_Identify];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]) {
            NSString *avatarUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
            if (avatarUrl) {
                [cell.avatarImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",USER_AVATAR_LOCAL_URL,avatarUrl]]];
            }else {
            
                cell.avatarImgView.image = [UIImage imageNamed:@"avatar.png"];
            }
            
            cell.nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        }
        return cell;
    }else {
    
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTableViewCell_Identify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imgView.image = [UIImage imageNamed:self.array[indexPath.section-1][0]];
        cell.contentLabel.text = [NSString stringWithFormat:@"%@",self.array[indexPath.section-1][1]];
        if (indexPath.section == 2) {
            cell.fileSizeLabel.text = [NSString stringWithFormat:@"%.1fM",[self getFilePath]] ;
        }else {
            cell.fileSizeLabel.text = @"";
        }
        return cell;
    }
    
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LoginViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    if (indexPath.section == 1) {
        CollectListViewController *collectVC = [CollectListViewController new];
        [self.navigationController pushViewController:collectVC animated:YES];
    }
    if (indexPath.section == 2) {
        [self removeCache];
        [self.MyTableView reloadData];
    }
    if (indexPath.section == 3) {
//        NSString *lastUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//        [[NSUserDefaults standardUserDefaults] setObject:lastUserID forKey:@"lastUserID"];
        
        
        //注销
        [[FileDataHandle shareInstance] setUsername:nil];
        [[FileDataHandle shareInstance] setPassword:nil];
        [[FileDataHandle shareInstance] setUserId:nil];
        [[FileDataHandle shareInstance] setAvatar:nil];
        [[FileDataHandle shareInstance] setLoginState:NO];
        
        
        
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"avatar"];
        [[NSUserDefaults standardUserDefaults] setObject:@"未登录" forKey:@"userName"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已退出登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [self.view addSubview:alertView];
        
        [self.MyTableView reloadData];
    }
    
}

// 计算缓存
-(float)getFilePath{
    
    //文件管理
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //缓存路径
    
//    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    
//    NSString *cacheDir = [cachePaths objectAtIndex:0];
    
    NSString *cacheDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Image"];
    
    
    NSArray *cacheFileList;
    
    NSEnumerator *cacheEnumerator;
    
    NSString *cacheFilePath;
    
    unsigned long long cacheFolderSize = 0;
    
    cacheFileList = [fileManager subpathsOfDirectoryAtPath:cacheDir error:nil];
    
    cacheEnumerator = [cacheFileList objectEnumerator];
    
    while (cacheFilePath = [cacheEnumerator nextObject]) {
        
        NSDictionary *cacheFileAttributes = [fileManager attributesOfItemAtPath:[cacheDir stringByAppendingPathComponent:cacheFilePath] error:nil];
        
        cacheFolderSize += [cacheFileAttributes fileSize];
        
    }
    
    //单位KB
    return cacheFolderSize/1024/1024;
    
}

// 清除缓存
- (void)removeCache {
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    
//    NSString *path = [paths lastObject];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Image"];
    

    NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self getFilePath]];
    NSLog(@"%@",str);

//    NSString *path = [paths lastObject];
//    NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fK", [self getFilePath]];
//    NSLog(@"%@",str);

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缓存已清除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [self.view addSubview:alertView];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    for (NSString *p in files) {
        
        NSError *error;
        
        NSString *Path = [path stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
            
        }
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [self.MyTableView reloadData];
    
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
