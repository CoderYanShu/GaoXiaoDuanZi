//
//  main.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/12.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// main是函数的名称, 是系统规定的名称, 系统启动程序就会调用名称叫做main的函数
// main函数只能由系统调用 ,不能手动调用

// 其实系统在启动程序的时候, 会给我们的程序传递一些参数
//第一个参数  argc : 就是系统传递进来的参数个数, 默认是1
//第二个参数  argv : 就是系统传递进来的参数实际的值, 默认是程序的名称
//第三个参数 nil:代表UIApplication类名或者子类名称，nil 相当于 @"UIApplicaiton";
//第四个参数 ：代表UIApplicaiton的代理名称 NSStringFromClass([AppDelegate class] 相当于 @"AppDelegate";
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
/**
1.执行main

2.执行UIApplicationMain
   2.1根据传递的类名创建UIApplication对象，这是第一个对象

   2.2根据传递的appDelegateClassName创建UIApplication代理对象，并给UIApplicaiton对象设置代理

   2.3开启主运行循环 main events loop处理事件，保持程序一直运行进行事件的处理

   2.4加载info.plist. 判断info.plist当中有没有指定Main.如果指定的话,
          加载Main.storyBaord.把Main.storyBaord当中剪头指向的控制器的View显示出来.
 
        { 系统自动帮你做的事.
             加载Main.storyBaord.加载之前会创建一个UIWindow.
             
             每一个UIWindow都必须得要有一个根控制器.rootViewController.
             会把把Main.storyBaord当中剪头指向的控制器设置为UIWindow的rootViewController
             设置的目的是强引用剪头指向的控制器,让它不释放.
             
             把Main.storyBaord当中剪头指向的控制器的View添加到UIWindow,让UIWindow显示出来.
         }

   2.5 通知应用程序代理,应用程序启动完毕.didFinishLaunchingWithOptions
*/
