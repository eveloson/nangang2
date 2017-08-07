//
//  IndexViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/7/10.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "IndexViewController.h"
#import "WenTiViewController.h"
#import "ZhouBianShiViewController.h"
#import "DangWuViewController.h"
#import "XueXueViewController.h"
#import "NaXieShiViewController.h"
#import "ShouGuiJuViewController.h"
#import "ShangJiViewController.h"
#import "chulisuqiuViewController.h"

@interface IndexViewController ()<MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *HUD;
    UITableView *myTableView;
}
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"处理诉求" style:UIBarButtonItemStylePlain target:self action:@selector(chulisuqiuAction)];
                                    
                                    //initWithImage:[UIImage imageNamed:@"11.PNG"] style:UIBarButtonItemStylePlain target:self action:@selector(chulisuqiuAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"南港快捷通";
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.navigationController.view.tag = HDT_MBPRGRESSBAR_NOTCANCEL;
    HUD.delegate = self;

    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -114) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    [self.view addSubview:HUD];
}
-(void)chulisuqiuAction{
    chulisuqiuViewController *view = [[chulisuqiuViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *resueId = @"resueId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resueId];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resueId];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight *0.28)];
    imageV.image = [UIImage imageNamed:@"pic.png"];
    [cell addSubview:imageV];
    for (int i = 0; i < 7; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth/3.00) * (i%3), imageV.frame.origin.y + imageV.frame.size.height + (ScreenWidth/3.00 ) * (i/3), ScreenWidth/3.00, ScreenWidth/3.00 )];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        
        UIImageView *Bimage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth/3.00 - 40, ScreenWidth/3.00 - 40)];
        Bimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%i",i]];
        [btn addSubview:Bimage];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth/3.00 - 15, ScreenWidth/3.00, 30)];
        label.textAlignment = 1;
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:14];
         [btn addSubview:label];
        switch (i) {
            case 0:
            {
                label.text = @"我有问题需帮忙";
            }
                break;
            case 1:
            {
                label.text = @"我要看看周边事";
            }
                break;
            case 2:
            {
                label.text = @"学一学得实惠";
            }
                break;
            case 3:
            {
                label.text = @"党务居务晒一晒";
            }
                break;
            case 4:
            {
                label.text = @"与我有关那些事";
            }
                break;
            case 5:
            {
                label.text = @"我是党员守规矩";
            }
                break;

            case 6:
            {
                label.text = @"看看上级怎么说";
            }
                break;


            default:
                break;
        }
       
    }
    return cell;
}
-(void)btnAction:(UIButton *)but{
    switch (but.tag) {
        case 0:
        {
            WenTiViewController *view = [[WenTiViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            ZhouBianShiViewController *view = [[ZhouBianShiViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 2:
        {
            XueXueViewController *view = [[XueXueViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 3:
        {
            DangWuViewController *view = [[DangWuViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 4:
        {
            NaXieShiViewController *view = [[NaXieShiViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 5:
        {
            ShouGuiJuViewController *view = [[ShouGuiJuViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 6:
        {
            ShangJiViewController *view = [[ShangJiViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;

        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
