//
//  ZYAdvertController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/12.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYAdvertController.h"
#import "ZYTabBarController.h"
#import "ZYAdvertItem.h"
#import "ZYNetworkTool.h"

@interface ZYAdvertController ()

/// 广告视图
@property (nonatomic, weak) IBOutlet UIImageView *advertView;
/// 广告提前跳过按钮
@property (nonatomic, weak) IBOutlet UIButton *jumpButton;
/// 广告定时器
@property (nonatomic, weak) NSTimer *advertTimer;
/// 广告模型
@property (nonatomic, strong) ZYAdvertItem *advertItem;

@property (nonatomic ,strong) AFHTTPSessionManager *manager;

@end

@implementation ZYAdvertController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //初始化
    [self setUp];
    
    //加载广告数据
    [self loadData];
}

#pragma mark- 初始化设置
- (void)setUp {
    //设置跳过按钮背景颜色
    _jumpButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
      //设置跳过按钮圆角
    _jumpButton.layer.cornerRadius = 5;
    
    //设置广告视图启用用户交互
    _advertView.userInteractionEnabled = YES;
    //设置广告视图内容模式为改变比例填充模式
    _advertView.contentMode = UIViewContentModeScaleAspectFill;
    
    //设置定时器
    _advertTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateAdvertTime) userInfo:nil repeats:YES];
    
    //添加点按手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterAdvertising)];
    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark-定时器
- (void)updateAdvertTime {
    //广告时间 3 秒
    static NSInteger advertTime = 3;

    //按钮标题每次减一
    NSString *title = [NSString stringWithFormat:@"跳过(%li)", --advertTime];
    
    //设置按钮标题
    [_jumpButton setTitle:title forState:UIControlStateNormal];
    
    //当按钮标题超过 0 时 跳转
    if (-1 == advertTime) [self jumpButtonClick];
}

#pragma mark- 实现手势方法
- (void)enterAdvertising {
    
    NSURL *url = [NSURL URLWithString:self.advertItem.url];
    
    //判断是否可用打开URL
    if ([UIApplication.sharedApplication canOpenURL:url]) {
        NSDictionary *dict = [NSDictionary dictionary];
        [UIApplication.sharedApplication openURL:url options:dict completionHandler:nil];
    }
}

#pragma mark- 加载广告数据
- (void)loadData {
    
    NSString *url = @"http://dspsdk.spriteapp.com/get";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"ad"] = @"self.baisibudejieHD.iphone.splash.18110717002";
    
    _manager = AFHTTPSessionManager.manager;
    [_manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"body"];
        dict = dict[@"data"];
        dict = dict[@"sdk.gdt.splash.iphone.HD-banping.193.109.1150.2891"];
        
        //根据字典创建模型
        self.advertItem = [ZYAdvertItem advertItemWithDict:dict];
        
        //设置广告图片
        [self.advertView sd_setImageWithURL: [NSURL URLWithString: self.advertItem.pic]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

#pragma mark- 跳转到 app 主控制器
- (IBAction)jumpButtonClick {
    //使定时器无效(停止计时器再次触发并请求将其从运行循环中移除)
    [self.advertTimer invalidate];
    
    //设置定时器为 nil
    self.advertTimer = nil;
    //创建 app 主控制器
    ZYTabBarController *tabBarVC = [[ZYTabBarController alloc] init];
    
    //设置 App rootViewController 为主控制器
    UIApplication.sharedApplication.keyWindow.rootViewController = tabBarVC;
}

#pragma mark- 视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //取消请求
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
@end
