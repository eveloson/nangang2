//
//  WDZSegmentedView.h
//  hagjj
//
//  Created by wubin on 2017/6/29.
//  Copyright © 2017年 clkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDZSegmentedControl.h"
typedef  void (^WDZonChangeBlock)(NSInteger index,UIViewController *fromVC,UIViewController *toVC);

@interface WDZSegmentedView : UIView
@property (nonatomic, weak) WDZSegmentedControl *sc;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, copy) WDZonChangeBlock onChangeBlock;
- (instancetype)initWithFrame:(CGRect)frame SegmentHeight:(CGFloat)segmentHeight DataArray:(NSArray *)dataArray AndVC:(UIViewController *)vc;
- (void)addSeperatorLineWithColor:(UIColor *)color;
@end
