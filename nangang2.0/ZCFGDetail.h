//
//  ZCFGDetail.h
//  AutoLayout
//
//  Created by wubin on 2017/5/5.
//  Copyright © 2017年 wubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCFGDetail : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *AddId;
@property (nonatomic, copy) NSString *Adder;
@property (nonatomic, copy) NSString *fbTime;
@property (nonatomic, strong) NSArray *ImgUrl;
@property (nonatomic, assign) NSInteger zanmbiancount;
@property (nonatomic, assign) NSInteger commentcount;
@property (nonatomic, assign) NSInteger flag;
@end
