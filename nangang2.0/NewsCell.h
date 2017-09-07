//
//  NewsCell.h
//  DangJian
//
//  Created by wubin on 2017/7/25.
//  Copyright © 2017年 clkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCFGDetail.h"
@interface NewsCell : UITableViewCell
@property (nonatomic, strong) ZCFGDetail *newsInfo;
@property (nonatomic, weak) UITableViewController *vc;
@end
