//
//  ZYSettingViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYSettingViewController.h"
#import <SVProgressHUD.h>


@interface ZYSettingViewController ()

@end

@implementation ZYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationItem];
    
    [self setUpGroup0];
    
    [self setUpGroup1];
    
    [self setUpGroup2];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)setUpNavigationItem {
    
    self.navigationItem.title = @"设置";
}

- (void)clearDisk {
    if (!SDImageCache.sharedImageCache.totalDiskSize) {
        [SVProgressHUD showInfoWithStatus:@"缓存已清空"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在清除缓存..."];
    [SDImageCache.sharedImageCache clearDiskOnCompletion:^{
        [SVProgressHUD showSuccessWithStatus:@"清空成功"];
        
    }];
}
#pragma mark- 获取缓存
- (NSString *)totalDiskSize {
    
    NSInteger totalSize = SDImageCache.sharedImageCache.totalDiskSize;
    CGFloat sizeFloat = 0;
    NSString *sizeString = nil;
    if (totalSize > 1000 * 1000) {
        sizeFloat = totalSize / 1000.0 / 1000.0;
        sizeString = [NSString stringWithFormat:@"%.2fMB",sizeFloat];
    }
    else if (totalSize > 1000) {
        sizeFloat = totalSize / 1000.0;
        sizeString = [NSString stringWithFormat:@"%.2fKB",sizeFloat];
    }
    else if (totalSize >= 0) {
        sizeString = [NSString stringWithFormat:@"%.2fKB",totalSize * 1.0];
    }
    return sizeString;
}

- (void)setUpGroup0 {
    
    ZYRowItem *item = [ZYRowItem rowItemWithImage:nil title:@"清除缓存"];
    
    item.subTitle = [self totalDiskSize];
    
    //    item.selectRowTask = ^{
    //        [self clearDisk];
    //    };
   
    ZYGroupItem *group = [ZYGroupItem groupItemWithRowItems: @[item]];
    
    [self.groups addObject:group];
}

- (void)setUpGroup1 {
    
    ZYArrowItem *morePush = [ZYArrowItem rowItemWithImage:[UIImage imageNamed:@"MorePush"] title:@"推送和提醒"];
    
    ZYSwitchItem *homeshake = [ZYSwitchItem rowItemWithImage:[UIImage imageNamed:@"more_homeshake"] title:@"使用摇一摇机选"];
    
    ZYSwitchItem *sound = [ZYSwitchItem rowItemWithImage:[UIImage imageNamed:@"sound_Effect"] title:@"声音效果"];
    
    ZYSwitchItem *recommend = [ZYSwitchItem rowItemWithImage:[UIImage imageNamed:@"More_LotteryRecommend"] title:@"购彩小助手"];

    ZYGroupItem *group1 = [ZYGroupItem groupItemWithRowItems: @[morePush, homeshake, sound, recommend]];
    
    [self.groups addObject:group1];
}

- (void)setUpGroup2 {
    
    ZYArrowItem *item = [ZYArrowItem rowItemWithImage:[UIImage imageNamed:@"RedeemCode"] title:@"检查新版本"];
    
    item.selectRowTask = ^{
        [SVProgressHUD showInfoWithStatus:@"当前没有最新版本"];
    };
    
    ZYArrowItem *share = [ZYArrowItem rowItemWithImage:[UIImage imageNamed:@"MoreShare"] title:@"分享"];

    ZYArrowItem *netsease = [ZYArrowItem rowItemWithImage:[UIImage imageNamed:@"MoreNetease"] title:@"产品推荐"];
    
    ZYArrowItem *about = [ZYArrowItem rowItemWithImage:[UIImage imageNamed:@"MoreAbout"] title:@"关于"];

    ZYGroupItem *group2 = [ZYGroupItem groupItemWithRowItems:@[item, share, netsease, about]];
    
    [self.groups addObject:group2];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断是否是清除缓存行
    if (indexPath.section == 0) {
        //清除缓存
        [self clearDisk];
        ZYGroupItem *groupItem = self.groups[indexPath.section];
        ZYRowItem *rowItem  = groupItem.rowItems[indexPath.row];
        
        rowItem.subTitle = [self totalDiskSize];
        [self.tableView reloadData];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}
@end
