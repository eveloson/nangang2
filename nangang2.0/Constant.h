//
//  Constant.h
//  nangang2.0
//
//  Created by 周家新 on 17/7/31.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject


+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
+(BOOL) isBlankString:(NSString *)string;
+ (UIImage *)buttonImageFromColor:(UIColor *)color Rect:(CGRect)rect;
+ (BOOL)valiMobile:(NSString *)mobile;
+(void)setObject:(NSString*)object Nsstring:(NSString *)string;

@end
