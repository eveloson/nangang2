//
//  NaXieShiViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/7/20.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "NaXieShiViewController.h"
#import "WDZSegmentedView.h"

@interface NaXieShiViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation NaXieShiViewController

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       @[@"居家服务",@"招工信息",@"办事指南"],
                       @[@"JujiaView",@"ZhaoGongView",@"BSZNView"
                         ]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"与我相关";
    self.automaticallyAdjustsScrollViewInsets = NO;
    WDZSegmentedView *segmentedView = [[WDZSegmentedView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) SegmentHeight:44 DataArray:self.dataArray AndVC:self];
    [self.view addSubview:segmentedView];
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
