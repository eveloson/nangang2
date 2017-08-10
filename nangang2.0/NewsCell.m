//
//  NewsCell.m
//  DangJian
//
//  Created by wubin on 2017/7/25.
//  Copyright © 2017年 clkeji. All rights reserved.
//

#import "NewsCell.h"
#import <UIButton+SSEdgeInsets.h>
@interface NewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArray;
@property (weak, nonatomic) IBOutlet UIButton *zan;
@property (weak, nonatomic) IBOutlet UIButton *comment;

@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"NewsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil] lastObject];
        [cell.head makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(15);
            make.top.equalTo(cell).offset(kHeadTMargin);
            make.height.width.equalTo(kHeadH);
        }];
        [cell.title makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.head.right).offset(10);
            make.right.equalTo(cell);
            make.centerY.equalTo(cell.head);
            make.height.equalTo(cell.head);
        }];
        [cell.content makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(kImageLRMargin);
            make.right.equalTo(cell).offset(-kImageLRMargin);
            make.top.equalTo(cell.head.mas_bottom).offset(kContentTMargin);
            make.height.equalTo(kContentH);
        }];
        for (int i=0; i<cell.imageArray.count; i++) {
            [cell.imageArray[i] makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.content.bottom);
                make.left.equalTo(cell).offset(kImageLRMargin + i * (kImageHW+kImageMargin));
                make.height.width.equalTo(kImageHW);
            }];
        }
        [cell.time makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.content);
            make.top.equalTo([cell.imageArray[0] mas_bottom]);
            make.width.equalTo(120);
            make.height.equalTo(kTimeH);
        }];
        [cell.comment makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell).offset(-kImageLRMargin);
            make.height.equalTo(30);
            make.width.equalTo(60);
            make.centerY.equalTo(cell.time);
        }];
        [cell.zan makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.comment.left);
            make.height.equalTo(30);
            make.width.equalTo(60);
            make.centerY.equalTo(cell.time);
        }];
        [cell.comment setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
        [cell.zan setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
    }
    return cell;
}
- (void)setNewsInfo:(ZCFGDetail *)newsInfo{
    _newsInfo = newsInfo;
    self.title.text = newsInfo.Adder;
    self.content.text = newsInfo.content;
    self.time.text = newsInfo.fbTime;
    for (int i=0; i<self.imageArray.count; i++) {
        UIImageView *image = self.imageArray[i];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.201:50485%@",newsInfo.ImgUrl]]];
    }
//    self.title.text = newsInfo.title;
//    self.content.text = newsInfo.fbt;
//    self.time.text = newsInfo.date;
}
@end
