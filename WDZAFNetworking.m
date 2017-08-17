//
//  WDZAFNetworking.m
//  AutoLayout
//
//  Created by wubin on 2017/5/4.
//  Copyright © 2017年 wubin. All rights reserved.
//

#import "WDZAFNetworking.h"

@implementation WDZAFNetworking
//实现单例请求类对象
+(AFHTTPSessionManager *)shareManager;
{
    static AFHTTPSessionManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager =[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/JavaScript",@"text/html",@"text/plain",@"text/xml",nil];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 60.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        
        // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"网络状态改变》》》》》》》》》》》》》》》%ld", (long)status);
        }];
    });
    return manager;
}

+(AFHTTPSessionManager *)manager;
{
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates =true;
    
    return manager;
}

+ (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    //字符串处理
    NSString * string =[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:URLString]];
    [SVProgressHUD showWithStatus:@"数据加载中... "];
    //数据请求
    [[WDZAFNetworking shareManager]GET:string parameters:parameters progress:^(NSProgress *_Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (success) {
            // --- > 字典类型 --- > json数据 --- >解析数据并传值
            NSError * error =nil;
            if (error !=nil) {
                [SVProgressHUD showErrorWithStatus:@"数据解析失败,请稍后尝试!"];
                return ;
            }
            success(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求数据失败,请检查网络后重试!"];
        if (failure) {
            failure(task,error);
        }
    }];
}
+ (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure loadingMsg:(NSString *)loadMsg errorMsg:(NSString *)errorMsg{
    WLog(@"%@%@",URLString,parameters);
    //字符串处理
    NSString * string =[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:URLString]];
    if (loadMsg != nil) {
        [SVProgressHUD showWithStatus:loadMsg];
    }
    [[WDZAFNetworking shareManager]GET:string parameters:parameters progress:^(NSProgress *_Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (success) {
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            WLog(@"%@",error);
            WLog(@"%@",dict);
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error) {
        WLog(@"%@",error.debugDescription);
        if (errorMsg != nil) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        if (failure) {
            failure(task,error);
            [SVProgressHUD dismiss];
        }
    }];

}
+ (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    [self post:URLString parameters:parameters success:success failure:failure loadingMsg:@"数据加载中... " errorMsg:@"请求数据失败,请检查网络后重试!"];
}
+ (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure loadingMsg:(NSString *)loadMsg errorMsg:(NSString *)errorMsg{
    WLog(@"%@--%@",URLString,parameters);
    //字符串处理
    NSString * string =[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:URLString]];
    if (loadMsg != nil) {
        [SVProgressHUD showWithStatus:loadMsg];
    }
    [[WDZAFNetworking shareManager]POST:string parameters:parameters progress:^(NSProgress *_Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject) {
        [SVProgressHUD dismiss];
        WLog(@"%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error) {
        WLog(@"%@",error);
        if (errorMsg != nil) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        if (failure) {
            failure(task,error);
            [SVProgressHUD dismiss];
        }
    }];
}
+ (void)post:(NSString *)URLString images:(NSArray *)images parameters:(NSDictionary *)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure loadingMsg:(NSString *)loadMsg errorMsg:(NSString *)errorMsg{
    WLog(@"%@%@",URLString,parameters);
    //字符串处理
    NSString * string =[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:URLString]];
    if (loadMsg != nil) {
        [SVProgressHUD showWithStatus:loadMsg];
    }
    [[WDZAFNetworking shareManager] POST:string parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < images.count; i++) {
            NSData *data = UIImageJPEGRepresentation(images[i], 0.1);
            [formData appendPartWithFileData:data name:@"" fileName:[NSString stringWithFormat:@"%d.jpg",i] mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (success) {
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            WLog(@"%@",dict);
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WLog(@"%@",error);
        [SVProgressHUD dismiss];
        if (errorMsg != nil) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        if (failure) {
            failure(task,error);
        }
    }];
}
+ (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id _Nonnull))success{
    [self post:URLString parameters:parameters success:success failure:nil loadingMsg:nil errorMsg:nil];
}
@end
