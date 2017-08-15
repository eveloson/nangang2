//
//  juwuxiangqingView.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/14.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "juwuxiangqingView.h"

@interface juwuxiangqingView ()
{
    UIWebView *myWebView;
}
@end

@implementation juwuxiangqingView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth -20, 33)];
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    NSString *s = self.model.Title;
    label.font = [UIFont systemFontOfSize:20];
    UIFont *font = [UIFont fontWithName:@"Title" size:20];
    
    CGSize size = CGSizeMake(ScreenWidth -20,2000);
    
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    label.frame = CGRectMake(10, 15, ScreenWidth - 20, labelsize.height + 15);
    label.textAlignment = 1;
    label.text = [NSString stringWithFormat:@"%@",self.model.Title];
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, label.frame.origin.y + label.frame.size.height + 10, ScreenWidth - 20, 20)];
    label1.textAlignment = 1;
    label1.textColor = [UIColor lightGrayColor];
    label1.text = [NSString stringWithFormat:@"发布人:%@   发布时间:%@",self.model.Creater,self.model.FBTime];
    label1.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label1];
    
    myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, label1.frame.origin.y + label1.frame.size.height  + 10, ScreenWidth, ScreenHeight - label1.frame.origin.y - label1.frame.size.height  - 15 - 64)];
    myWebView.scalesPageToFit = YES;
    myWebView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myWebView];
    [self ProjDataByPage];
}
-(void)ProjDataByPage{
    [self.view showWarning:@""];
    NSDictionary *Dic = @{@"ID":self.model.ID,@"Action":@"getNewsContent"};
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger POST:@"http://222.184.127.50:10070/AjaxService/NewsHandler.ashx" parameters:Dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.view hideBusyHUD];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *result = [dic objectForKey:@"result"];
        if ([result isEqualToString:@"success"])
        {
            NSLog(@"%@",responseObject);
            [myWebView loadHTMLString:[[[dic objectForKey:@"Rows"]objectAtIndex:0]objectForKey:@"NewsContent"] baseURL:[NSURL URLWithString:@"http://222.184.127.50:10070/AjaxService/NewsHandler.ashx"]];
            
        }
        else
        {
            NSString *error = [dic objectForKey:@"tips"];
            [self.view showWarning1:@"网络异常"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view hideBusyHUD];
        [self.view showWarning1:@"网络异常"];
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
