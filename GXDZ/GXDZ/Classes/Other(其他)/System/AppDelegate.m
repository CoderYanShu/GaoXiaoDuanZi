//
//  AppDelegate.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/12.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYAdvertController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] init];
    
    ZYAdvertController *vc = [[ZYAdvertController alloc] init];
    
    _window.rootViewController = vc;
    
    [_window makeKeyAndVisible];
    

    return YES;
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
}
@end
