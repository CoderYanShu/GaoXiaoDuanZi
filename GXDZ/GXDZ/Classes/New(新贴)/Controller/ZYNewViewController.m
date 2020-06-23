//
//  ZYNewViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYNewViewController.h"
#import "ZYSubTagViewController.h"
#import "ZYTopicViewController.h"

@interface ZYNewViewController ()

@end

@implementation ZYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setUpNavigationItem];
   
    [self setUpChildViewController];
}

#pragma mark- 设置导航条
- (void)setUpNavigationItem {
    //导航条的内容由栈顶控制器 navigationItem 来决定
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置 左侧按钮 item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(subIconClick)];
}

#pragma mark- 导航条左侧按钮点击
- (void)subIconClick {
    ZYSubTagViewController *subTagVC = [[ZYSubTagViewController alloc] init];
    
    [self.navigationController pushViewController:subTagVC animated:YES];
}

#pragma mark- 添加子控制器
- (void)setUpChildViewController {
    
    ZYTopicViewController *allVc = [[ZYTopicViewController alloc] init];
    ZYTopicViewController *videoVc = [[ZYTopicViewController alloc] init];
    ZYTopicViewController *voiceVc = [[ZYTopicViewController alloc] init];
    ZYTopicViewController *pictVc = [[ZYTopicViewController alloc] init];
    ZYTopicViewController *textVc = [[ZYTopicViewController alloc] init];
    
    [self addChildViewController:allVc];
    [self addChildViewController:videoVc];
    [self addChildViewController:voiceVc];
    [self addChildViewController:pictVc];
    [self addChildViewController:textVc];
    
    allVc.topicType = ZYTopicItemTypeAll;
    videoVc.topicType = ZYTopicItemTypeVideo;
    voiceVc.topicType = ZYTopicItemTypeVocie;
    pictVc.topicType = ZYTopicItemTypePict;
    textVc.topicType = ZYTopicItemTypeText;
    
    allVc.title = @"全部";
    videoVc.title = @"视频";
    voiceVc.title = @"声音";
    pictVc.title = @"图片";
    textVc.title = @"段子";
}
@end
