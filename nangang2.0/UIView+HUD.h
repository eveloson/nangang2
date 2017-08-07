//
//  UIView+HUD.h
//  ciShanChaoShi
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 冲浪科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (HUD)

/** 一直显示文字提示 */
- (void)showWarning:(NSString *)words;

/** 隐藏忙提示 */
- (void)hideBusyHUD;

/** 显示文字提示1秒 */
- (void)showWarning1:(NSString *)words;
@end
