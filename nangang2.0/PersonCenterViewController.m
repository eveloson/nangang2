//
//  PersonCenterViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/7/10.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "gerenxinxViewController.h"
#import "guanyuwomenViewController.h"

@interface PersonCenterViewController ()

@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth , 150)];
    imageV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    imageV.image = [UIImage imageNamed:@"12.PNG"];
    [self.view addSubview:imageV];
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - 80)/2.00, 20, 80, 80)];
    headImage.image = [UIImage imageNamed:@"33.PNG"];
    [self.view addSubview:headImage];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 100)/2.00, 110, 100, 30)];
    label.textAlignment = 1;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    UIButton *btngere  = [[UIButton alloc]initWithFrame:CGRectMake(0, imageV.frame.origin.y + imageV.frame.size.height, ScreenWidth , 50)];
    btngere.backgroundColor = [UIColor whiteColor];
    [btngere addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btngere];
    UIImageView *imag1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10,30, 30)];
    imag1.image = [UIImage imageNamed:@"个人信息.png"];
    [btngere addSubview:imag1];
    UILabel *labe1 = [[UILabel alloc]initWithFrame:CGRectMake(imag1.frame.origin.x + imag1.frame.size.width + 10, 10, ScreenWidth - 100, 30)];
    labe1.text = @"个人信息";
    [btngere addSubview:labe1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, btngere.frame.origin.y + btngere.frame.size.height + 10, ScreenWidth , 50)];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 addTarget:self action:@selector(btn2Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIImageView *imag2 = [[UIImageView alloc]initWithFrame:CGRectMake(7, 12, 35, 26)];
    imag2.image = [UIImage imageNamed:@"我的诉求.png"];
    [btn2 addSubview:imag2];
    
    UILabel *labe2 = [[UILabel alloc]initWithFrame:CGRectMake(imag2.frame.origin.x  +imag2.frame.size.width + 8, 10, ScreenWidth - 100, 30)];
    labe2.text = @"我的诉求";
    [btn2 addSubview:labe2];
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, btn2.frame.origin.y + btn2.frame.size.height + 2, ScreenWidth , 50)];
    btn3.backgroundColor = [UIColor whiteColor];
    [btn3 addTarget:self action:@selector(btn3Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIImageView *imag3 = [[UIImageView alloc]initWithFrame:CGRectMake(7, 12, 35, 26)];
    imag3.image = [UIImage imageNamed:@"我的动态.png"];
    [btn3 addSubview:imag3];
    
    UILabel *labe3 = [[UILabel alloc]initWithFrame:CGRectMake(imag3.frame.origin.x + imag3.frame.size.width  +8, 10, ScreenWidth - 100, 30)];
    labe3.text = @"我的动态";
    [btn3 addSubview:labe3];
    
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(0, btn3.frame.origin.y + btn3.frame.size.height + 2, ScreenWidth , 50)];
    btn4.backgroundColor = [UIColor whiteColor];
    [btn4 addTarget:self action:@selector(btn4Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIImageView *image4 = [[UIImageView alloc]initWithFrame:CGRectMake(7, 12, 35, 26)];
    image4.image = [UIImage imageNamed:@"我的考试后.png"];
    [btn4 addSubview:image4];
    UILabel *labe4 = [[UILabel alloc]initWithFrame:CGRectMake(image4.frame.origin.x  +image4.frame.size.width + 8, 10, ScreenWidth - 100, 30)];
    labe4.text =@"我的考试";
    [btn4 addSubview:labe4];
    
    UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(0, btn4.frame.origin.y + btn4.frame.size.height + 10, ScreenWidth , 50)];
    btn5.backgroundColor = [UIColor whiteColor];
    [btn5 addTarget:self action:@selector(btn5Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    UIImageView *image5 = [[UIImageView alloc]initWithFrame:CGRectMake(7, 12, 35, 26)];
    image5.image = [UIImage imageNamed:@"关于我们.png"];
    [btn5 addSubview:image5];
    
    UILabel *labe5 = [[UILabel alloc]initWithFrame:CGRectMake(image5.frame.origin.x + image5.frame.size.width + 8, 10, ScreenWidth - 100, 30)];
    labe5.text = @"关于我们";
    [btn5 addSubview:labe5];
    
    
}
-(void)btn1Action:(UIButton *)but{
    gerenxinxViewController *view = [[gerenxinxViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
-(void)btn2Action:(UIButton *)but{

}
-(void)btn3Action:(UIButton *)but{

}
-(void)btn4Action:(UIButton *)but{

}
-(void)btn5Action:(UIButton *)but{
    PersonCenterViewController *view = [[PersonCenterViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
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
