//
//  ZhaoGongView.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/14.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "ZhaoGongView.h"
#import "juwuModel.h"
#import "juwuxiangqingView.h"
#import "duanyuanzijiaCell.h"

@interface ZhaoGongView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
    int page;
    int countPage;//每页返回10条数据
}
@property(nonatomic,strong) NSMutableArray *clientArray;

@end

@implementation ZhaoGongView
-(NSMutableArray *)clientArray{
    if (!_clientArray) {
        _clientArray = [[NSMutableArray alloc] init];
    }
    return _clientArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, ScreenHeight- 44 -64) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    page = 1;
    countPage = 10;
    [self setTableviewRefreash];

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
//    [self.clientArray removeAllObjects];
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
    
    NSDictionary *param = @{@"Action":@"getNewsNoCList",@"CategoryName":@"招工信息",@"Page":[NSString stringWithFormat:@"%i",page]};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/NewsHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *result = [dic objectForKey:@"result"];
        NSLog(@"%@",dic);
        [self.view hideBusyHUD];
        if ([result isEqualToString:@"success"])
        {
            // 成功了
            if (page == 1) {
                [self.clientArray removeAllObjects];
            }

            NSMutableArray *arr = [dic objectForKey:@"Rows"];
            for (int i = 0; i < arr.count; i ++) {
                juwuModel *model = [juwuModel objectWithKeyValues:[arr objectAtIndex:i]];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clientArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    duanyuanzijiaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"duanyuanzijiaCell"];
    if (!cell)
    {
        cell = [[duanyuanzijiaCell alloc]init];
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"duanyuanzijiaCell" owner:nil options:nil];
        cell = [array lastObject];
    }
    
    juwuModel *model = [self.clientArray objectAtIndex:indexPath.row];
    NSLog(@"%@ %li",model.rn  ,(long)indexPath.row);
    cell.label.text = [NSString stringWithFormat:@"%@",model.Title];
    cell.label1.text = [NSString stringWithFormat:@"%@",model.FBTime];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    juwuxiangqingView *view = [[juwuxiangqingView alloc]init];
    juwuModel *model = [self.clientArray objectAtIndex:indexPath.row];
    view.model = model;
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
