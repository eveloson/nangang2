//
//  chulisuqiuViewController.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/3.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "chulisuqiuViewController.h"
#import "WDZSegmentedView.h"

@interface chulisuqiuViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation chulisuqiuViewController
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       @[@"待我处理的诉求",@"处理中的诉求",@"已处理的诉求"],
                       @[@"daiwochuliViewController",@"chulizhongViewController",@"yichuliViewController"
                         ]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"诉求处理";
    WDZSegmentedView *segmentedView = [[WDZSegmentedView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) SegmentHeight:44 DataArray:self.dataArray AndVC:self];
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
