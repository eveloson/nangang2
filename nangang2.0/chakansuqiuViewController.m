//
//  chakansuqiuViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/1.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "chakansuqiuViewController.h"
#import "addsuqiuViewController.h"

@interface chakansuqiuViewController ()
{
    UIScrollView *myScrollView;
    UIView *view;
    UILabel *labelSJ;
    UILabel *label1;
    UIView *v1;
    UILabel *labelSY;
    NSMutableArray *arr;
    UILabel *labeCL;
    UIView *v2;
    UILabel *labelCL;
    UIView *v3;
    UILabel *labelPJ;
    UITextView *TextV3;
    UIButton *btn1;
    UILabel *la1;
    UIButton *btn2;
    UILabel *la2;
    UIButton *btn3;
    UILabel *la3;
    UIButton *btn4;
    UILabel *la4;
    UIButton *btn5;
    UILabel *la5;
    UIButton *btnBC;
    NSInteger pj;
    NSString *pjStr;
}
@end

@implementation chakansuqiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    
   
    TextV3.font = [UIFont systemFontOfSize:20];
    pj = 0;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.navigationItem.title = @"生活诉求查看";
    arr = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 10 -54)];
    myScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    myScrollView.showsHorizontalScrollIndicator = NO;
//    myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
//    myScrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, ScreenHeight)];
    view.backgroundColor = [UIColor whiteColor];
//    [myScrollView addSubview:view];
    myScrollView.bounces = NO;
    myScrollView.contentSize = view.frame.size;
    labelSJ = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth , 40)];
    labelSJ.text = [NSString stringWithFormat:@"   时间:"];
    labelSJ.textColor = [UIColor darkGrayColor];
    labelSJ.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:labelSJ];
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, labelSJ.frame.origin.y + labelSJ.frame.size.height, ScreenWidth, 40)];
    label1.textColor = [UIColor darkGrayColor];
    label1.text = @"   事由:";
  //  label1.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:label1];
    
    v1 = [[UIView alloc]initWithFrame:CGRectMake(0, label1.frame.origin.y + label1.frame.size.height, ScreenWidth, 80)];
    v1.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:v1];
    
    labelSY = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 60)];
    labelSY.text = [NSString stringWithFormat:@"%@",@""];
    labelSY.textColor = [UIColor darkGrayColor];
    labelSY.numberOfLines = 0;
    [v1 addSubview:labelSY];
    labeCL = [[UILabel alloc]initWithFrame:CGRectMake(0, v1.frame.origin.y + v1.frame.size.height, ScreenWidth, 40)];
    labeCL.textColor = [UIColor darkGrayColor];
    labeCL.text = @"   处理意见:";
   // labeCL.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:labeCL];
    
    v2 = [[UIView alloc]initWithFrame:CGRectMake(0, labeCL.frame.origin.y + labeCL.frame.size.height , ScreenWidth, 100)];
    v2.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:v2];
    labelCL = [[UILabel alloc]initWithFrame:CGRectMake(10, v2.frame.origin.y, ScreenWidth - 20, 40)];
    labelCL.backgroundColor = [UIColor whiteColor];
    labelCL.textColor = [UIColor darkGrayColor];
    labelCL.text = [NSString stringWithFormat:@""];
    [v2 addSubview:labelCL];
    
    
    v3 = [[UIView alloc]initWithFrame:CGRectMake(0, v2.frame.origin.y + v2.frame.size.height + 10, ScreenWidth, 300)];
    v3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [myScrollView addSubview:v3];
    labelPJ = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 30)];
    labelPJ.text = @"评价:";
    labelPJ.textColor = [UIColor darkGrayColor];
    [v3 addSubview:labelPJ];
    TextV3 = [[UITextView alloc]initWithFrame:CGRectMake(10, 40, ScreenWidth - 20, 100)];
    TextV3.backgroundColor = [UIColor whiteColor];
    [v3 addSubview:TextV3];
    
    btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, TextV3.frame.origin.y + TextV3.frame.size.height + 10, 20, 20)];
   // btn1.backgroundColor = [UIColor whiteColor ];
    [v3 addSubview:btn1];
    
    la1 = [[UILabel alloc]initWithFrame:CGRectMake(btn1.frame.origin.x + btn1.frame.size.width + 5, TextV3.frame.origin.y + TextV3.frame.size.height + 10, ScreenWidth/3.000 - 40, 20)];
    la1.text = @"非常满意";
    [v3 addSubview:la1];
    
    btn2 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3.000 + 10, TextV3.frame.origin.y + TextV3.frame.size.height + 10,  20, 20)];
    //btn2.backgroundColor = [UIColor whiteColor];
    [v3 addSubview:btn2];
    
    la2 = [[UILabel alloc]initWithFrame:CGRectMake(btn2.frame.origin.x + btn2.frame.size.width + 5, TextV3.frame.origin.y + TextV3.frame.size.height + 10, ScreenWidth/3.000 - 40, 20)];
    la2.text = @"比较满意";
    [v3 addSubview:la2];
    
    btn3 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3.000 *2 + 10, TextV3.frame.origin.y + TextV3.frame.size.height + 10, 20, 20)];
   // btn3.backgroundColor = [UIColor whiteColor];
    [v3 addSubview:btn3];
    la3 = [[UILabel alloc]initWithFrame:CGRectMake(btn3.frame.origin.x + btn3.frame.size.width + 5, TextV3.frame.origin.y + TextV3.frame.size.height + 10, ScreenWidth/3.000 - 40, 20)];
    la3.text = @"满意";
    [v3 addSubview:la3];
    
    btn4 = [[UIButton alloc]initWithFrame:CGRectMake(10, btn1.frame.origin.y + btn1.frame.size.height + 10, 20, 20)];
   // btn4.backgroundColor = [UIColor whiteColor];
    [v3 addSubview:btn4];
    
    la4 = [[UILabel alloc]initWithFrame:CGRectMake(btn4.frame.origin.x + btn4.frame.size.height  +5, btn1.frame.origin.y + btn1.frame.size.height + 10, ScreenWidth/3.000 - 40, 20)];
    la4.text = @"不太满意";
    [v3 addSubview:la4];
    
    btn5 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3.000 + 10, btn1.frame.origin.y + btn1.frame.size.height + 10, 20, 20)];
   // btn5.backgroundColor = [UIColor whiteColor];
    [v3 addSubview:btn5];
    
    la5 = [[UILabel alloc]initWithFrame:CGRectMake(btn5.frame.origin.x + btn5.frame.size.width + 5, btn1.frame.origin.y + btn1.frame.size.height + 10, ScreenWidth/3.000 - 40, 20)];
    la5.text = @"不满意";
    [v3 addSubview:la5];
    
    btnBC = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2.00 - 50, btn5.frame.origin.y + btn5.frame.size.height + 20, 100, 40)];
    NSLog(@"%f",btnBC.frame.origin.y  + btnBC.frame.size.height);
