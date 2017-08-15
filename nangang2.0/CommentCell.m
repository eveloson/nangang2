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
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
