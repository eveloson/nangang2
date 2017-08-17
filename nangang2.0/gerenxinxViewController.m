//
//  gerenxinxViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/15.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "gerenxinxViewController.h"

@interface gerenxinxViewController ()

@end

@implementation gerenxinxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 100)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, (ScreenWidth-20)/2.00, 50)];
    nameLabel.textColor = ThemeColor;
    nameLabel.text = @"用户名";
    [view1 addSubview:nameLabel];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/2.00, 10, (ScreenWidth-20)/2.00, 30)];
    textField.text = @"啦啦啦啦";
    textField.textAlignment = 2;
    [view1 addSubview:textField];
    
    UILabel *sjhLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, (ScreenWidth-20)/2.00, 50)];
    sjhLabel.text = @"手机号码";
    sjhLabel.textColor = ThemeColor;
    [view1 addSubview:sjhLabel];
    UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/2.00, 60, (ScreenWidth-20)/2.00, 30)];
    textField1.text = @"18337125808";
    textField1.textAlignment = 2;
    [view1 addSubview:textField1];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y + view1.frame.size.height + 10, ScreenWidth, 50)];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 addTarget:self action:@selector(btnzuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    label3.text = @"住址类型";
    label3.textColor = ThemeColor;
    [btn1 addSubview:label3];
    UILabel *label31 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.00, 10, ScreenWidth/2.00 -10, 30)];
    label31.text = @"组";
    label31.textAlignment = 2;
    [btn1 addSubview:label31];
    
    UIButton *btn2 =[[UIButton alloc]initWithFrame:CGRectMake(0, btn1.frame.origin.y + btn1.frame.size.height + 2, ScreenWidth , 50)];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 addTarget:self action:@selector(btnzu1Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    label2.text = @"小区/组";
    label2.textColor = ThemeColor;
    [btn2 addSubview:label2];
    UILabel *label21 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.00, 10, ScreenWidth/2.00 -10, 30)];
    label21.text = @"1组";
    label21.textAlignment = 2;
    [btn2 addSubview:label21];
    
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, btn2.frame.origin.y + btn2.frame.size.height + 2, ScreenWidth, 50)];
    v1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v1];
    
    UILabel *lalo = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    lalo.text = @"楼/路";
    lalo.textAlignment = 0;
    lalo.textColor = ThemeColor;
    [v1 addSubview:lalo];
    UITextField *textFieldlo = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/2.00, 10, ScreenWidth/2.00 -10, 30)];
    textFieldlo.textAlignment = 2;
    [v1 addSubview:textFieldlo];
    
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0, v1.frame.origin.y + v1.frame.size.height + 10, ScreenWidth , 50)];
    v2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v2];
    
    UILabel *labelshi = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    labelshi.textColor = ThemeColor;
    labelshi.text = @"室/门牌号码";
    [v2 addSubview:labelshi];
    
    UITextField *textFeildshi = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/2.00, 10, ScreenWidth/2.00 - 10, 30)];
    textFeildshi.textAlignment = 2;
    [v2 addSubview:textFeildshi];
    
    
    
}
-(void)btnzuAction:(UIButton *)but{

}
-(void)btnzu1Action:(UIButton *)but{

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
