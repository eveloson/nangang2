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
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_TOKEN];
    NSString *str = [dic objectForKey:@"userid"];
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@%@",ServerName,@"tb_talkHandler.ashx?Action=huoquTalk"] parameters:@{@"pagesize":NewsPagesize,@"userid":str,@"pageindex":[NSString stringWithFormat:@"%d",newsPageindex+1]} success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            NSArray *data = json[@"data"];
            NSArray *dataArray = [ZCFGDetail objectArrayWithKeyValuesArray:data];
            if (newsPageindex == 0) {
                self.dataSource = [dataArray mutableCopy];
            } else {
                [self.dataSource insertObjects:dataArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.dataSource.count, dataArray.count)]];
            }
            [self.tableView reloadData];
            newsPageindex++;
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
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([NewsCell class]) configuration:^(NewsCell *cell) {
        cell.newsInfo = self.dataSource[indexPath.section];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewsCell class])];
//    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewsCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.newsInfo = self.dataSource[indexPath.section];
    cell.vc = self;
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
    self.title = @"南港那些事儿";
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMsg)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NewsCell class])];
    [self refreshData];
}
- (void)addMsg{
    AddMsgViewController *vc = [AddMsgViewController new];
    vc.vc = self;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
