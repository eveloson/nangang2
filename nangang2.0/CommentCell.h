//
//  CommentCell.h
//  nangang2.0
//
//  Created by wubin on 2017/8/14.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
@class ZCFGDetailViewController;
@interface CommentCell : UITableViewCell
@property (nonatomic, strong) Comment *comment;
@property (nonatomic, weak) ZCFGDetailViewController *vc;
@end
