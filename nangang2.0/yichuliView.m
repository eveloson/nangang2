//
//  yichuliView.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/11.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "yichuliView.h"

@interface yichuliView ()
{
    UIScrollView *myScrollView;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
    UILabel *label6;
    UILabel *label7;
    UILabel *label8;
    UITextView *textView;
    UIButton *btnLiuzhuan;
    UIButton *btnJiexiang;
    
}

@end

@implementation yichuliView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"诉求详情";
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 10 -54)];
    myScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    myScrollView.showsHorizontalScrollIndicator = NO;
    //    myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 10, 30)];
    label1.text = [NSString stringWithFormat:@"时间:%@",self.model1.CreateTime];
    [myScrollView addSubview:label1];
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, label1.frame.origin.y + label1.frame.size.height + 10, (ScreenWidth  - 25)/2.000, 30)];
    label2.text = [NSString stringWithFormat:@"反映人:%@",self.model1.Name];
    [myScrollView addSubview:label2];
    
    label3 = [[UILabel alloc]initWithFrame:CGRectMake(label2.frame.origin.x + label2.frame.size.width + 5, label1.frame.origin.y + label1.frame.size.height + 10, (ScreenWidth  - 25)/2.000, 30)];
    label3.textAlignment = 2;
    label3.text = [NSString stringWithFormat:@"%@",self.model1.MobilePhoneNumber];
    [myScrollView addSubview:label3];
    
    label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, label3.frame.origin.y + label3.frame.size.height + 10, ScreenWidth - 20, 30)];
    label4.text = [NSString stringWithFormat:@"家庭住址:%@  %@ %@",self.model1.Quanters,self.model1.Floor,self.model1.Room];
    [myScrollView addSubview:label4];
    label5 = [[UILabel alloc]initWithFrame:CGRectMake(10, label4.frame.origin.y + label4.frame.size.height + 10, ScreenWidth - 20, 30)];
    label5.text = @"事由";
    //    label5.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:label5];
    label6 = [[UILabel alloc]initWithFrame:CGRectMake(10, label5.frame.origin.y + label5.frame.size.height + 10, ScreenWidth - 20, 50)];
    label6.backgroundColor = [UIColor whiteColor];
    label6.text = [NSString stringWithFormat:@"%@",self.model1.Reason];
    label6.numberOfLines = 0;
    CGSize size1 = [label6 sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
//    UIFont *font = [UIFont fontWithName:@"Arial" size:16];
//    //设置一个行高上限
//    CGSize size = CGSizeMake(ScreenWidth - 20,2000);
//    //计算实际frame大小，并将label的frame变成实际大小
//    CGSize labelsize = [label5.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    //    label5.frame = CGRectMake(10, label5.frame.origin.y , ScreenWidth - 20, labelsize.height + 10);
    label6.frame = CGRectMake(10, label5.frame.origin.y + label5.frame.size.height + 10, ScreenWidth - 20, size1.height + 10);
    [myScrollView addSubview:label6];
    
    label7 = [[UILabel alloc]initWithFrame:CGRectMake(10, label6.frame.origin.y + label6.frame.size.height + 10, ScreenWidth - 20, 30)];
    label7.text = @"处理意见:";
    [myScrollView addSubview:label7];
    
  //  label8 = [[UILabel alloc]initWithFrame:CGRectMake(10, label7.frame.origin.y + label7.frame.size.height + 10, ScreenWidth - 20, 30)];
 //   label8.backgroundColor = [UIColor whiteColor];
 //   [myScrollView addSubview:label8];
    textView = [[UITextView alloc]initWithFrame:CGRectMake(10, label7.frame.origin.y + label7.frame.size.height + 10, ScreenWidth, 100)];
    textView.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:textView];

    [self GetAllOptionRequest];

}
-(void)GetAllOptionRequest{
    NSDictionary *dic1 = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_TOKEN];
    NSString *userID = [dic1 objectForKey:@"userid"];
    
    [self.view showWarning:@""];
    NSDictionary *param = @{@"Action":@"GetTopOption",@"AskingID":self.model.ID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/OperateHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *result = [dic objectForKey:@"result"];
        [self.view hideBusyHUD];
        NSLog(@"%@",dic);
        if ([result isEqualToString:@"success"])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([[dic objectForKey:@"Rows"] count]==0)
                {
                    label8.text = [NSString stringWithFormat:@"处理意见:(暂无)"];
                }else{
                    for(int i = 0; i < [[dic objectForKey:@"Rows"] count] ; i++)
                    {
                        
                        NSDictionary *dic1 = [[dic objectForKey:@"Rows"] objectAtIndex:i];
                        NSString *Name = [dic1 objectForKey:@"Name"];
                        NSString *TreatOption = [dic1 objectForKey:@"TreatOption"];
                        NSString *TreatTime = [dic1 objectForKey:@"TreatTime"];
                        
                        NSString *stsr = [NSString stringWithFormat:@"%@:%@\n%@",Name,TreatOption,TreatTime];NSString *str2 = [[NSString alloc]init];
                        str2 = [NSString stringWithFormat:@"%@\n%@",str2,stsr];
                        NSLog(@"%@",str2);
                       // label8.text = [NSString stringWithFormat:@"处理意见:%@",str2];
                        textView.text = [NSString stringWithFormat:@"处理意见:%@",str2];
                        UIFont *font = [UIFont fontWithName:@"Arial" size:17];
                        //设置一个行高上限
                        CGSize size = CGSizeMake(ScreenWidth - 20,2000);
                        //计算实际frame大小，并将label的frame变成实际大小
                        CGSize labelsize = [textView.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                        textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, ScreenWidth -20, labelsize.height + 20);
                        textView.font = [UIFont systemFontOfSize:17];
                        textView.editable = NO;
                        
                    }
                    
                }
            });
            
            
            
            //            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            //            if (_btnzd.tag == 0) {
            //
            //                [ud setObject:dic forKey:KEY_ACCESSTOKEN];
            //                [ud setObject:dic forKey:KEY_TOKEN];
            //                [ud synchronize];
            //            }
            //            else{
            //                [ud setObject:dic forKey:KEY_TOKEN];
            //            }
            //            [self.view showWarning1:@"登录成功"];
            //            MainTabBarViewController *main = [[MainTabBarViewController alloc]init];
            //
            //            [[UIApplication sharedApplication].delegate window].rootViewController = main;
        }
        else
        {    NSString *error = [dic objectForKey:@"tips"];
            [self.view showWarning1:error];
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.view hideBusyHUD];
        [self.view showWarning1:[NSString stringWithFormat:@"%@",error]];
        
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
