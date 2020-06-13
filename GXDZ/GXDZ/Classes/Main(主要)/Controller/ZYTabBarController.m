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

#import "ZYLogOnViewController.h"

#import "UIImage+ZYRender.h"

#import "ZYNavigationController.h"

@interface ZYTabBarController ()

/// 发布按钮(不使用 UITabBarButton 的按钮)
@property (nonatomic ,strong) UIButton *publishButton;

@end

@implementation ZYTabBarController

#pragma mark- publishButton 懒加载
- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:_publishButton];
        [_publishButton sizeToFit];
    }
    return _publishButton;
}

#pragma mark- 发布按钮点击
- (void)publishButtonClick {
    //假数据
    BOOL isLogOn = NO;
    
    UIViewController *vc = nil;
    //判断是否已经登录
    if (isLogOn) {
        //创建发布控制器
        vc = [[ZYPublishViewController alloc] init];
    }
    else {
        vc = [[ZYLogOnViewController alloc] init];
    }
    //设置 显示风格
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
     //显示
    [self presentViewController:vc animated:YES completion:nil];
}
//程序的根控制器(UITabBarController 的 view 控制器创建时加载,UIViewontroller的 view 懒加载)
//UITabBar 里面的按钮内容由子控制器的 UITabBarItem 决定
//如果是通过导航控制器的子控制器设置 UITabBarItem 必须同时设置标题和图片
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加所有子控制器
    [self addAllChildViewControllers];
    
    //设置所有设置所有子控制器的 tabBarItem
    [self setUpAllTabBarItem];
}

#pragma mark- 视图即将显示
//UITabBarButton 在该方法中创建
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.publishButton.center = CGPointMake(self.tabBar.bounds.size.width * 0.5, 24.5);
}

#pragma mark- 添加所有子控制器
- (void)addAllChildViewControllers {
    //精华
    ZYEssenceViewController *essenceVC = [[ZYEssenceViewController alloc] init];
    ZYNavigationController *navEssenceVC = [[ZYNavigationController alloc] initWithRootViewController:essenceVC];
    
    //新帖
    ZYNewViewController *newVC = [[ZYNewViewController alloc] init];
    ZYNavigationController *navNewVC = [[ZYNavigationController alloc] initWithRootViewController:newVC];
    
    //发布(仅仅用来占位的控制器)
    UIViewController *publishVC = [[UIViewController alloc] init];
    
    //关注
    ZYFriendViewController *friendVC = [[ZYFriendViewController alloc] init];
    ZYNavigationController *navFriendVC = [[ZYNavigationController alloc] initWithRootViewController:friendVC];
    
    //我
    ZYMeViewController *meVC = [[ZYMeViewController alloc] init];
    ZYNavigationController *navMeVC = [[ZYNavigationController alloc] initWithRootViewController:meVC];
    
    //所有子控制器数组
    self.viewControllers = @[navEssenceVC, navNewVC, publishVC, navFriendVC, navMeVC];
}

#pragma mark- 设置所有的 tabBarItem
- (void)setUpAllTabBarItem {
    //设置 tabBar 主题颜色
    self.tabBar.tintColor = UIColor.darkGrayColor;
    
    //设置 tabBar 未选中主题颜色
    self.tabBar.unselectedItemTintColor = UIColor.grayColor;
    
    //设置 tabBarItem
    [self setUpTabBarItemWithIndex:0 title:@"精华" imageNamed:@"tabBar_essence_icon" selectedImageNamed:@"tabBar_essence_click_icon"];
        
    [self setUpTabBarItemWithIndex:1 title:@"新贴" imageNamed:@"tabBar_new_icon" selectedImageNamed:@"tabBar_new_click_icon"];
    
    //该 tabBarItem 和 该控制器一样仅仅用来占位的; 所以设置为不可用.
    self.viewControllers[2].tabBarItem.enabled = NO;
    
    [self setUpTabBarItemWithIndex:3 title:@"关注" imageNamed:@"tabBar_friendTrends_icon" selectedImageNamed:@"tabBar_friendTrends_click_icon"];
    
    [self setUpTabBarItemWithIndex:4 title:@"我的" imageNamed:@"tabBar_me_icon" selectedImageNamed:@"tabBar_me_click_icon"];
}

#pragma mark-  设置子控制器的 tabBarItem
/// 设置子控制器的 tabBarItem
/// @param index 子控制器索引
/// @param title 标题
/// @param image 图片 如果图片过大,系统自动渲染
/// @param selectedImage 选中图片
- (void)setUpTabBarItemWithIndex:(NSUInteger)index title:(NSString *)title imageNamed:(NSString *)image selectedImageNamed:(NSString *)selectedImage {
    
    //根据索引获取子控制器
    UIViewController *vc = self.viewControllers[index];
    
    //设置标题
    /// 如果该控制器为 UITabBarController 的子控制器，
    /// tabbarItem 没有设置 title 则使用 vc.title 为 tabbarItem 的title
    /// 如果该控制器为 UINavigationController 的子控制器，
    /// navigationItem 没有设置 title 则使用 vc.title 为 navigationItem 的title
    vc.tabBarItem.title = title;
    
    //设置图片
    vc.tabBarItem.image = [UIImage imageOriginalWithNamed:image];
    
    //设置选中图片
    vc.tabBarItem.selectedImage = [UIImage imageOriginalWithNamed:selectedImage];
    
    //设置字体颜色,只能通过正常状态修改 UIControlStateNormal
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    [vc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
}
@end
