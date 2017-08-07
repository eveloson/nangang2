//
//  AppDelegate.m
//  nangang2.0
//
//  Created by 周家新 on 17/7/10.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BaseNaviController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (GETACCESSTOKEN == nil)
    {
        // 根本就没有登录过
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        BaseNaviController *basenav = [[BaseNaviController alloc] initWithRootViewController:loginVC];
       [[UIApplication sharedApplication].delegate window].rootViewController =basenav;

    }
    else
    {
        _mainView = [[MainTabBarViewController alloc] init];
        _mainView = [[MainTabBarViewController alloc]init];
        [[UIApplication sharedApplication].delegate window].rootViewController = _mainView;


    }
   
       return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