//    [btnBC setBackgroundImage:[UIImage imageNamed:@"24.PNG"] forState:UIControlStateNormal];
    btnBC.backgroundColor = [UIColor greenColor];
    [btnBC setTitle:@"保存" forState:UIControlStateNormal];
    [btnBC setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [btnBC addTarget:self action:@selector(btnBCAction:) forControlEvents:UIControlEventTouchUpInside];
    [v3 addSubview:btnBC];
    UIButton *btn6 = [[UIButton alloc]initWithFrame:CGRectMake(btnBC.frame.origin.x + btnBC.frame.size.width + 10, btnBC.frame.origin.y, 100, 40)];
    btn6.backgroundColor = [UIColor darkGrayColor];
    [btn6 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [v3 addSubview:btn6];
    
    [btn1 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
    [btn5 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
    btn1.tag = 1;
    btn2.tag = 2;
    btn3.tag = 3;
    btn4.tag = 4;
    btn5.tag = 5;
    
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
   
//    labelSY
//    labelSY
    [self AskingViewRequest];
    
}
-(void)btnBCAction:(UIButton *)but{
    NSLog(@"123456");
    if (TextV3.text.length == 0) {
        [self.view showWarning1:@"请输入评价内容"];
        return;

    }
    if (pj == 0) {
        [self.view showWarning1:@"请选择满意程度"];
        return;
    }
    [self.view showWarning:@""];
    switch (pj) {
        case 1:
        {
            pjStr = @"非常满意";
        }
            break;
        case 2:
        {
             pjStr = @"比较满意";
        }
            break;
        case 3:
        {
            pjStr = @"满意";
        }
            break;
        case 4:
        {
            pjStr = @"不太满意";
        }
            break;
        case 5:
        {
            pjStr = @"不满意";
        }
            break;
            
        default:
            break;
    }
    NSDictionary *param = @{@"Action":@"AskingEvaluate",@"ID":self.model.ID,@"Evaluate":TextV3.text,@"EvaluateOptions":pjStr};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/AskingHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *result = [dic objectForKey:@"result"];
        if ([result isEqualToString:@"success"])
        {
            [self.view showWarning1:@"评价成功"];
             [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
        }
        else
        {
            [self.view showWarning1:@"评价失败，请重试"];
        }

        [self.view hideBusyHUD];
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.view hideBusyHUD];
        [self.view showWarning1:[NSString stringWithFormat:@"%@",error]];
        
    }];

}
-(void)delayMethod{
    [self.navigationController popViewControllerAnimated:YES];;
}
-(void)btnAction:(UIButton *)but{
    switch (but.tag) {
        case 1:
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"32.PNG"] forState:UIControlStateNormal];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn3 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn4 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn5 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            pj = 1;
        }
            break;
        case 2:
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"32.PNG"] forState:UIControlStateNormal];
            [btn3 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn4 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn5 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            pj = 2;
        }
            break;
        case 3:
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn3 setBackgroundImage:[UIImage imageNamed:@"32.PNG"] forState:UIControlStateNormal];
            [btn4 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn5 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            pj = 3;
        }
            break;
        case 4:
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn3 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn4 setBackgroundImage:[UIImage imageNamed:@"32.PNG"] forState:UIControlStateNormal];
            [btn5 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            pj = 4;
        }
            break;
        case 5:
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn3 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn4 setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
            [btn5 setBackgroundImage:[UIImage imageNamed:@"32.PNG"] forState:UIControlStateNormal];
            pj = 5;
        }
            break;
            
        default:
            break;
    }
}
-(void)AskingViewRequest{
    [self.view showWarning:@""];
    NSDictionary *param = @{@"Action":@"AskingView",@"ID":self.model.ID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/AskingHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *result = [dic objectForKey:@"result"];
        [self.view hideBusyHUD];
        NSLog(@"%@",dic);
        if ([result isEqualToString:@"success"])
        {
//         [self.view showWarning1:@"登录成功"];
            arr = [dic objectForKey:@"Rows"] ;
            dispatch_async(dispatch_get_main_queue(), ^{

            labelSJ.text = [NSString stringWithFormat:@"   时间:%@", [[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"CreateTime"]];
            labelSY.text = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Reason"]];
            labelSY.lineBreakMode = UILineBreakModeWordWrap;
            // 测试字串
            NSString *s = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Reason"]];
            UIFont *font = [UIFont fontWithName:@"Arial" size:16];
            //设置一个行高上限
            CGSize size = CGSizeMake(ScreenWidth - 20,2000);
            //计算实际frame大小，并将label的frame变成实际大小
            CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            v1.frame = CGRectMake(0, v1.frame.origin.y , v1.frame.size.width, labelsize.height +20);
            labelSY.frame = CGRectMake(10, 10, ScreenWidth - 20, labelsize.height);
            
            
            labeCL.frame = CGRectMake(0, v1.frame.origin.y + v1.frame.size.height, ScreenWidth, 40);
                 labelCL.text = [NSString stringWithFormat:@"%@",self.model.AuditOption];
            if ([[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"State"] isEqualToString:@"已评价"])
            {
                TextV3.text = [NSString stringWithFormat:@"评价:%@\n满意程度:%@",[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Evaluate"],[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"EvaluateOptions"]];
               // TextV3.alpha = 0;
                labelPJ.alpha = 0;
                TextV3.editable = NO;
                btn1.alpha = 0;
                la1.alpha = 0;
                btn2.alpha = 0;
                btn3.alpha = 0;
                btn4.alpha = 0;
                btn5.alpha = 0;
                la2.alpha = 0;
                la3.alpha = 0;
                la4.alpha = 0;
                la5.alpha = 0;
                btnBC.alpha = 0;
                labelCL.text = [NSString stringWithFormat:@"%@",self.model.AuditOption];
            }else if([[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"State"] isEqualToString:@"未处理"])
            {
                labelPJ.alpha = 0;
                TextV3.alpha = 0;
                btn1.alpha = 0;
                la1.alpha = 0;
                btn2.alpha = 0;
                btn3.alpha = 0;
                btn4.alpha = 0;
                btn5.alpha = 0;
                la2.alpha = 0;
                la3.alpha = 0;
                la4.alpha = 0;
                la5.alpha = 0;
                btnBC.alpha = 0;

                labelCL.text = [NSString stringWithFormat:@"暂无"];
            }else if([[[[dic objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"State"] isEqualToString:@"处理中"])
            {
                labelPJ.alpha = 0;
                TextV3.alpha = 0;
                btn1.alpha = 0;
                la1.alpha = 0;
                btn2.alpha = 0;
                btn3.alpha = 0;
                btn4.alpha = 0;
                btn5.alpha = 0;
                la2.alpha = 0;
                la3.alpha = 0;
                la4.alpha = 0;
                la5.alpha = 0;
                btnBC.alpha = 0;

                 labelCL.text = [NSString stringWithFormat:@"%@",self.model.AuditOption];
            }
            
                
                UIFont *font1 = [UIFont fontWithName:@"Arial" size:16];
                CGSize labelsize1 = [labelCL.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                v2.frame = CGRectMake(0, labeCL.frame.origin.y + labeCL.frame.size.height, ScreenWidth, labelsize1.height + 10);
                labelCL.frame = CGRectMake(10, 5, ScreenWidth - 20, labelsize1.height);
                v3.frame = CGRectMake(0, v2.frame.origin.y + v2.frame.size.height + 10, ScreenWidth, 300);
                
             });
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
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [TextV3 resignFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [TextV3 resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
