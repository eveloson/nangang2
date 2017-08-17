//
//  ZCFGDetailViewController.h
//  nangang2.0
//
//  Created by wubin on 2017/8/10.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCFGDetail.h"
#import "NewsCell.h"
@interface ZCFGDetailViewController : UITableViewController
@property (nonatomic, strong)  ZCFGDetail *newsInfo;
- (void)setupComments;
@end
