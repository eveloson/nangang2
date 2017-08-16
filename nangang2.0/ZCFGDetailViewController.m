//
//  ZCFGDetailViewController.m
//  nangang2.0
//
//  Created by wubin on 2017/8/10.
//  Copyright © 2017年 Zhou. All rights reserved.
//
#import "UITableView+FDTemplateLayoutCell.h"
#import "ZCFGDetailViewController.h"
#import "NewsDetailCell.h"
#import "CommentCell.h"
#import <UIButton+SSEdgeInsets.h>
@interface ZCFGDetailViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) UIView *footer;
@property (weak, nonatomic) UIButton *zan;
@property (weak, nonatomic) UIButton *comment;
@end

@implementation ZCFGDetailViewController
- (void)setNewsInfo:(ZCFGDetail *)newsInfo{
    _newsInfo = newsInfo;
    [self setupComments];
}
- (void)setupComments{
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@%@",ServerName,@"TabCommentHandler.ashx?Action=getCommentlist"] parameters:@{@"talkid":self.newsInfo.Id} success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            self.dataSource = [[Comment objectArrayWithKeyValuesArray:json[@"Rows"]] mutableCopy];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    } loadingMsg:nil errorMsg:nil];
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewsDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NewsDetailCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CommentCell class])];
    [self setupFooter];
}
- (void)setupFooter{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    footer.backgroundColor = ThemeColor;
    self.footer = footer;
    [[UIApplication sharedApplication].delegate.window addSubview:footer];
    
    UIButton *zan = [UIButton new];
    self.zan = zan;
    NSString *zanImageName = nil;
    if (self.newsInfo.flag == 0) {
        zanImageName = @"赞";
    } else {
        zanImageName = @"赞1";
    }
    [zan setImage:[UIImage imageNamed:zanImageName] forState:UIControlStateNormal];
    [zan.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [zan addTarget:self action:@selector(zanClick) forControlEvents:UIControlEventTouchDown];
    UIButton *comment = [UIButton new];
    self.comment = comment;
    [comment setImage:[UIImage imageNamed:@"回复2"] forState:UIControlStateNormal];
    [comment setImage:[UIImage imageNamed:@"回复"] forState:UIControlStateHighlighted];
    [comment.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [comment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchDown];
    [footer addSubview:comment];
    [footer addSubview:zan];
    [self.zan makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footer);
        make.centerX.equalTo(footer).multipliedBy(0.5);
        make.height.equalTo(30);
        make.width.equalTo(60);
    }];
    [self.comment makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footer);
        make.centerX.equalTo(footer).multipliedBy(1.5);
        make.height.equalTo(30);
        make.width.equalTo(60);
    }];
    [self.comment setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
    [self.zan setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
}
- (void)zanClick{
    NSString *method = nil;
    if (self.newsInfo.flag == 0) {
        method = @"addZan";
    } else {
        method = @"deleteZan";
    }
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@TabZambiaHandler.ashx?Action=%@",ServerName,method] parameters:@{@"ParentId":self.newsInfo.Id,@"UserId":UserID} success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            if (self.newsInfo.flag == 0) {
                self.newsInfo.flag = 1;
                [self.zan setImage:[UIImage imageNamed:@"赞1"] forState:UIControlStateNormal];
            } else {
                self.newsInfo.flag = 0;
                [self.zan setImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    } loadingMsg:nil errorMsg:nil];
}
- (void)commentClick{
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.footer.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.footer.hidden = YES;
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
    if (indexPath.section == 0) {
        NewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewsDetailCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.newsInfo = self.newsInfo;
        return cell;
    } else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommentCell class])];
        cell.comment = self.dataSource[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([NewsDetailCell class]) configuration:^(NewsDetailCell *cell) {
            cell.newsInfo = self.newsInfo;
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([CommentCell class]) configuration:^(CommentCell *cell) {
            cell.comment = self.dataSource[indexPath.row];
        }];
    }
}
@end
