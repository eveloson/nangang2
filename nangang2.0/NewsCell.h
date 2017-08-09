//
//  NewsCell.h
//  DangJian
//
//  Created by wubin on 2017/7/25.
//  Copyright © 2017年 clkeji. All rights reserved.
//
#define kHeadTMargin 15
#define kHeadH 40
#define kContentTMargin 15
#define kContentH 50
#define kImageLRMargin 30
#define kImageMargin 15
#define kImageHW (ScreenWidth-kImageLRMargin*2-kImageMargin*2)/3
#define kTimeH 40
#import <UIKit/UIKit.h>
#import "ZCFGDetail.h"
@interface NewsCell : UITableViewCell
@property (nonatomic, strong) ZCFGDetail *newsInfo;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
