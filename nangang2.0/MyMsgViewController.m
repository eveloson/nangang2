//
//  MyMsgViewController.m
//  nangang2.0
//
//  Created by wubin on 2017/8/17.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "MyMsgViewController.h"
#import "ZCFGDetailViewController.h"
#import "ReplyViewController.h"
#import "MyNewsCell.h"
@interface MyMsgViewController ()
@end

@implementation MyMsgViewController
int msgPageindex = 0;
- (void)refreshData{
    msgPageindex = 0;
    [self loadMoreData];
}
- (void)loadMoreData{
    [super loadMoreData];
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@%@",ServerName,@"tb_talkHandler.ashx?Action=getTalklist"] parameters:@{@"pagesize":NewsPagesize,@"userid":kUserID,@"pageindex":[NSString stringWithFormat:@"%d",msgPageindex+1]} success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            NSArray *data = json[@"data"];
            NSArray *dataArray = [ZCFGDetail objectArrayWithKeyValuesArray:data];
            if (msgPageindex == 0) {
                self.dataSource = [dataArray mutableCopy];
            } else {
                [self.dataSource insertObjects:dataArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.dataSource.count, dataArray.count)]];
            }
            [self.tableView reloadData];
            msgPageindex++;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } loadingMsg:nil errorMsg:nil];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    return kHeadTMargin+kHeadH+kContentTMargin+kContentH+kImageHW+kTimeH;
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([MyNewsCell class]) configuration:^(NewsCell *cell) {
        cell.newsInfo = self.dataSource[indexPath.section];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyNewsCell class])];
    cell.vc = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.newsInfo = self.dataSource[indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    ZCFGDetailViewController *vc = [ZCFGDetailViewController new];
    vc.newsInfo = self.dataSource[indexPath.section];
    push(vc);
    //    push([ZCFGDetailViewController new]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyNewsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyNewsCell class])];
    [self refreshData];
}

@end
