//
//  ZYEssenceViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYEssenceViewController.h"

#import "ZYAllViewController.h"
#import "ZYPictViewController.h"
#import "ZYTextViewController.h"
#import "ZYVideoViewController.h"
#import "ZYVoiceViewController.h"

@interface ZYEssenceViewController ()

@end

@implementation ZYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationItem];
    
    [self setUpChildViewController];
}

#pragma mark- 设置导航条
- (void)setUpNavigationItem {
    //导航条的内容由栈顶控制器 navigationItem 来决定
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark- 添加子控制器
- (void)setUpChildViewController {
    
    ZYAllViewController *allVc = [[ZYAllViewController alloc] init];
    ZYVideoViewController *videoVc = [[ZYVideoViewController alloc] init];
    ZYVoiceViewController *voiceVc = [[ZYVoiceViewController alloc] init];
    ZYPictViewController *pictVc = [[ZYPictViewController alloc] init];
    ZYTextViewController *textVc = [[ZYTextViewController alloc] init];
    
    [self addChildViewController:allVc];
    [self addChildViewController:videoVc];
    [self addChildViewController:voiceVc];
    [self addChildViewController:pictVc];
    [self addChildViewController:textVc];
    
    allVc.title = @"全部";
    videoVc.title = @"视频";
    voiceVc.title = @"声音";
    pictVc.title = @"图片";
    textVc.title = @"段子";
}
@end
