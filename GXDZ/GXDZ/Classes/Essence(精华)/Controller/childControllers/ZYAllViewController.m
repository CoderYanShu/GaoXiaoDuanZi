//
//  ZYAllViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/18.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//
#define kTOP_TAB_BAR_HEIGHT 44

#import "ZYAllViewController.h"
#import "ZYTopicCell.h"
#import "ZYTopicItem.h"
#import "ZYFootRefreshView.h"
#import "ZYHeadRefreshView.h"

static NSString *ID = @"ZYTopicCell";
@interface ZYAllViewController ()

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic ,strong) NSString *maxtime;
@property (nonatomic, strong) NSMutableArray *topicItems;
@property (nonatomic ,weak) AFHTTPSessionManager *manager;
@property (nonatomic, strong) ZYFootRefreshView *footRefreshView;
@property (nonatomic, strong) ZYHeadRefreshView *headRefreshView;

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
NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
    
}

- (void)setUpTableView {
    //上拉刷新视图
    _footRefreshView = [[ZYFootRefreshView alloc] init];
    _footRefreshView.frame = CGRectMake(0, 0, 0, 44);
    self.tableView.tableFooterView = _footRefreshView;
    //一开始隐藏
    _footRefreshView.hidden = YES;
    
    ////下拉刷新视图
    _headRefreshView = [[ZYHeadRefreshView alloc] init];
    _headRefreshView.frame = CGRectMake(0, -44, kSCREEN_WIDTH, 44);
    [self.tableView addSubview:_headRefreshView];
    //_headRefreshView.hidden = YES;
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:ZYTopicCell.class forCellReuseIdentifier:ID];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //获取 tableView tableView
    _insets = self.tableView.contentInset;
    //设置滚动指示器的 插入
    self.tableView.scrollIndicatorInsets = _insets;
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
        //1.1设置下拉刷新视图状态为非正在刷新
        self.headRefreshView.isRefreshing = NO;
        //1.2 取消悬停
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(self.insets.top, 0, 0, 0);
        }];
        //1.2显示上拉刷新视图
        self.footRefreshView.hidden = NO;
        //2.保存下一页最大ID
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //3.字典转模型并添加到数组
        
        NSMutableArray *tmp = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            [tmp addObject:[ZYTopicItem topicItemWithDict:dict]];
        }
        //每次加载新数据时重新覆盖之前的数据
        self.topicItems = tmp;
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
   
    //处理上拉刷新
    [self handleFootRefreshView];
    
    
    [self handleHeadRefreshView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_headRefreshView.isCanRefresh) {
        [self loadNewData];
        _headRefreshView.isRefreshing = YES;
        _headRefreshView.isCanRefresh = NO;
        //悬停
        self.tableView.contentInset = UIEdgeInsetsMake(_insets.top + _headRefreshView.height, 0, 0, 0);
    }
}

- (void)handleFootRefreshView {
    //滚动时判断是否有数据
    if (!self.topicItems.count) return;
    
    //滚动时判断是否正在加载更多数据
    if (_footRefreshView.isRefreshing) return;
    
    //获取当前偏移量
    CGFloat currentOffsetY = self.tableView.contentOffset.y;
    
    //获取可以加载更多数据(上拉控件完全显示)时的偏移量
    CGFloat refreshOffsetY = self.tableView.contentSize.height + kTAB_BAR_HEIGHT - kSCREEN_HEIGHT;

    if (currentOffsetY >= refreshOffsetY) {
        
        //设置上拉刷新视图状态为正在刷新
        _footRefreshView.isRefreshing = YES;
        
        //刷新更多数据
        [self loadMoreData];
    }
}

- (void)handleHeadRefreshView {
    //获取当前偏移量
    CGFloat currentOffsetY = self.tableView.contentOffset.y;
    
    //获取完全显示下拉控件的偏移量
    CGFloat refreshOffsetY = -(kSTATUS_BAR_HEIGHT + kNAVIGATION_BAR_HEIGHT + kTOP_TAB_BAR_HEIGHT + _headRefreshView.height);
    
    if (currentOffsetY <= refreshOffsetY) {
        _headRefreshView.isCanRefresh = YES;
    }
    else {
        _headRefreshView.isCanRefresh = NO;
    }
}

@end
