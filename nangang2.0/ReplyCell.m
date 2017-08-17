//
//  ReplyCell.m
//  nangang2.0
//
//  Created by wubin on 2017/8/15.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "ReplyCell.h"

@interface ReplyCell ()
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation ReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGB(244, 244, 244);
    self.content.preferredMaxLayoutWidth = ScreenWidth - 2*15;
    [self.content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.content makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(5);
        make.bottom.equalTo(-5);
        make.left.equalTo(15);
        make.right.equalTo(-15);
    }];
}

- (void)setComment:(Comment *)comment{
    _comment = comment;
    self.content.text = [NSString stringWithFormat:@"%@:%@",comment.UserName,comment.CommentMsg];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
