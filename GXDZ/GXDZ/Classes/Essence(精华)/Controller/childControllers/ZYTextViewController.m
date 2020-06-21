//
//  ZYTextViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/18.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTextViewController.h"

#import "ZYTopicCell.h"
#import "ZYTopicItem.h"

static NSString *ID = @"ZYTopicCell";
@interface ZYTextViewController ()

@property (nonatomic, strong) NSMutableArray *topicItems;
@property (nonatomic ,weak) AFHTTPSessionManager *manager;

@end

@implementation ZYTextViewController

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.tableView registerClass:ZYTopicCell.class forCellReuseIdentifier:ID];
}


#pragma mark - 加载新数据
- (void)loadNewData {
    //取消之前任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *a = @"list";
    parameters[@"a"] = a;
    parameters[@"c"] = @"data";
 
    parameters[@"tybe"] = @(ZYTopicItemTypeText);
    [self.manager GET:kURL_STRING parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary  *responseObject) {
    
        [responseObject writeToFile:@"/Users/zypontheroad/Desktop/1.plist" atomically:YES];
        //字典转模型
        for (NSDictionary *dict in responseObject[@"list"]) {
            ZYTopicItem *topicItem = [ZYTopicItem topicItemWithDict:dict];
            [self.topicItems addObject:topicItem];
        }
        
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
@end
