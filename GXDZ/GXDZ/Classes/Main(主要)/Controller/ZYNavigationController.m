//
//  ZYNavigationController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//
/**
 覆盖系统返回按钮,系统滑动返回功能失效
 恢复系统滑动返回功能,解决方法:
 1.成为 交互式弹出手势识别器 的代理
 2.在导航控制器的子控制器数大于1时,接收手势识别器。
 
 系统滑动返回功能
 手势   : self.interactivePopGestureRecognizer           UIScreenEdgePanGestureRecognizer
 target: self.interactivePopGestureRecognizer.delegate  _UINavigationInteractiveTransition
 action: handleNavigationTransition:
*/
#import "ZYNavigationController.h"

@interface ZYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZYNavigationController

#pragma mark- 重写 initialize 在该方法中设置导航条
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
   
    //添加(自定义)弹出手势识别器
    [self addPopGestureRecognizer];
    
}

#pragma mark- 添加(自定义)弹出手势识别器
- (void)addPopGestureRecognizer {
    //不起用系统手势(交互式弹出手势识别器)
    self.interactivePopGestureRecognizer.enabled = NO;

    //系统的手势方法
    SEL action = @selector(handleNavigationTransition:);
    //系统的调用手势方法的目标
    id target = self.interactivePopGestureRecognizer.delegate;
    //创建手势
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget: target action:action];
    //设置代理
    panGR.delegate = self;
    //添加手势
    [self.view addGestureRecognizer:panGR];
}

#pragma mark- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //当导航控制器的子控制器为非根控制器是 响应手势
    return self.childViewControllers.count > 1;
}

#pragma mark- 重写 pushViewController 在该方法中添加非根控制器的导航条左侧返回按钮,隐藏屏幕底部的工具栏
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

#pragma mark- 设置导航条左侧添加返回按钮
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

#pragma mark- 导航条左侧返回按钮点击
- (void)backClick {
    [self popViewControllerAnimated:YES];
}
@end
