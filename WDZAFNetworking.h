//
//  WDZAFNetworking.h
//  AutoLayout
//
//  Created by wubin on 2017/5/4.
//  Copyright © 2017年 wubin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface WDZAFNetworking : NSObject
/*
 ///本整理内容需要导入第三方库:   AFNetworking   /  SVProgressHUD
 
 *  get请求  并通过block返回json数据
 *  URLString  ----> 网络地址
 *  parameters  ----> 参数请求体
 *  success       ----> 请求成功
 *  failure         ----> 请求失败
 */
//创建get请求
+(void)get:(nullable NSString *)URLString parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success failure:(nullable void(^)(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error))failure;
+(void)get:(nullable NSString *)URLString parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success failure:(nullable void(^)(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error))failure loadingMsg:(NSString *_Nullable)loadMsg  errorMsg:(NSString *_Nullable)errorMsg;

//创建post请求
+(void)post:(nullable NSString *)URLString parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success failure:(nullable void(^)(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error))failure;
+(void)post:(nullable NSString *)URLString parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success failure:(nullable void(^)(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error))failure loadingMsg:(NSString *_Nullable)loadMsg  errorMsg:(NSString *_Nullable)errorMsg;
//post上传图片
+(void)post:(nullable NSString *)URLString images:(NSArray*)images parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success failure:(nullable void(^)(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error))failure loadingMsg:(NSString *_Nullable)loadMsg  errorMsg:(NSString *_Nullable)errorMsg;
//无hub无错误回调
+(void)post:(nullable NSString *)URLString parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success;
@end
