//
//  ZCFGDetailViewController.m
//  AutoLayout
//
//  Created by wubin on 2017/5/5.
//  Copyright © 2017年 wubin. All rights reserved.
//

#import "ZCFGDetailViewController.h"
#import "WDZAFNetworking.h"
@interface ZCFGDetailViewController ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation ZCFGDetailViewController

- (void)setZcfgDetail:(ZCFGDetail *)zcfgDetail{
    _zcfgDetail = zcfgDetail;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
    if (zcfgDetail.content != nil) {
        [self.webView loadHTMLString:zcfgDetail.content baseURL:nil];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"动态详情";
    [self setupView];
    [self setupData];
}

- (void)setupView{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    header.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:header];
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel = titleLabel;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.text = self.zcfgDetail.title;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.view addSubview:timeLabel];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel = timeLabel;
//    self.timeLabel.text = [NSString stringWithFormat:@"发布时间 %@",self.zcfgDetail.date];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(210, 210, 210);
    [self.view addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(timeLabel);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(0.7);
    }];
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.scrollView.bounces = false;
    [self setupConstraint];
}
- (void)setupData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"NewsID"] = self.zcfgDetail.ID;
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@GetNewsDetails",HOSTURL] parameters:params success:^(id  _Nonnull json) {
        self.zcfgDetail = [ZCFGDetail objectWithKeyValues:json[@"data"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    } loadingMsg:@"正在加载ing" errorMsg:@"服务器出错了！"];
}
- (void)setupConstraint{
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(44);
    }];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(30);
    }];
    [self.webView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

@end
