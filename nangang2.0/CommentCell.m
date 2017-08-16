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

@interface CommentCell ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.name makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(5);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(17);
    }];
    self.content.preferredMaxLayoutWidth = ScreenWidth - 2*10;
    [self.content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.content makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.top.equalTo(self.name.bottom).offset(8);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.top.equalTo(self.content.bottom).offset(5);
        make.bottom.offset(-10);
    }];
}
- (void)setComment:(Comment *)comment{
    _comment = comment;
    self.name.text = comment.UserName;
    self.content.text = [NSString stringWithFormat:@"%@",comment.CommentMsg];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReplyCell class])];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ReplyCell class]) configuration:^(ReplyCell *cell) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
@end
