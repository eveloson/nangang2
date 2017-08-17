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
#import "AddCommentViewController.h"
@interface ZCFGDetailViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) UIView *footer;
@property (strong, nonatomic) UIButton *zan;
@property (strong, nonatomic) UIButton *comment;
@end

@implementation ZCFGDetailViewController
@synthesize dataSource = _dataSource;
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    NSString *commentStr = nil;
    if (dataSource.count == 0) {
        commentStr = @"评论";
    } else {
        commentStr = [NSString stringWithFormat:@"%ld",self.newsInfo.commentcount];
    }
    [self.comment setTitle:commentStr forState:UIControlStateNormal];
}
- (void)setNewsInfo:(ZCFGDetail *)newsInfo{
    _newsInfo = newsInfo;
    
    NSString *zanStr = nil;
    if (self.newsInfo.zanmbiancount == 0) {
        zanStr = @"赞";
    } else {
        zanStr = [NSString stringWithFormat:@"%ld",self.newsInfo.zanmbiancount];
    }
    [self.zan setTitle:zanStr  forState:UIControlStateNormal];
    NSString *commentStr = nil;
    if (self.newsInfo.zanmbiancount == 0) {
        commentStr = @"评论";
    } else {
        commentStr = [NSString stringWithFormat:@"%ld",self.newsInfo.commentcount];
    }
    [self.comment setTitle:commentStr forState:UIControlStateNormal];
    
    [self setupComments];
   
}
- (UIButton *)zan{
    if (!_zan) {
        _zan = [UIButton new];
    }
    return _zan;
}
- (UIButton *)comment{
    if (!_comment) {
        _comment = [UIButton new];
    }
    return _comment;
}
- (void)setupComments{
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@%@",ServerName,@"TabCommentHandler.ashx?Action=getCommentlist"] parameters:@{@"talkid":self.newsInfo.Id} success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            NSArray *data = json[@"data"];
            self.dataSource = [[Comment objectArrayWithKeyValuesArray:data                                                                      ] mutableCopy];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    } loadingMsg:nil errorMsg:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewsDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NewsDetailCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CommentCell class])];
    [self setupFooter];
}
- (void)setupFooter{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    footer.backgroundColor = ThemeColor;
    self.footer = footer;
    [[UIApplication sharedApplication].delegate.window addSubview:footer];
    
    NSString *zanImageName = nil;
    if (self.newsInfo.flag == 0) {
        zanImageName = @"赞";
    } else {
        zanImageName = @"赞1";
    }
    [self.zan setImage:[UIImage imageNamed:zanImageName] forState:UIControlStateNormal];
    [self.zan.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.zan addTarget:self action:@selector(zanClick) forControlEvents:UIControlEventTouchDown];
    
    
    [self.comment setImage:[UIImage imageNamed:@"回复2"] forState:UIControlStateNormal];
    [self.comment setImage:[UIImage imageNamed:@"回复"] forState:UIControlStateHighlighted];
    [self.comment.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.comment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchDown];
    [footer addSubview:self.comment];
    [footer addSubview:self.zan];
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
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@TabZambiaHandler.ashx?Action=%@",ServerName,method] parameters:@{@"ParentId":self.newsInfo.Id,@"UserId":kUserID} success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            if (self.newsInfo.flag == 0) {
                self.newsInfo.flag = 1;
                self.newsInfo.zanmbiancount++;
                [self.zan setImage:[UIImage imageNamed:@"赞1"] forState:UIControlStateNormal];
            } else {
                self.newsInfo.zanmbiancount--;
                self.newsInfo.flag = 0;
                [self.zan setImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
            }
            [self.zan setTitle:[NSString stringWithFormat:@"%ld",self.newsInfo.zanmbiancount] forState:UIControlStateNormal];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    } loadingMsg:nil errorMsg:nil];
}
- (void)commentClick{
    AddCommentViewController *vc = [AddCommentViewController new];
    vc.vc = self;
    vc.newsInfo = self.newsInfo;
    push(vc);
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"评论";
    } else {
        return @"";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    } else{
        return 0.0001;
    }
}
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
        cell.vc = self;
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
