//
//  ZYNavigationController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYNavigationController.h"

@interface ZYNavigationController ()

@end

@implementation ZYNavigationController

//获取全局的(整个应用程序)导航条
//凡是使用到UINavigationBar的地方全部设置以下属性 (背景,颜色)
//UINavigationBar *bar = [UINavigationBar appearance];
//已经遵守 UIAppearance 协议的类, 就可以使用
//带有 UI_APPEARANCE_SELECTOR 宏的属性或方法才可以使用
//必须在显示前使用
+ (void)initialize {
    //获取指定类下的导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    //设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    //设置导航条标题字体
    [navBar setTitleTextAttributes:dict];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark- 重写 pushViewController
//
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //判断导航控制器是否有子控制器(子控制器是否是根控制器)
    if (self.childViewControllers.count) {// 非跟控制器
        //1. 将视图控制器推到导航控制器上时隐藏屏幕底部的工具栏(一定在 push 之前)
        viewController.hidesBottomBarWhenPushed = YES;
        //2. 设置返回按钮
        [self setUpNavigationBarBackButton:viewController];
    }
   
    //保存系统做法
    [super pushViewController:viewController animated:animated];
}


- (void)setUpNavigationBarBackButton:(UIViewController *)viewController {
    
    //自定义导航条右边视图并设置正常和高亮状态
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    
    //正常状态
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn setImage: [UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    
    //高亮状态
    [btn setTitleColor:UIColor.redColor forState:UIControlStateHighlighted];
    [btn setImage: [UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    //按钮自适应大小.
    [btn sizeToFit];
    
    //自定义导航条右边视图
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)backClick {
    [self popViewControllerAnimated:YES];
}
@end
