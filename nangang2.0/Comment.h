//
//  Comment.h
//  HHJsonToCode
//
//  Created by wubin on 17/08/14.
//Copyright © 2017年 wubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

/*1603291104241173063771c8fff0e*/
@property (nonatomic,copy) NSString *TabWorkId;

/*1603291143209469653b348a49be4*/
@property (nonatomic,copy) NSString *Id;

/**/
@property (nonatomic,copy) NSString *ReplyId;

/*7e06e0eaf8be4f2e9ebe0e40a30ab5d1*/
@property (nonatomic,copy) NSString *UserId;

/*张三*/
@property (nonatomic,copy) NSString *UserName;

/**/
@property (nonatomic,copy) NSString *IsReply;

/**/
@property (nonatomic,copy) NSString *ReplyName;

/*mee too */
@property (nonatomic,copy) NSString *CommentMsg;

/**/
@property (nonatomic,copy) NSString *Type;

/*2016/3/29*/
@property (nonatomic,copy) NSString *CommentTime;

/*1603291104241173063771c8fff0e*/
@property (nonatomic,copy) NSString *ParentId;

/**/
@property (nonatomic,copy) NSString *ReplayTime;

@end