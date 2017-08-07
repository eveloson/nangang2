//
//  chuliView.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/4.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "chuliView.h"

@interface chuliView ()
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

@implementation chuliView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"处理诉求";
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 10 -54)];
    myScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    myScrollView.showsHorizontalScrollIndicator = NO;
    //    myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 10, 30)];
    label1.text = [NSString stringWithFormat:@"时间"];
    [myScrollView addSubview:label1];
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, label1.frame.origin.y + label1.frame.size.height + 10, (ScreenWidth  - 25)/2.000, 30)];
    label2.text = @"反映人:";
    [myScrollView addSubview:label2];
    
    label3 = [[UILabel alloc]initWithFrame:CGRectMake(label2.frame.origin.x + label2.frame.size.width + 5, label1.frame.origin.y + label1.frame.size.height + 10, (ScreenWidth  - 25)/2.000, 30)];
    label3.textAlignment = 2;
    label3.text = @"2345";
    [myScrollView addSubview:label3];
    
    label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, label3.frame.origin.y + label3.frame.size.height + 10, ScreenWidth - 20, 30)];
    label4.text =@"家庭住址";
    [myScrollView addSubview:label4];
    label5 = [[UILabel alloc]initWithFrame:CGRectMake(10, label4.frame.origin.y + label4.frame.size.height + 10, ScreenWidth - 20, 30)];
    label5.text = @"事由";
//    label5.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:label5];
    label6 = [[UILabel alloc]initWithFrame:CGRectMake(10, label5.frame.origin.y + label5.frame.size.height + 10, ScreenWidth - 20, 50)];
    label6.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:label6];
    
    label7 = [[UILabel alloc]initWithFrame:CGRectMake(10, label6.frame.origin.y + label6.frame.size.height + 10, ScreenWidth - 20, 30)];
    label7.text = @"处理意见:";
    [myScrollView addSubview:label7];
    
    label8 = [[UILabel alloc]initWithFrame:CGRectMake(10, label7.frame.origin.y + label7.frame.size.height + 10, ScreenWidth - 20, 30)];
    label8.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:label8];
    textView = [[UITextView alloc]initWithFrame:CGRectMake(10, label8.frame.origin.y        + label8.frame.size.height + 10, ScreenWidth, 100)];
    textView.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:textView];
    
    btnLiuzhuan = [[UIButton alloc]initWithFrame:CGRectMake(50, textView.frame.origin.y + textView.frame.size.height + 15, (ScreenWidth - 150)/2.000, 30)];
    btnLiuzhuan.backgroundColor = [UIColor greenColor];
    [myScrollView addSubview:btnLiuzhuan];
    
    btnJiexiang = [[UIButton alloc]initWithFrame:CGRectMake(btnLiuzhuan.frame.origin.x + btnLiuzhuan.frame.size.width + 50, textView.frame.origin.y + textView.frame.size.height + 15, (ScreenWidth - 150)/2.000, 30)];
    btnJiexiang.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:btnJiexiang];
    myScrollView.bounces = NO;
    myScrollView.contentSize = CGSizeMake(ScreenWidth,btnJiexiang.frame.origin.y + btnJiexiang.frame.size.height + 20);;
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
                  
            label1.text = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"CreateTime"]];
            label2.text = [NSString stringWithFormat:@"反映人:%@",[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Name"]];
            label3.text = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"MobilePhoneNumber"]];
            label4.text = [NSString stringWithFormat:@"家庭住址:%@  %@ %@",[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Quanters"],[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Floor"],[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Room"]];
                 });
            label5.text = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Reason"]];
            UIFont *font = [UIFont fontWithName:@"Arial" size:16];
            //设置一个行高上限
            CGSize size = CGSizeMake(ScreenWidth - 20,2000);
            //计算实际frame大小，并将label的frame变成实际大小
            CGSize labelsize = [label5.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            label5.frame = CGRectMake(10, label5.frame.origin.y , ScreenWidth - 20, labelsize.height + 10);
            label6.frame = CGRectMake(10, label5.frame.origin.y + label5.frame.size.height + 10, ScreenWidth - 20, 30);
            

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


@end
