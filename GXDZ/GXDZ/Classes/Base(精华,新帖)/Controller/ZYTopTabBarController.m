//
//  ZYContentViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/18.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.

#define kUNDERLINE_WIDTH 25
#define kUNDERLINE_HEIGHT 3
#define kTOP_TAB_BAR_HEIGHT 44
#define kTOP_TAB_TITLE_MARGIN 20
#define kTITLE_CLOCR_NORMAL UIColor.blackColor
#define kTITLE_CLOCR_SELECTED UIColor.redColor
#define kTITLE_BAR_FONT [UIFont systemFontOfSize:15]

#import "ZYTopTabBarController.h"

static NSString * const ID = @"CONTENTCELL";
@interface ZYTopTabBarController ()<UICollectionViewDataSource, UICollectionViewDelegate>

/// 是否初始化
@property (nonatomic, assign) BOOL isInitial;
/// 选中指示下标视图
@property (nonatomic, strong) UIView *underLine;
/// 标记选中按钮
@property (nonatomic ,strong) UIButton *selectButton;
/// 顶部标题栏(滚动视图)
@property (nonatomic, strong) UIScrollView *topTabBar;
/// 标题按钮宽度数组
@property (nonatomic, strong) NSMutableArray *tabWidths;
/// 标题按钮数组
@property (nonatomic, strong) NSMutableArray *tabs;
/// 内容(滚动)视图
@property (nonatomic, strong) UICollectionView *contentView;

@end

@implementation ZYTopTabBarController

#pragma mark - 懒加载
- (UIView *)underLine {
    if (!_underLine) {
        _underLine = [[UIView alloc] init];
        [self.topTabBar addSubview:_underLine];
        _underLine.backgroundColor = kTITLE_CLOCR_SELECTED;
        CGFloat y = kTOP_TAB_BAR_HEIGHT - kUNDERLINE_HEIGHT;
        _underLine.frame = CGRectMake(0, y, kUNDERLINE_WIDTH, kUNDERLINE_HEIGHT);
    }
    return _underLine;
}

- (NSMutableArray *)tabWidths {
    if (!_tabWidths) {
        _tabWidths = [NSMutableArray array];
    }
    return _tabWidths;
}

- (NSMutableArray *)tabs {
    if (!_tabs) {
        _tabs = [NSMutableArray array];
    }
    return _tabs;
}

#pragma mark- 控制器view生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置内容视图
    [self setUpContentView];
    
    //设置顶部标签栏
    [self setUpTopTabBar];
}
   
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_isInitial) {
        // 没有子控制器，不需要设置 topTabBar
        if (!self.childViewControllers.count) return;
        
        //设置标签宽度
        [self setUpTabWidth];
        //设置标签按钮
        [self setUpTab];
        
        _isInitial = YES;
    }
}

#pragma mark- 设置并添加内容视图
- (void)setUpContentView {
    //创建流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //滚动方向设置为水平方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //item 尺寸为全屏
    flowLayout.itemSize = UIScreen.mainScreen.bounds.size;
    //最小行间距设置为 0
    flowLayout.minimumLineSpacing = 0;
    
    //创建 CollectionView
    _contentView = [[UICollectionView alloc] initWithFrame:UIScreen.mainScreen.bounds collectionViewLayout:flowLayout];
    //注册 UICollectionViewCell
    [_contentView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:ID];

    //取消过大指示条
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.showsVerticalScrollIndicator = NO;
    //启动分页
    _contentView.pagingEnabled = YES;
    //取消弹簧效果
    _contentView.bounces = NO;
    
    //设置代理
    _contentView.dataSource = self;
    _contentView.delegate = self;
    
    [self.view addSubview:_contentView];
    
    //凡是在导航控制器或TabBar控制器下的(继承自)scrollView,自动设置设置内边距
    if (@available(iOS 11.0, *)) {
        _contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark- 设置顶部标签栏
- (void)setUpTopTabBar {
    //创建创建顶部标签栏
    _topTabBar = [[UIScrollView alloc] init];
    //取消垂直滚动条
    _topTabBar.showsVerticalScrollIndicator = NO;
    //取消水平滚动条
    _topTabBar.showsHorizontalScrollIndicator = NO;
    
    CGFloat topTabBarY = kSTATUS_BAR_HEIGHT;
    //有导航控制器且导航条不隐藏
    if (self.navigationController && !self.navigationController.navigationBarHidden) {
        topTabBarY = kSTATUS_BAR_HEIGHT + kNAVIGATION_BAR_HEIGHT;
    }
    
    self.topTabBar.frame = CGRectMake(0,topTabBarY, kSCREEN_WIDTH, kTOP_TAB_BAR_HEIGHT);
    //设置背景颜色
    _topTabBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    //
    [self.view addSubview:_topTabBar];
}

#pragma mark - 计算 按钮宽度 并保存到数组
- (void)setUpTabWidth {
    //标签标题总宽
    CGFloat totalTitleWidth = 0;
    //标签标题间距(默认间距)
    CGFloat margin = kTOP_TAB_TITLE_MARGIN;
    //标签个数
    NSUInteger count = self.childViewControllers.count;
    //标签标题宽度的数组
    NSMutableArray *titleWidths = [NSMutableArray array];
    //获取所有标签标题
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    
    //遍历所有标签标题
    for (NSString *title in titles) {
        //判断标题是否为空. 为空抛出异常
        if ([title isKindOfClass:NSNull.class]) {// 抛异常
            NSException *excp = [NSException exceptionWithName:@""reason:@"没有设置子控制器的title属性" userInfo:nil];
            [excp raise];
        }
        //计算标签标题宽
        CGFloat titleWidth = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kTITLE_BAR_FONT} context:nil].size.width;
        
        //将标签标题宽保存到临时数组
        [titleWidths addObject:@(titleWidth)];
        
        //标签标题总宽
        totalTitleWidth += titleWidth;
    }
    
    //判断 (标签标题总宽 + 标签标题总间距) 是否能占据整个屏幕
    if ((totalTitleWidth + count * margin) < kSCREEN_WIDTH) {
        //不能占据整个屏幕, 重新计算标签标题间距 = (屏幕宽 - 标题总宽) / 标签数
        margin = (kSCREEN_WIDTH - totalTitleWidth) / count;
    }

    //确保将标签宽度数组初始值为空
    [self.tabWidths removeAllObjects];
    
    //保存标签宽度(标题宽 + 标题间距)到数组
    for (NSNumber *width in titleWidths) {
        [self.tabWidths addObject:@(width.floatValue + margin)];
    }
}

