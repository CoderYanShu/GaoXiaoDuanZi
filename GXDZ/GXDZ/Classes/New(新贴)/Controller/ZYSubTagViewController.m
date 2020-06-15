//
//  ZYSubTagViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/14.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYSubTagViewController.h"
#import "ZYSubTagCell.h"
#import "ZYSubTagItem.h"
#import <SVProgressHUD.h>

@interface ZYSubTagViewController ()

@property (nonatomic ,strong) NSMutableArray *subTagItems;
@property (nonatomic ,strong) AFHTTPSessionManager *manager;

@end

static NSString * const ID = @"subTag";

@implementation ZYSubTagViewController

- (NSMutableArray *)subTagItems {
    if (!_subTagItems) {
        _subTagItems = [NSMutableArray array];
    }
    return _subTagItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadData];
    
    //设置控制器的标题
    self.title = @"推荐订阅";
    
    //取消分隔线内边距
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //设置尾部视图(清除多余的cell)
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册cell
    [self.tableView registerClass:ZYSubTagCell.class forCellReuseIdentifier:ID];
}

#pragma mark- 加载数据
- (void)loadData {
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    _manager = AFHTTPSessionManager.manager;
   

    [_manager GET:kURL_STRING parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        //字典数组转模型数组
        for (NSDictionary *dict in responseObject) {
            [self.subTagItems addObject:[ZYSubTagItem subTagItemWithDict:dict]];
        }
        //刷新列表
        [self.tableView reloadData];
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showWithStatus:@"加载失败!!!"];
        
    }];
}

#pragma mark- 视图消失
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //隐藏指示器
    [SVProgressHUD dismiss];
    
    //取消请求
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.subTagItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    ZYSubTagItem *subTagItem = self.subTagItems[indexPath.row];
    
    cell.subTagItem = subTagItem;
    
    return cell;
}
@end
