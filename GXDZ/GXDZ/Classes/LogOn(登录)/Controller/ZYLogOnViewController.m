//
//  ZYLogOnViewController.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/13.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYLogOnViewController.h"

@interface ZYLogOnViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dismissBitton;

@end

@implementation ZYLogOnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消按钮点击时的高亮状态
    _dismissBitton.adjustsImageWhenHighlighted = NO;
    
    //添加轻扫手势
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissButtonClick)];
    
    //设置轻扫的方向, 一个轻扫手势只能对应一个方向
    swipeGR.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGR];
}

- (IBAction)dismissButtonClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
