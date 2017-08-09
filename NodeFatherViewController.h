//
//  NodeFatherViewController.h
//  AutoLayout
//
//  Created by wubin on 2017/6/2.
//  Copyright © 2017年 wubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "WDZAFNetworking.h"
#import "MJExtension.h"
@interface NodeFatherViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *dataSource;
- (void)refreshData;
- (void)loadMoreData;
@end
