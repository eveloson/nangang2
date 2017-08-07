//
//  RegisterViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/7/24.
//  Copyright © 2017年 Zhou. All rights reserved.
//
#import "LTPickerView.h"
#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    MBProgressHUD *HUD;
    NSMutableArray *Arr;
    NSString *quanters;
     NSString *rbanRural;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnxuanze1.tag = 0;
    self.btnxuanze2.tag = 0;
    self.nameTextField.delegate = self;
    self.sjhTextField.delegate = self;
    self.mmTextField.delegate = self;
    self.qrmmTextField.delegate = self;
    self.x2TextField.delegate = self;
    self.x3TextField.delegate = self;
    
}

-( void )textFieldDidBeginEditing:(UITextField *)textField
{
    //假如多个输入，比如注册和登录，就可以根据不同的输入框来上移不同的位置，从而更加人性化
    //键盘高度216
    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.view.frame = CGRectMake(0.0f, -100.0f/*屏幕上移的高度，可以自己定*/, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
//取消第一响应，也就是输入完毕，屏幕恢复原状
-( void )textFieldDidEndEditing:(UITextField *)textField
{
    //滑动效果
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //恢复屏幕
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //恢复屏幕
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];

}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)btnxuanzeAction:(id)sender {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //恢复屏幕
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];

    [self.view showWarning:@""];
    NSDictionary *param;
    if (_btnxuanze1.tag == 0)
    {
        self.btnxuanze1.tag = 1;
       param = @{@"Action":@"GetDepartment",@"IsQOrX":@"组"};
        [self.btnxuanze1 setTitle:@"组" forState:UIControlStateNormal];
    }else
    {
        self.btnxuanze1.tag = 0;
        param = @{@"Action":@"GetDepartment",@"IsQOrX":@"小区"};
        [self.btnxuanze1 setTitle:@"小区" forState:UIControlStateNormal];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/SystemHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Arr = [NSMutableArray array];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *arr = [dic objectForKey:@"Rows"];
        NSLog(@"%@  %@",responseObject,dic);
        for (NSDictionary *DIC in arr) {
            NSString *a = [DIC objectForKey:@"Name"];
            [Arr addObject:a];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (IBAction)btnxuanze2Action:(id)sender {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //恢复屏幕
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];

    if (Arr.count == 0) {
        UIAlertView* alert1 = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"请选择小区或组"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert1 show];
        
    }
    LTPickerView* pickerView = [LTPickerView new];
    pickerView.dataSource = Arr;//设置要显示的数据
    //    pickerView.defaultStr = @"2";//默认选择的数据
    [pickerView show];//显示
    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        //        NSLog(@"选择了第%d行的%@",num,str);
        quanters = str;
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"选择了%@",str] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [self.btnxuanze2 setTitle:str forState:UIControlStateNormal];
        
    };

}
- (IBAction)btnzcAction:(id)sender {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //恢复屏幕
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    if (self.nameTextField.text.length == 0) {
        [self.view showWarning1:@"请输入姓名"];
        return;
    }
    if (self.sjhTextField.text.length == 0) {
        [self.view showWarning1:@"请输入手机号"];
        return;
    }
    if (self.mmTextField.text.length == 0) {
        [self.view showWarning1:@"请输入密码"];
        return;
    }
    if (self.qrmmTextField.text.length ==0) {
        [self.view showWarning1:@"请输入确认密码"];
        return;
    }
    if ([self.mmTextField.text isEqualToString:self.qrmmTextField.text]) {
        [self.view showWarning1:@"两次密码不一致"];
        return;
    }
    if (self.sjhTextField.text.length < 11)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号长度只能是11位" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        return ;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self.sjhTextField.text];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self.sjhTextField.text];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:self.sjhTextField.text];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的*****号码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return ;
        }
    }
    if (Arr.count == 0) {
        UIAlertView* alert1 = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"请选择城市或者乡镇"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert1 show];
        return;
        
    }
    if (_btnxuanze1.tag == 0) {
        rbanRural = @"小区";
    }
    else
    {
        rbanRural = @"组";
    }
    if (self.x2TextField.text.length ==0 || self.x3TextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入详细地址" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }

    [self.view showWarning:@""];
    NSDictionary *param = @{@"Action":@"PersonsAdd",@"Name":self.nameTextField.text,@"Password":self.mmTextField.text,@"MobilePhoneNumber":self.sjhTextField.text,@"UrbanRural":rbanRural,@"Quanters":quanters,@"Floor":self.x2TextField.text,@"Room":self.x3TextField.text};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/SystemHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
          NSString *result = [dic objectForKey:@"result"];
        [self.view hideBusyHUD];
        if ([result isEqualToString:@"success"])
        {
            // 成功了
            
            [self.view showWarning1:@"注册成功"];
      
        }
        else
        {
            // 因为 参数有问题  失败了
            NSString *error = [dic objectForKey:@"tips"];
            [self.view showWarning1:error];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.view hideBusyHUD];
        [self.view showWarning1:[NSString stringWithFormat:@"%@",error]];
    }];


}

- (IBAction)btnFanHuiAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
