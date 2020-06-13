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


@end
