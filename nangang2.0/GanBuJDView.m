//
//  GanBuJDView.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/14.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "GanBuJDView.h"
#import "GanbuModel.h"
#import "ganbujianduCell.h"

@interface GanBuJDView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    int page;
    int countPage;//每页返回10条数据
}
@property(nonatomic,strong) NSMutableArray *clientArray;
@end

@implementation GanBuJDView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 -44) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
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
    
    NSDictionary *param = @{@"Action":@"getSuperviseList",@"Page":[NSString stringWithFormat:@"%i",page]};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",HOSTURL,@"/AjaxService/SuperviseHandler.ashx"] parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
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
                GanbuModel *model = [GanbuModel objectWithKeyValues:[arr objectAtIndex:i]];
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
    GanbuModel *model = [self.clientArray objectAtIndex:indexPath.row];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, ScreenWidth -110, 30)];
    label3.text = [NSString stringWithFormat:@"职位:%@",model.Position];
    label3.numberOfLines = 0;
    
    CGSize size = [label3 sizeThatFits:CGSizeMake(label3.frame.size.width, MAXFLOAT)];
    
    label3.frame = CGRectMake(label3.frame.origin.x, label3.frame.origin.y, label3.frame.size.width, size.height + 10);
     UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(100,  label3.frame.origin.y +  size.height, ScreenWidth -110, 30)];
    label4.text = [NSString stringWithFormat:@"负责:%@",model.Jobs];
    
    label4.lineBreakMode = NSLineBreakByCharWrapping;
    
    label4.numberOfLines = 0;
    CGSize size1 = [label4 sizeThatFits:CGSizeMake(label4.frame.size.width, MAXFLOAT)];
    
    label4.frame = CGRectMake(label4.frame.origin.x, label4.frame.origin.y, label4.frame.size.width, size1.height +10);

    return 70 + label4.frame.origin.y + label4.frame.size.height + 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clientArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    static NSString *resueId = @"resueId";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resueId];
//    UIImageView *imageV;
//    UIButton *btndianhua;
//    UILabel *label;
//    UILabel *label1;
//    UILabel *label2;
//    UILabel *label3;
//    UILabel *label4;
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resueId];
//        imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, (cell.frame.size.height - 80)/2.000,  80, 80)];
//        label = [[UILabel alloc]init];
//        label1 = [[UILabel alloc]init];
//        label.frame = CGRectMake(imageV.frame.origin.x + imageV.frame.size.width + 10, 10, ScreenWidth - imageV.frame.origin.x - imageV.frame.size.width - 10, 30);
//        label1.frame = CGRectMake(imageV.frame.origin.x + imageV.frame.size.width + 10, label.frame.origin.y + label.frame.size.height, 60, 30);
//        label1.text = @"电话:";
//        btndianhua = [[UIButton alloc]initWithFrame:CGRectMake(label1.frame.origin.x + label1.frame.size.width, label.frame.origin.y + label.frame.size.height, ScreenWidth - label1.frame.origin.x - label1.frame.size.width - 10, 30)];
//        label2 = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x + label1.frame.size.width, label.frame.origin.y + label.frame.size.height, ScreenWidth - label1.frame.origin.x - label1.frame.size.width - 10, 30)];
//        label2.textColor = [UIColor blueColor];
//        label3 = [[UILabel alloc]initWithFrame:CGRectMake(imageV.frame.origin.x + imageV.frame.size.width + 10, label2.frame.origin.y + label2.frame.size.height, ScreenWidth - imageV.frame.origin.x - imageV.frame.size.width - 10  , 30)];
//        label4 = [[UILabel alloc]initWithFrame:CGRectMake(imageV.frame.origin.x + imageV.frame.size.width + 10, label3.frame.origin.y + label3.frame.size.height, ScreenWidth - imageV.frame.origin.x - imageV.frame.size.width - 10, 30)];
//        
//    }
    ganbujianduCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ganbujianduCell"];
    if (!cell)
    {
        cell = [[ganbujianduCell alloc]init];
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"ganbujianduCell" owner:nil options:nil];
        cell = [array lastObject];
    }
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    GanbuModel *model = [self.clientArray objectAtIndex:indexPath.row];
    cell.label.text = [NSString stringWithFormat:@"姓名:%@",model.Name];
    cell.label2.text = [NSString stringWithFormat:@"%@",model.Telephone];
    cell.label1.text = @"电话:";
    cell.label2.textColor = ThemeColor;
    NSString *textStr = [NSString stringWithFormat:@"%@",model.Telephone];
    
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    
    //赋值
    cell.label2.attributedText = attribtStr;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://222.184.127.50:10070/up/%@",model.ImgUrl]] placeholderImage:[UIImage imageNamed:@"33.PNG"]];
    cell.label3.text = [NSString stringWithFormat:@"职位:%@",model.Position];
    cell.label3.numberOfLines = 0;
    
    CGSize size = [cell.label3 sizeThatFits:CGSizeMake(cell.label3.frame.size.width, MAXFLOAT)];
    
    cell.label3.frame = CGRectMake(cell.label3.frame.origin.x, cell.label3.frame.origin.y, cell.label3.frame.size.width, size.height+ 10);
    cell.label4.text = [NSString stringWithFormat:@"负责:%@",model.Jobs];

    
    cell.label4.numberOfLines = 0;
    CGSize size1 = [cell.label4 sizeThatFits:CGSizeMake(cell.label4.frame.size.width, MAXFLOAT)];

    cell.label4.frame = CGRectMake(cell.label4.frame.origin.x, cell.label3.frame.origin.y + cell.label3.frame.size.height, cell.label4.frame.size.width, size1.height +10);

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
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
