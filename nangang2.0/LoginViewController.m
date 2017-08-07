//
//  LoginViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/7/24.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MainTabBarViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnzd.tag = 0;
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)btnzAction:(id)sender {
    if (self.btnzd.tag == 0) {
        self.btnzd.tag = 1;
        [self.btnzd setBackgroundImage:[UIImage imageNamed:@"31.PNG"] forState:UIControlStateNormal];
    }else
    {
        self.btnzd.tag = 0;
        [self.btnzd setBackgroundImage:[UIImage imageNamed:@"32.PNG"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)btndlAction:(id)sender {
    if (self.nameTextField.text.length == 0 || self.pwdTextField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名或密码不能为空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self PersonsLogin];
}
-(void)PersonsLogin{
    [self.view showWarning:@""];
    NSDictionary *param = @{@"Action":@"PersonsLogin",@"MobilePhoneNumber":self.nameTextField.text,@"Password":self.pwdTextField.text};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/SystemHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *result = [dic objectForKey:@"result"];
        [self.view hideBusyHUD];
        if ([result isEqualToString:@"sucess"])
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            if (_btnzd.tag == 0) {
                
                [ud setObject:dic forKey:KEY_ACCESSTOKEN];
                [ud setObject:dic forKey:KEY_TOKEN];
                [ud synchronize];
            }
            else{
                [ud setObject:dic forKey:KEY_TOKEN];
            }
            [self.view showWarning1:@"登录成功"];
            MainTabBarViewController *main = [[MainTabBarViewController alloc]init];
          
            [[UIApplication sharedApplication].delegate window].rootViewController = main;
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
- (IBAction)btnzcAction:(id)sender {
    RegisterViewController *view = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
@end
