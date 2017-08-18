//
//  NewsDetailCell.m
//  nangang2.0
//
//  Created by wubin on 2017/8/14.
//  Copyright © 2017年 Zhou. All rights reserved.
//
#import "SJAvatarBrowser.h"
#define kHeadTMargin 15

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
        make.height.equalTo(kHeadH);
        make.width.equalTo(0.001);
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
        //为UIImageView1添加点击事件
        UIImageView *image = self.imageArray[i];
        UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
        [image addGestureRecognizer:tapGestureRecognizer1];
        //让UIImageView和它的父类开启用户交互属性
        [image setUserInteractionEnabled:YES];
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
-(void)scanBigImageClick1:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [SJAvatarBrowser showImageWithImageView:clickedImageView];
}
- (void)setNewsInfo:(ZCFGDetail *)newsInfo{
    _newsInfo = newsInfo;
    self.title.text = newsInfo.Adder;
    self.content.text = newsInfo.content;
//    self.time.text = newsInfo.fbTime;
    for (int i=0; i<self.imageArray.count; i++) {
        UIImageView *image = self.imageArray[i];
        if (i<newsInfo.ImgUrl.count) {
            NSString *url = [NSString stringWithFormat:@"%@%@",ServerHost,newsInfo.ImgUrl[i]];
            url = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
            [image sd_setImageWithURL:[NSURL URLWithString:url]];
            [image updateConstraints:^(MASConstraintMaker *make) {
                make.height.width.equalTo(kImageHW);
            }];
        } else {
            [image updateConstraints:^(MASConstraintMaker *make) {
                make.height.width.equalTo(0);
                if (i==0) {
                    make.top.equalTo(self.content.bottom);
                } else {
                    make.top.equalTo([self.imageArray[i-1] mas_bottom]);
                }
            }];
        }
    }
}
@end
