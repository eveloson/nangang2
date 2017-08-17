//
//  CommentCell.m
//  nangang2.0
//
//  Created by wubin on 2017/8/14.
//  Copyright © 2017年 Zhou. All rights reserved.
//
#import <UITableView+FDTemplateLayoutCell.h>
#import "ReplyCell.h"
#import "CommentCell.h"
#import "ZCFGDetailViewController.h"
#import "AddReplyViewController.h"
#import <UIButton+SSEdgeInsets.h>
@interface CommentCell ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.name.textColor = RGB(87, 107, 149);
    [self.name makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(5);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(17);
    }];
    [self.commentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.width.equalTo(100);
        make.height.equalTo(30);
        make.centerY.equalTo(self.name);
    }];
    [self.commentBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
    self.content.preferredMaxLayoutWidth = ScreenWidth - 2*10;
    [self.content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.content makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.top.equalTo(self.name.bottom).offset(8);
    }];
    [self.time makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.top.equalTo(self.content.bottom).offset(5);
        make.height.equalTo(15);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.top.equalTo(self.time.bottom).offset(5);
        make.height.equalTo(0);
        make.bottom.offset(-10);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReplyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ReplyCell class])];
    self.tableView.backgroundColor = RGB(244, 244, 244);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)setComment:(Comment *)comment{
    _comment = comment;
    self.name.text = comment.UserName;
    self.content.text = [NSString stringWithFormat:@"%@",comment.CommentMsg];
    self.time.text = comment.ReplayTime;
    self.dataSource = [comment.Commens mutableCopy];
    [self.tableView reloadData];
    CGFloat tableViewH = 0.0;
    for (int i=0; i<self.dataSource.count; i++) {
        tableViewH+= [self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
    }
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(tableViewH);
    }];
}
- (IBAction)replyClick:(UIButton *)sender {
    AddReplyViewController *vc = [AddReplyViewController new];
    vc.vc = self.vc;
    vc.comment = self.comment;
    [self.vc.navigationController pushViewController:vc animated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReplyCell class])];
    cell.comment = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ReplyCell class]) configuration:^(ReplyCell *cell) {
        cell.comment = self.dataSource[indexPath.row];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
@end
