//
//  ZhouBianShiViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/7/20.
//  Copyright © 2017年 Zhou. All rights reserved.
//
#import "ZCFGDetailViewController.h"
#import "ReplyViewController.h"
#import "NewsCell.h"
#import "ZhouBianShiViewController.h"
#import "AddMsgViewController.h"
@interface ZhouBianShiViewController ()

@end

@implementation ZhouBianShiViewController
int newsPageindex = 0;
- (void)refreshData{
    [self.dataSource removeAllObjects];
    newsPageindex = 0;
    [self loadMoreData];
    //    [WDZAFNetworking get:[NSString stringWithFormat:@"%@%@",HOSTURL,@"GetNewsList"] parameters:@{@"Typeid":[NSString stringWithFormat:@"%ld",self.view.tag],@"pageindex":@"0",@"pagesize":NewsPagesize} success:^(id  _Nonnull json) {
////        self.dataSource = [[ZCFGDetail objectArrayWithKeyValuesArray:json[@"data"]] mutableCopy];
//        if ([json[@"status"] isEqualToString:@"sucess"]) {
//            newsPageindex = 0;
//        }
//        [self.tableView.mj_header endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self.tableView.mj_header endRefreshing];
//    } loadingMsg:@"正在加载ing" errorMsg:nil];
}
- (void)loadMoreData{
    [super loadMoreData];
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@%@",ServerName,@"huoquTalk"] parameters:@{@"Typeid":[NSString stringWithFormat:@"%ld",self.view.tag],@"pagesize":NewsPagesize,@"pageindex":[NSString stringWithFormat:@"%d",newsPageindex+1]} success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            NSArray *dataArray = [ZCFGDetail objectArrayWithKeyValuesArray:json[@"Rows"]];
            [self.dataSource insertObjects:dataArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.dataSource.count, dataArray.count)]];
            [self.tableView reloadData];
            newsPageindex++;
        }
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    } loadingMsg:@"正在加载ing" errorMsg:nil];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeadTMargin+kHeadH+kContentTMargin+kContentH+kImageHW+kTimeH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [NewsCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.newsInfo = self.dataSource[indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    push([ZCFGDetailViewController new]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMsg)];
    [self refreshData];
}

- (void)addMsg{
    [self.navigationController pushViewController:[AddMsgViewController new] animated:YES];
}

@end
