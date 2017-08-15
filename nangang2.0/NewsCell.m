//
//  NewsCell.m
//  DangJian
//
//  Created by wubin on 2017/7/25.
//  Copyright © 2017年 clkeji. All rights reserved.
//
#define kHeadTMargin 15
#define kHeadH 40
#define kContentTMargin 10
#define kContentH 50
#define kImageLRMargin 30
#define kImageMargin 15
#define kImageHW (ScreenWidth-kImageLRMargin*2-kImageMargin*2)/3
#define kTimeH 40
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
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.head makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(kHeadTMargin);
        make.height.width.equalTo(kHeadH);
    }];
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.head.right).offset(10);
        make.right.equalTo(0);
        make.centerY.equalTo(self.head);
        make.height.equalTo(self.head);
    }];
    self.content.preferredMaxLayoutWidth = ScreenWidth - 2*kImageLRMargin;
    [self.content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.content makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kImageLRMargin);
        make.right.equalTo(-kImageLRMargin);
        make.top.equalTo(self.head.bottom).offset(kContentTMargin);
//        make.height.equalTo(kContentH);
    }];
    for (int i=0; i<self.imageArray.count; i++) {
        [self.imageArray[i] makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.content.bottom).offset(kContentTMargin);
            make.left.equalTo(kImageLRMargin + i * (kImageHW+kImageMargin));
            make.height.width.equalTo(kImageHW);
        }];
    }
    [self.time makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.content);
        make.top.equalTo([self.imageArray[0] mas_bottom]);
        make.width.equalTo(120);
//        make.height.equalTo(kTimeH);
        make.bottom.equalTo(-10);
    }];
    [self.comment makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kImageLRMargin);
        make.height.equalTo(30);
        make.width.equalTo(60);
        make.centerY.equalTo(self.time);
    }];
    [self.zan makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.comment.left);
        make.height.equalTo(30);
        make.width.equalTo(60);
        make.centerY.equalTo(self.time);
    }];
    [self.comment setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
    [self.zan setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
}
- (void)setNewsInfo:(ZCFGDetail *)newsInfo{
    _newsInfo = newsInfo;
    self.title.text = newsInfo.Adder;
    self.content.text = newsInfo.content;
    self.time.text = newsInfo.fbTime;
    for (int i=0; i<self.imageArray.count; i++) {
        UIImageView *image = self.imageArray[i];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502448586406&di=5a716ca57a945638b116e4510ca7f5cf&imgtype=0&src=http%3A%2F%2Fimg002.21cnimg.com%2Fphotos%2Fshe_0%2F20140717%2Fc100-0-0-477-445_r0%2F61FF69160D0AB0DB7E837160788B13D4.jpeg"]];
    }
    [self.zan setTitle:[NSString stringWithFormat:@"%ld",newsInfo.zanmbiancount]  forState:UIControlStateNormal];
    [self.comment setTitle:[NSString stringWithFormat:@"%ld",newsInfo.commentcount] forState:UIControlStateNormal];
}
@end
