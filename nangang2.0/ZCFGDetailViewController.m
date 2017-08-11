//
//  ZCFGDetailViewController.m
//  nangang2.0
//
//  Created by wubin on 2017/8/10.
//  Copyright © 2017年 Zhou. All rights reserved.
//
#import "UITableView+FDTemplateLayoutCell.h"
#import "ZCFGDetailViewController.h"

@interface ZCFGDetailViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ZCFGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.dataSource.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath == 0) {
        NewsCell *cell = [NewsCell cellWithTableView:tableView];
        cell.newsInfo = self.detail;
        return cell;
//    } else {
//        
//    }
}

@end
