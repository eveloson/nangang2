//
//  BaseViewController.m
//  heduinet
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 冲浪科技. All rights reserved.
//

#import "BaseNaviController.h"

@interface BaseNaviController ()
@end

@implementation BaseNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version>=5.0) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"daohangtiao.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationBar setNeedsDisplay];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
