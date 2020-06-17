//
//  ZYSettingBaseViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/17.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYSettingBaseViewController.h"

@interface ZYSettingBaseViewController ()

@end
static NSString *ID = @"ZYSettingCell";

@implementation ZYSettingBaseViewController

#pragma mark- 懒加载
- (NSMutableArray *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

#pragma mark- 初始化
- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册 ZYSettingCell
    [self.tableView registerClass:ZYSettingCell.class forCellReuseIdentifier:ID];
    //使用指定的图像创建颜色对象。
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    ZYGroupItem *group = self.groups[section];
    return group.rowItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    ZYGroupItem *group = self.groups[indexPath.section];
    
    ZYRowItem  *item = group.rowItems[indexPath.row];
    
    cell.item = item;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    ZYGroupItem *group = self.groups[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    ZYGroupItem *group = self.groups[section];
    return group.footer;
}

#pragma mark-  Table view data delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消选择由索引路径标识的给定行，并使用一个选项设置取消选择的动画。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取出模型
    ZYGroupItem *group = self.groups[indexPath.section];
    ZYRowItem  *item = group.rowItems[indexPath.row];
    
    //判断是否有选中任务
    if (item.selectRowTask) {
        item.selectRowTask();
        return;
    }
    //判断是否要跳转控制器
    if ([item isKindOfClass:ZYArrowItem.class]) {
        ZYArrowItem *aItem = (ZYArrowItem *)item;
        
        if (aItem.destinationController) {
            UIViewController *vc = [[aItem.destinationController alloc] init];
            vc.navigationItem.title = aItem.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }

}

@end
