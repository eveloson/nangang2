//
//  UIView+HUD.m
//  ciShanChaoShi
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 冲浪科技. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView (HUD)
- (void)showWarning:(NSString *)words{
    //为使用者考虑, 如果子线程执行此方法会崩溃, 我们要把方法做成线程安全的.
    if ([words isEqualToString:@""]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            
        });
        
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText  = words;
            
        });
    }
    
}

- (void)hideBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
    });
    
}

- (void)showWarning1:(NSString *)words{
    //为使用者考虑, 如果子线程执行此方法会崩溃, 我们要把方法做成线程安全的.
   
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = words;
        [hud hide:YES afterDelay:2];
    });
}

@end
