//
//  daiwochuliViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/3.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "daiwochuliViewController.h"
#import "chulisuqiumodel.h"
#import "chuliView.h"
#import "suModel.h"

@interface daiwochuliViewController ()<MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *HUD;
    UITableView * myTableView;
    int page;
    int countPage;//每页返回10条数据
}
@property(nonatomic,strong) NSMutableArray *clientArray;
@end

@implementation daiwochuliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -108) style:UITableViewStylePlain];
   
    myTableView.delegate = self;
    myTableView.dataSource = self;
//    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    page = 1;
    countPage = 10;
    [self setTableviewRefreash];
}
-(NSMutableArray *)clientArray{
    if (!_clientArray) {
        _clientArray = [[NSMutableArray alloc] init];
    }
    return _clientArray;
}
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
    [self AskingHandleRequest];
    
}

//上拉刷新
-(void)loadMoreData
{
    page ++;
    [self AskingHandleRequest];
    
}

-(void)AskingHandleRequest{
    [self.view showWarning:@""];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_TOKEN];
    NSString *str = [dic objectForKey:@"userid"];
    
    NSDictionary *param = @{@"Action":@"AskingHandle",@"Id":str,@"Page":[NSString stringWithFormat:@"%i",page]};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/OperateHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
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
                chulisuqiumodel *model = [chulisuqiumodel objectWithKeyValues:[arr objectAtIndex:i]];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clientArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *resueId = @"resueId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resueId];
    UILabel *label;
    UIButton *btn;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resueId];
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, ScreenWidth - 25 - 70, 34)];
        [cell addSubview:label];
        btn = [[UIButton alloc]initWithFrame:CGRectMake(label.frame.origin.x + label.frame.size.width + 5, 5, 70, 34)];
        [cell addSubview:btn];
    }
    chulisuqiumodel *model = [self.clientArray objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%@",model.Reason];
    [btn setBackgroundImage:[UIImage imageNamed:@"24.PNG"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"25.PNG"] forState:UIControlStateHighlighted];
    [btn setTitle:@"处理" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnchuliAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    btn.tag = indexPath.row;
    
    return cell;
    
}
-(void)btnchuliAction:(UIButton *)but{
    chulisuqiumodel *model = [self.clientArray objectAtIndex:but.tag];
    NSDictionary *dic1 = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_TOKEN];
    NSString *userID = [dic1 objectForKey:@"userid"];
    
    [self.view showWarning:@""];
    NSDictionary *param = @{@"Action":@"AskingHandleView",@"PersonID":userID,@"ID":model.ID};
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
            suModel *model1 = [suModel objectWithKeyValues:[[dic objectForKey:@"Rows"] objectAtIndex:0]];
        dispatch_async(dispatch_get_main_queue(), ^{
            chuliView *view = [[chuliView alloc]init];
            
            view.model = model;
            view.model1 = model1;
            [self.navigationController pushViewController:view animated:YES];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
