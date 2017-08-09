//
//  MainTabBarViewController.h
//  heduinet
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 冲浪科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexViewController.h"
#import "PersonCenterViewController.h"
#import "informationViewController.h"

@interface MainTabBarViewController : UITabBarController<UINavigationControllerDelegate>

@property(nonatomic,retain) IndexViewController *indexController;
@property(nonatomic,retain) PersonCenterViewController *personController;
@property(nonatomic,retain) informationViewController *informationController;
@end
