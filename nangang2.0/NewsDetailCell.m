//
//  NewsDetailCell.m
//  nangang2.0
//
//  Created by wubin on 2017/8/14.
//  Copyright © 2017年 Zhou. All rights reserved.
//
#define kHeadTMargin 15
#define kHeadH 40
#define kContentTMargin 10
#define kContentH 50
#define kImageLRMargin 30
#define kImageMargin 15
#define kImageHW (ScreenWidth-kImageLRMargin*2)
#define kTimeH 40
#import "NewsDetailCell.h"

@interface NewsDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
//@property (weak, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArray;
//@property (weak, nonatomic) IBOutlet UIButton *zan;
//@property (weak, nonatomic) IBOutlet UIButton *comment;
@end

@implementation NewsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.textColor = RGB(87, 107, 149);
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
            if (i==0) {
                 make.top.equalTo(self.content.bottom).offset(kImageMargin);
            } else {
                make.top.equalTo([self.imageArray[i-1] mas_bottom]).offset(kImageMargin);
            }
            make.left.equalTo(kImageLRMargin);
            make.height.width.equalTo(kImageHW);
            if (i==self.imageArray.count-1) {
                make.bottom.equalTo(-10);
            }
        }];
    }
//    [self.time makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.content);
//        make.top.equalTo([self.imageArray[0] mas_bottom]);
//        make.width.equalTo(120);
//        //        make.height.equalTo(kTimeH);
//        make.bottom.equalTo(-10);
//    }];
//    [self.comment makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(-kImageLRMargin);
//        make.height.equalTo(30);
//        make.width.equalTo(60);
//        make.centerY.equalTo(self.time);
//    }];
//    [self.zan makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.comment.left);
//        make.height.equalTo(30);
//        make.width.equalTo(60);
//        make.centerY.equalTo(self.time);
//    }];
//    [self.comment setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
//    [self.zan setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
}
- (void)setNewsInfo:(ZCFGDetail *)newsInfo{
    _newsInfo = newsInfo;
    self.title.text = newsInfo.Adder;
    self.content.text = newsInfo.content;
//    self.time.text = newsInfo.fbTime;
    for (int i=0; i<self.imageArray.count; i++) {
        UIImageView *image = self.imageArray[i];
        if (i<3)
        {
            [image updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(kImageHW);
            }];
            [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502448586406&di=5a716ca57a945638b116e4510ca7f5cf&imgtype=0&src=http%3A%2F%2Fimg002.21cnimg.com%2Fphotos%2Fshe_0%2F20140717%2Fc100-0-0-477-445_r0%2F61FF69160D0AB0DB7E837160788B13D4.jpeg"]];
        }
        else
        {
            [image updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(0);
            }];
        }
    }
}
@end
