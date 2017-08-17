//
//  AddCommentViewController.h
//  nangang2.0
//
//  Created by wubin on 2017/8/16.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <XLForm/XLForm.h>
@class ZCFGDetail,ZCFGDetailViewController;
@interface AddCommentViewController : XLFormViewController
@property (nonatomic, strong) ZCFGDetail *newsInfo;
@property (nonatomic, weak) ZCFGDetailViewController *vc;
@end
