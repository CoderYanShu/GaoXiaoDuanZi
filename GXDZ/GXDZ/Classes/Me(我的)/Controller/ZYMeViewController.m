//
//  ZYMeViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYMeViewController.h"
#import "ZYSettingViewController.h"
#import "ZYCollectionView.h"
#import "ZYFooterCell.h"
#import "ZYLogOnViewController.h"
#import "ZYSquareItem.h"
#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>

static NSString *const tableID = @"tableCell";
static NSString *const footerID = @"footerCell";

@interface ZYMeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic ,strong) NSMutableArray *squareItems;
@property (nonatomic ,strong) ZYCollectionView *footerView;
@property (nonatomic ,strong) AFHTTPSessionManager *manager;

@end

@implementation ZYMeViewController

#pragma mark- 懒加载
- (NSMutableArray *)squareItems {
    if (!_squareItems) {
        _squareItems = NSMutableArray.array;
    }
    return _squareItems;
}

#pragma mark- 初始化表视图控制器以管理给定样式的表视图。
- (instancetype)initWithStyle:(UITableViewStyle)style {
    //init方法(内部调用该方法)
    return [super initWithStyle:UITableViewStyleGrouped];
}

#pragma mark- 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航条Item
    [self setUpNavigationItem];
    
    //设置TableView
    [self setUpTableView];
    
    //加载数据
    [self loadData];
}

#pragma mark- 设置导航条 Item
- (void)setUpNavigationItem {
    
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *nightMode = [UIBarButtonItem itemWithNormalImage:@"mine-moon-icon" selectedImage:@"mine-moon-icon-click" target:self action:@selector(moonClick:)];
    
    UIBarButtonItem *setting = [UIBarButtonItem itemWithNormalImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[setting ,nightMode];
}
#pragma mark- 按钮点击
- (void)moonClick:(UIButton *)button {
    
    button.selected = !button.selected;
}

#pragma mark- 点击设置跳转到设置控制器
- (void)settingClick {
    //创建设置控制器
    ZYSettingViewController *settingVC = [[ZYSettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)setUpTableView {
    //注册 TableView Cell
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:tableID];
    
    //
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    //设置尾部视图
    [self setUpTableFooterView];
}

#pragma mark- 设置尾部视图
- (void)setUpTableFooterView {

    _footerView = [[ZYCollectionView alloc] init];

    //注册 CollectionView Cell
    [_footerView registerClass:ZYFooterCell.class forCellWithReuseIdentifier:footerID];
    
    _footerView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 500);
    _footerView.dataSource = self;
    
    _footerView.delegate = self;
    self.tableView.tableFooterView = _footerView;
}

#pragma mark- 加载数据
- (void)loadData {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    _manager = AFHTTPSessionManager.manager;
    
    [_manager GET:kURL_STRING parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //字典数组转模型数组
        for (NSDictionary *dict in responseObject[@"square_list"]) {
            if (![dict isKindOfClass:NSDictionary.class]) continue;
            [self.squareItems addObject:[ZYSquareItem itemWithDict:dict]];
        }
        
        //如果最后一行缺少就补空白 Item self.squareItems.count % self.footerView.columns
        [self addEmptyItem];
        

        //重新计算 footerView 高度 行数 * Item高度
        //计算行数 ((总数 - 1 ) / 列数) + 1
        NSUInteger rows = (self.squareItems.count - 1) / self.footerView.columns + 1;
        
        //Item 高度
        CGFloat height = self.footerView.flowLayout.itemSize.height;
        
        // Item 间距
        CGFloat margin = self.footerView.margin;
        
        //计算 footerView 高度 (行数 * Item高度) + (间距 * (行数 - 1 ))
        self.footerView.height = rows * height +  (rows - 1) * margin;
        
        //tableView 的高度由自己的内容决定 所有重新设置
        self.tableView.tableFooterView = self.footerView;
        
        //重新加载所有数据。
        [self.footerView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

#pragma mark- 补齐缺口
- (void)addEmptyItem {
    //总数 % 列数
    NSInteger count = self.squareItems.count % self.footerView.columns;
    if (count) {
        //最后一行缺少的个数
        count = self.footerView.columns - count;
        
        for (int i = 0; i < count; i++) {
            ZYSquareItem *emptyItem = [[ZYSquareItem alloc] init];
            [self.squareItems addObject:emptyItem];
        }
    }
}

#pragma mark- Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableID forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        ZYLogOnViewController *logOnVC = [[ZYLogOnViewController alloc] init];
        
        [self.navigationController pushViewController:logOnVC animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ZYFooterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:footerID forIndexPath:indexPath];
    
    cell.squareItem = self.squareItems[indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.squareItems.count;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    ZYSquareItem *item = self.squareItems[indexPath.row];
    
//    ZYWebViewController *webVC = [[ZYWebViewController alloc] init];
//
//    webVC.url = [NSURL URLWithString:item.url];
//
//    [self.navigationController pushViewController:webVC animated:YES];
   
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]];
//    if (@available(iOS 11.0, *)) {
//        safariVC.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleCancel;
//    }
//
//    [self presentViewController:safariVC animated:YES completion:nil];
}
@end
