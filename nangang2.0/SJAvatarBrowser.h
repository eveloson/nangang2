//
//  SJAvatarBrowser.h
//  circle
//
//  Created by wubin on 2017/6/13.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ClickBtn)();

@interface SJAvatarBrowser : NSObject


@property (nonatomic,copy) ClickBtn clickbtn;

+(void)showImageWithImage:(UIImage *)avatarImage;
/**
 *  @brief  浏览头像
 *
 *  @param  oldImageView    头像所在的imageView
 */
+(void)showImageWithImageView:(UIImageView*)avatarImageView;

-(void)showLabelWithTitle:(NSString *)title Constent:(NSString*)constent;
@end
