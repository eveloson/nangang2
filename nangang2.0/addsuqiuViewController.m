//
//  addsuqiuViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/3.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "addsuqiuViewController.h"

@interface addsuqiuViewController ()

@end

@implementation addsuqiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"反映诉求";
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_TOKEN];
    NSString *name = [dic objectForKey:@"Name"];
    NSString *mobilePhoneNumber = [dic objectForKey:@"MobilePhoneNumber"];
    NSString *quanters = [dic objectForKey:@"Quanters"];
    NSString *floor = [dic objectForKey:@"Floor"];
    NSString *room = [dic objectForKey:@"Room"];
    
    self.nameLabel.text = [NSString stringWithFormat:@"反映人:%@",name];
    self.dianhuaLabel.text = [NSString stringWithFormat:@"%@",mobilePhoneNumber];
    self.dizhiLabel.text = [NSString stringWithFormat:@"家庭住址:%@  %@ %@",quanters,floor,room];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)btnTJaction:(id)sender {
    if (self.textView.text.length == 0) {
        [self.view showWarning1:@"提交内容不能为空"];
        return;
    }
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_TOKEN];
    NSString *name = [dic objectForKey:@"userid"];
    [self.view showWarning:@""];
    NSDictionary *param = @{@"Action":@"AskingAdd",@"PersonID":name,@"Reason":self.textView.text};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/AskingHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *result = [dic objectForKey:@"result"];
        [self.view hideBusyHUD];
        if ([result isEqualToString:@"success"])
        {
            [self.view showWarning1:@"提交成功"];
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
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
-(void)delayMethod{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
