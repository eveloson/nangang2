//
//  MyNewsCell.m
//  nangang2.0
//
//  Created by wubin on 2017/8/17.
//  Copyright © 2017年 Zhou. All rights reserved.
//
#import "MyMsgViewController.h"
#import "MyNewsCell.h"
#define kHeadTMargin 15
#define kContentTMargin 10
#define kContentH 50
#define kImageLRMargin 30
#define kImageMargin 15
#define kImageHW (ScreenWidth-kImageLRMargin*2-kImageMargin*2)/3
#define kTimeH 40
#import "NewsCell.h"
#import <UIButton+SSEdgeInsets.h>
@interface MyNewsCell ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArray;
@property (weak, nonatomic) IBOutlet UIButton *zan;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@end

@implementation MyNewsCell
- (IBAction)delBtnClick:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要删除这条动态吗？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [WDZAFNetworking get:[NSString stringWithFormat:@"%@%@",ServerName,@"tb_talkHandler.ashx?Action=deleteTalk"] parameters:@{@"Id":self.newsInfo.Id} success:^(id  _Nonnull json) {
            if ([json[@"result"] isEqualToString:@"success"]) {
                [self.vc refreshData];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        } loadingMsg:nil errorMsg:nil];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.head makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(kHeadTMargin);
        make.height.equalTo(kHeadH);
        make.width.equalTo(0.001);
    }];
    self.title.textColor = RGB(87, 107, 149);
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.head.right).offset(10);
        make.right.equalTo(0);
        make.centerY.equalTo(self.head);
        make.height.equalTo(self.head);
    }];
    [self.delBtn makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(30);
        make.centerY.equalTo(self.title);
        make.right.equalTo(-30);
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
            make.height.width.equalTo(0);
        }];
    }
    [self.time makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.content);
        make.top.equalTo([self.imageArray[0] mas_bottom]).offset(5);
        make.width.equalTo(150);
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
            }];
        }
    }
    [self.zan setTitle:[NSString stringWithFormat:@"%ld",newsInfo.zanmbiancount]  forState:UIControlStateNormal];
    [self.comment setTitle:[NSString stringWithFormat:@"%ld",newsInfo.commentcount] forState:UIControlStateNormal];
}
@end
