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
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@%@",ServerName,@"getCommentlist"] parameters:@{@"talkid":self.newsInfo.ID} success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            self.dataSource = [[Comment objectArrayWithKeyValuesArray:json[@"Rows"]] mutableCopy];;
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
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-60, ScreenWidth, 60)];
    footer.backgroundColor = ThemeColor;
    self.footer = footer;
    [[UIApplication sharedApplication].delegate.window addSubview:footer];
    
    UIButton *zan = [UIButton new];
    [zan setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    [zan.titleLabel setFont:[UIFont systemFontOfSize:14]];
    UIButton *comment = [UIButton new];
    [comment setImage:[UIImage imageNamed:@"回复"] forState:UIControlStateNormal];
    [comment.titleLabel setFont:[UIFont systemFontOfSize:14]];
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
        make.centerX.equalTo(footer).multipliedBy(0.75);
        make.height.equalTo(30);
        make.width.equalTo(60);
    }];
    [self.comment setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
    [self.zan setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
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
