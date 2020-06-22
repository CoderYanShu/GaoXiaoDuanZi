//
//  ZYAllViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/18.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYAllViewController.h"
#import "ZYTopicCell.h"
#import "ZYTopicItem.h"
#import "ZYFootRefreshView.h"

static NSString *ID = @"ZYTopicCell";
@interface ZYAllViewController ()

@property (nonatomic ,strong) NSString *maxtime;
@property (nonatomic, strong) NSMutableArray *topicItems;
@property (nonatomic ,weak) AFHTTPSessionManager *manager;
@property (nonatomic, strong) ZYFootRefreshView *footRefreshView;

@end

@implementation ZYAllViewController
#pragma mark- 懒加载
- (NSMutableArray *)topicItems {
    if (!_topicItems) {
        _topicItems = [NSMutableArray array];
    }
    return _topicItems;
}
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
       AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
        _manager = manager;
    }
    return _manager;
 }
   
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNewData];
    
    [self setUpTableView];

    
}

- (void)setUpTableView {
    //上拉刷新视图
    _footRefreshView = [[ZYFootRefreshView alloc] init];
    _footRefreshView.frame = CGRectMake(0, 0, 0, 50);
    _footRefreshView.backgroundColor = UIColor.redColor;
    //一开始隐藏
    _footRefreshView.hidden = YES;
    
    self.tableView.tableFooterView = _footRefreshView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:ZYTopicCell.class forCellReuseIdentifier:ID];
    
}
#pragma mark - 加载新数据
- (void)loadNewData {
    //取消之前任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"tybe"] = @(ZYTopicItemTypeAll);
    
    [self.manager GET:kURL_STRING parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary  *responseObject) {
        //加载新数据完成时
        //1.显示上拉刷新视图
        self.footRefreshView.hidden = NO;
        //2.保存下一页最大ID
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //3.字典转模型并添加到数组
        for (NSDictionary *dict in responseObject[@"list"]) {
            [self.topicItems addObject:[ZYTopicItem topicItemWithDict:dict]];
        }
        //4.刷新列表
        [self.tableView reloadData];
    } failure:nil];
}

#pragma mark- 加载更多数据
- (void)loadMoreData {
    //取消之前任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = _maxtime;
    parameters[@"tybe"] = @(ZYTopicItemTypeAll);
    
    [self.manager GET:kURL_STRING parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary  *responseObject) {
        //加载更多数据完成时
        //1.设置上拉刷新视图状态为非正在刷新
        self.footRefreshView.isRefreshing = NO;
        //2.保存下一页最大ID
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //3.字典转模型并添加到数组
        for (NSDictionary *dict in responseObject[@"list"]) {
            [self.topicItems addObject:[ZYTopicItem topicItemWithDict:dict]];
        }
        //4.刷新列表
        [self.tableView reloadData];
    } failure:nil];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topicItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.topicItem = self.topicItems[indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYTopicItem *topicItem = self.topicItems[indexPath.row];
    
    return topicItem.cellHeight;
}

#pragma mark-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //滚动时判断是否有数据
    if (!self.topicItems.count) return;
    
    //滚动时判断是否正在加载更多数据
    if (_footRefreshView.isRefreshing) return;
    
    //滚动时判断_footRefreshView是否完全显示(完全显示时可以加载更多数据):offsetY >= 内容高 + tabbar高 - 屏幕高
    if ((scrollView.contentOffset.y >= scrollView.contentSize.height + kTAB_BAR_HEIGHT - kSCREEN_HEIGHT)) {
       //设置上拉刷新视图状态为可以刷新
        _footRefreshView.isCanRefresh = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //滚动结束时判断是否可以刷新
    if (!_footRefreshView.isCanRefresh) return;
    
    //设置上拉刷新视图状态为正在刷新
    _footRefreshView.isRefreshing = YES;
    
    //设置上拉刷新视图状态为不可以刷新
    _footRefreshView.isCanRefresh = NO;
    
    //刷新更多数据
    [self loadMoreData];
}
@end
