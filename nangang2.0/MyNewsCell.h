//
//  MyNewsCell.h
//  nangang2.0
//
//  Created by wubin on 2017/8/17.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCFGDetail,MyMsgViewController;
@interface MyNewsCell : UITableViewCell
@property (nonatomic, strong) ZCFGDetail *newsInfo;
@property (nonatomic, weak) MyMsgViewController *vc;
@end