#pragma mark- 设置所有标题
/// 设置并添加标签
- (void)setUpTab {
    
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = 0;
    CGFloat titleH = kTOP_TAB_BAR_HEIGHT;
    
    //获取所有标题
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    //获取标题的数
    NSUInteger count = titles.count;
    
    //根据所有标题创建并设置标签按钮
    for (int i = 0; i < count; i++) {
        //创建标签按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置标记
        button.tag = i;
        //设置文字大小
        button.titleLabel.font = kTITLE_BAR_FONT;
        //设置标题
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //设置标题颜色
        [button setTitleColor:kTITLE_CLOCR_NORMAL forState:UIControlStateNormal];
        //设置选中标题颜色
        [button setTitleColor:kTITLE_CLOCR_SELECTED forState:UIControlStateSelected];
        
        //计算 titleX
        if (i) titleX += [self.tabWidths[i-1] floatValue];
        //获取 titleW
        titleW = [self.tabWidths[i] floatValue];
        //设置按钮 frame
        button.frame = CGRectMake(titleX, titleY, titleW, titleH);
        
        // 保存到标签数组
        [self.tabs addObject:button];
        
        //监听标签点击
        [button addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //默认选中第0个标签
        if (i == _selectIndex) [self tabClick:button];
        
        // 设置标题滚动视图的内容范围
        UILabel *lastButton = self.tabs.lastObject;
        self.topTabBar.contentSize = CGSizeMake(CGRectGetMaxX(lastButton.frame), 0);
        
        //添加到 topTabBar
        [self.topTabBar addSubview:button];
    }
}

#pragma mark- 标题点击
/// 点击标签
/// @param button 点击的标签
- (void)tabClick:(UIButton *)button {
    //1. 选中标签
    [self selectedTab:button];
    //2. 内容滚动视图滚动到对应位置
    self.contentView.contentOffset = CGPointMake(button.tag * kSCREEN_WIDTH, 0);
}
/// 选中标签
/// @param button 选中的标签
- (void)selectedTab:(UIButton *)button {
    //1. 取消前一个标记选中标签的选中状态
    self.selectButton.selected = NO;
    //2. 当前标签设置为选中状态
    button.selected = YES;
    //3. 设置标记选中标签为当前标签
    self.selectButton = button;
    //4.滚动标签至居中
    [self scrollTabToCenter:button];
    //5. 移动下划线到当前标签
    [UIView animateWithDuration:0.1 animations:^{
        self.underLine.centerX = button.centerX;
   }];
}
/// 滚动标签至居中
- (void)scrollTabToCenter:(UIButton *)button {
    // 计算标签到屏幕中心的偏移量: 按钮中心到屏幕中心的距离
    CGFloat offsetX = button.center.x - kSCREEN_WIDTH * 0.5;
    //如果 偏移量 小于0 ,将 偏移量 = 0
    offsetX = offsetX < 0 ? 0 : offsetX;
    //最大偏移量
    CGFloat maxOffsetX = self.topTabBar.contentSize.width - kSCREEN_WIDTH;
    //如果 偏移量 大于 最大偏移量,将 偏移量 = 最大偏移量
    offsetX = offsetX > maxOffsetX ? maxOffsetX : offsetX;
    //设置滚动到指定点动画
    [self.topTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //移除之前子控制器的view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //切换子控制器
    UITableViewController *vc = self.childViewControllers[indexPath.row];
    
    //控制器视图的 frame 开始 可能不是(0, 0, 屏幕宽, 屏幕高) 所有重新设置我全屏
    vc.tableView.frame = UIScreen.mainScreen.bounds;
    //
    [cell.contentView addSubview:vc.view];
    //设置内边距
    if (@available(iOS 11.0, *)) {
         vc.tableView.contentInset = UIEdgeInsetsMake(kSTATUS_BAR_HEIGHT, 0, 0, 0);
    }
    else {
        vc.tableView.contentInset = UIEdgeInsetsMake(kTOP_TAB_BAR_HEIGHT + kNAVIGATION_BAR_HEIGHT + kSTATUS_BAR_HEIGHT, 0, kTAB_BAR_HEIGHT, 0);
    }
    
    return cell;
}

#pragma mark- UICollectionViewDelegate
/// 滚动已结束，正在减速滚动移动时调用
/// @param scrollView 滚动视图
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //计算当前页数:
    NSInteger page = scrollView.contentOffset.x / kSCREEN_WIDTH;
    
    //选中当前页对应的标签
    [self selectedTab:self.tabs[page]];
}
@end
