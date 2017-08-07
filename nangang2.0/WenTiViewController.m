//
//  WenTiViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/7/20.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "WenTiViewController.h"
#import "suqiuModel.h"
#import "suqiuCell.h"
#import "chakansuqiuViewController.h"
#import "addsuqiuViewController.h"

@interface WenTiViewController ()<MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *HUD;
    UITableView * myTableView;
    int page;
    int countPage;//每页返回10条数据
}
@property(nonatomic,strong) NSMutableArray *clientArray;
@end

@implementation WenTiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(btnaddsuqiu)];
    self.navigationItem.rightBarButtonItem = rightButton;

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的诉求";
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.navigationController.view.tag = HDT_MBPRGRESSBAR_NOTCANCEL;
    HUD.delegate = self;
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight ) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:HUD];
    page = 1;
    countPage = 10;
    [self setTableviewRefreash];

}
-(void)btnaddsuqiu{
    addsuqiuViewController *view11  = [[addsuqiuViewController alloc]init];
    [self.navigationController pushViewController:view11 animated:YES];
}

-(NSMutableArray *)clientArray{
    if (!_clientArray) {
        _clientArray = [[NSMutableArray alloc] init];
    }
    return _clientArray;
}
#pragma mark -设置刷新
-(void)setTableviewRefreash
{
    
    //self.tableView.mj_footer = [MJRefreshNormal]
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开马上刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新中..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    // header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    //    @"上拉加载更多数据";
    //    self.tableView1.footerReleaseToRefreshText = @"松开马上加载更多数据";
    //    self.tableView1.footerRefreshingText = @"正在加载中...";
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [footer setTitle:@"上拉加载更多数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开马上加载更多数据" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已全部加载完成" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    myTableView.mj_header = header;
    myTableView.mj_footer = footer;
    [myTableView.mj_header beginRefreshing];
    
}

#pragma mark -设置刷新方法
//下拉刷新
-(void)loadNewData
{
    page = 1;
    myTableView.mj_footer.hidden = YES;
    [self.clientArray removeAllObjects];
    [self GetMyQuanZi];
    
}

//上拉刷新
-(void)loadMoreData
{
    page ++;
    [self GetMyQuanZi];
    
}
-(void)GetMyQuanZi{
   [self.view showWarning:@""];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_TOKEN];
    NSString *str = [dic objectForKey:@"userid"];

    NSDictionary *param = @{@"Action":@"AskingList",@"PersonID":str,@"Page":[NSString stringWithFormat:@"%i",page]};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/AskingHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *result = [dic objectForKey:@"result"];
        NSLog(@"%@",dic);
        [self.view hideBusyHUD];
        if ([result isEqualToString:@"success"])
        {
            // 成功了
            NSMutableArray *arr = [dic objectForKey:@"Rows"];
            for (int i = 0; i < arr.count; i ++) {
                suqiuModel *model = [suqiuModel objectWithKeyValues:[arr objectAtIndex:i]];
                [self.clientArray addObject:model];
            }
            [myTableView.mj_header endRefreshing];
            if (arr.count == 0) {
                [self.view showWarning1:@"暂无更多信息"];
                [myTableView.mj_footer endRefreshingWithNoMoreData];
                myTableView.mj_footer.hidden = YES;
            }else if(arr.count < 10)
            {
                [myTableView.mj_footer endRefreshing];
                myTableView.mj_footer.hidden = NO;
            }else
            {
                [self.view hideBusyHUD];
                [myTableView.mj_footer endRefreshing];
                myTableView.mj_footer.hidden = NO;
            }
        }
        else
        {
            NSString *error = [dic objectForKey:@"tips"];
            [self.view showWarning1:error];
            [myTableView.mj_header endRefreshing];
            [myTableView.mj_footer endRefreshing];
            myTableView.mj_footer.hidden = YES;

        }
        [myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.view hideBusyHUD];
        [myTableView.mj_header endRefreshing];
        [myTableView.mj_footer endRefreshing];
        myTableView.mj_footer.hidden = YES;
        [self.view showWarning1:[NSString stringWithFormat:@"%@",error]];
    }];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 81;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clientArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    suqiuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"suqiuCell"];
    if (!cell) {
        cell = [[suqiuCell alloc]init];
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"suqiuCell" owner:nil options:nil];
        cell = [array lastObject];
    }
       suqiuModel *model = [self.clientArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",model.Reason];
    cell.labelstate.text = [NSString stringWithFormat:@"%@",model.State];
    cell.btn2.layer.cornerRadius = 5;
    [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"24.PNG"] forState:UIControlStateNormal];
    [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"25.PNG"] forState:UIControlStateHighlighted];
    [cell.btn2 setTitle:@"查看" forState:UIControlStateNormal];
    [cell.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cell.btn2.tag = indexPath.row;
    [cell.btn2 addTarget:self action:@selector(btnsuiu:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
//    cell.textLabel = [NSString stringWithFormat:@"%@",model.]

}
- (void)btnsuiu:(UIButton*)sender{
    chakansuqiuViewController *view = [[chakansuqiuViewController alloc]init];
    suqiuModel *model = [self.clientArray objectAtIndex:sender.tag];
     view.model = model;
    [self.navigationController pushViewController:view animated:YES];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
