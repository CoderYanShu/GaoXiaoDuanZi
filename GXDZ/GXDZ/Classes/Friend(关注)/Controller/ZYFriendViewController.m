//
//  ZYFriendViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYFriendViewController.h"


@interface ZYFriendViewController ()

@end

@implementation ZYFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNavigationItem];
}

- (void)setUpNavigationItem {
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommentClick)];
    
}

- (void)friendsRecommentClick {
    
}
@end
