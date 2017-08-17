//
//  MainTabBarViewController.m
//  heduinet
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 冲浪科技. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "BaseNaviController.h"


@interface MainTabBarViewController (){
    
}

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTabBar];
    [self setupNavigationTitleLabelStyle];
    self.selectedIndex = 0;
}

-(void)setupTabBar{
    if (!self.indexController)
    {
        self.indexController = [[IndexViewController alloc] init];
    }
//    if (!self.informationController)
//    {
//        self.informationController = [[informationViewController alloc]init];
//    }
//    if (!self.dynamicController) {
//        self.dynamicController = [[dynamicViewController alloc]init];
//    }
    if (!self.personController) {
        self.personController = [[PersonCenterViewController alloc] init];
    }
    UIImage *indexImagepressed = [UIImage imageNamed:@"shouyeed.png"];
    indexImagepressed = [indexImagepressed imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *indexImage = [UIImage imageNamed:@"shouye.png"];
    indexImage = [indexImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.indexController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:indexImage selectedImage:indexImagepressed];
//    
//    UIImage *inforImagepressed = [UIImage imageNamed:@"inforImagepressed.png"];
//    inforImagepressed = [inforImagepressed imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage *inforImage = [UIImage imageNamed:@"infor.png"];
//    inforImage = [inforImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.informationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"资讯" image:inforImage selectedImage:inforImagepressed];
//    
//    UIImage *dynamicImagepressed = [UIImage imageNamed:@"dynamicImagepressed.png"];
//    dynamicImagepressed = [dynamicImagepressed imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage *dynamicImage = [UIImage imageNamed:@"dynamic.png"];
//    dynamicImage = [dynamicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.dynamicController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"动态" image:dynamicImage selectedImage:dynamicImagepressed];
    UIImage *personImagepressed = [UIImage imageNamed:@"gerened.png"];
    personImagepressed = [personImagepressed imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *personImage = [UIImage imageNamed:@"geren.png"];
    personImage = [personImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.personController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:personImage selectedImage:personImagepressed];
    
   
    self.indexController.tabBarItem.tag = 0;
//    self.informationController.tabBarItem.tag = 1;
//    self.dynamicController.tabBarItem.tag = 2;
    self.personController.tabBarItem.tag = 1;
    [self settabbarItemTextColor];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
//    NSArray *views = @[self.indexController,self.sellerController,self.personController,self.moreController];
    NSArray *views = @[self.indexController,self.personController];
    for (UIViewController *viewcontroller in views) {
        BaseNaviController *basenav = [[BaseNaviController alloc] initWithRootViewController:viewcontroller];
        [viewControllers addObject:basenav];
        basenav.delegate = self;
    }
    self.viewControllers = viewControllers;
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [self settabbarItemTextColor];
    self.selectedIndex = item.tag;
}


-(void)settabbarItemTextColor{
    [self.indexController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//    [self.informationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//    [self.dynamicController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.personController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
}

//更改navigation title的颜色
- (void)setupNavigationTitleLabelStyle
{
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"GillSans-Light" size:18] forKey:NSFontAttributeName];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

#pragma mark - UINavigationContoller Delegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSUInteger count = navigationController.viewControllers.count;
    if (count == 1) {
        self.tabBar.hidden = NO;
    }else{
        self.tabBar.hidden = YES;
    }
}

@end
