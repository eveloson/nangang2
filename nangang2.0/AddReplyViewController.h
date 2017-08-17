//
//  AddReplyViewController.h
//  nangang2.0
//
//  Created by wubin on 2017/8/17.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <XLForm/XLForm.h>
#import "Comment.h"
#import "ZCFGDetailViewController.h"
@interface AddReplyViewController : XLFormViewController
@property (nonatomic, weak) ZCFGDetailViewController *vc;
@property (nonatomic, weak) Comment *comment;
@end
