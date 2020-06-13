//
//  ZYTabBarController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/12.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTabBarController.h"

#import "ZYEssenceViewController.h"
#import "ZYPublishViewController.h"
#import "ZYFriendViewController.h"
#import "ZYNewViewController.h"
#import "ZYMeViewController.h"

@interface ZYTabBarController ()

@end

@implementation ZYTabBarController


//程序的根控制器(UITabBarController 的 view 控制器创建时加载,UIViewontroller的 view 懒加载)
//UITabBar 里面的按钮内容由子控制器的 UITabBarItem 决定
//如果是通过导航控制器的子控制器设置 UITabBarItem 必须同时设置标题和图片
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //添加所有子控制器
    [self addAllChildViewControllers];
}

#pragma mark- 添加所有子控制器
- (void)addAllChildViewControllers {
    //精华
    ZYEssenceViewController *essenceVC = [[ZYEssenceViewController alloc] init];
    UINavigationController *navEssenceVC = [[UINavigationController alloc] initWithRootViewController:essenceVC];
    
    //新帖
    ZYNewViewController *newVC = [[ZYNewViewController alloc] init];
    UINavigationController *navNewVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    
    //发布
    ZYPublishViewController *publishVC = [[ZYPublishViewController alloc] init];
    
    //关注
    ZYFriendViewController *friendVC = [[ZYFriendViewController alloc] init];
    UINavigationController *navFriendVC = [[UINavigationController alloc] initWithRootViewController:friendVC];
    
    //我
    ZYMeViewController *meVC = [[ZYMeViewController alloc] init];
    UINavigationController *navMeVC = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    //所有子控制器数组
    self.viewControllers = @[navEssenceVC, navNewVC, publishVC, navFriendVC, navMeVC];
}

@end
