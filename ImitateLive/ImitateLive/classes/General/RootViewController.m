//
//  RootViewController.m
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 sjp. All rights reserved.
//

#import "RootViewController.h"
#import "CustomTabbar.h"
#import "MyViewController.h"
#import "HomeViewController.h"
#import "ColumnViewController.h"
#import "LiveViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createChildViewControllers];
    
    // 设置TabBarItemTextAttributes中的颜色
    [self setTabBarItemTextAttributes];
    
    // 设置tabbar背景图片
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:TAB_THEME_COLOR]];
    // navigationBar背景图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:NAV_THEME_COLOR] forBarMetrics:UIBarMetricsDefault];
    
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    
}

- (void)setcustomTabbar {
    
    [self setValue:[[CustomTabbar alloc] init] forKey:@"tabBar"];
    
}

/**
 *  设置tabbarItem标题颜色
 */
- (void)setTabBarItemTextAttributes {
    
    // 设置普通状态下的文本颜色
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1];
    // 设置选中状态下的文本颜色
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:245.0/255.0 green:111.0/255.0 blue:34.0/255.0 alpha:1];
    
    // 配置文本属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}


/**
 *  添加子视图控制器，添加了3个视图控制器
 */
- (void)createChildViewControllers{
    // 主页
    [self addOneChildController:[[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]] title:@"首页" normalImage:@"btn_home_normal" selectedImage:@"btn_home_selected"];
    // 直播
    [self addOneChildController:[[UINavigationController alloc] initWithRootViewController:[[LiveViewController alloc] init]] title:@"直播" normalImage:@"btn_live_normal" selectedImage:@"btn_live_selected"];
    // 栏目
    [self addOneChildController:[[UINavigationController alloc] initWithRootViewController:[[ColumnViewController alloc] init]] title:@"栏目" normalImage:@"btn_column_normal" selectedImage:@"btn_column_selected"];
    // 我的
    [self addOneChildController:[[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc] init]] title:@"我的" normalImage:@"btn_user_normal" selectedImage:@"btn_user_selected"];
    
}

/**
 *  给tabBarController添加一个子视图控制器
 *
 *  @param viewController 子控制器
 *  @param title          标题
 *  @param normalImage    正常状态下的图片
 *  @param selectedImage  选中状态下的图片
 */
- (void)addOneChildController:(UINavigationController *)viewController title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage {
    
    NSString *str = title;
    if ([str isEqualToString:@"我的"]) {
        viewController.viewControllers[0].view.backgroundColor = [UIColor whiteColor];
    }else {
        viewController.viewControllers[0].view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:230.0/255.0 blue:180.0/255.0 alpha:1];
    }
    // viewController.viewControllers[0].view.backgroundColor = YD_RANDOM_COLOR;
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:normalImage];
    UIImage *selectImage = [UIImage imageNamed:selectedImage];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectImage;
    // 添加子控制器
    [self addChildViewController:viewController];
    
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
