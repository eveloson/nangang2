//
//  WDZSegmentedView.m
//  hagjj
//
//  Created by wubin on 2017/6/29.
//  Copyright © 2017年 clkeji. All rights reserved.
//

#import "WDZSegmentedView.h"

@interface WDZSegmentedView () <WDZSegmentedControlDelegate,UIScrollViewDelegate>
@property (nonatomic, assign) CGFloat segmentHeight;
@end

@implementation WDZSegmentedView

- (instancetype)initWithFrame:(CGRect)frame SegmentHeight:(CGFloat)segmentHeight DataArray:(NSArray *)dataArray AndVC:(UIViewController *)vc{
    self = [super initWithFrame:frame];
    self.segmentHeight = segmentHeight;
    self.dataArray = dataArray;
    self.vc = vc;
    [self setupSegmentControl];
    [self setupScrollView];
    [self setupChildVC];
    return self;
}
- (void)setupSegmentControl{
    WDZSegmentedControl *sc = [[WDZSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.segmentHeight)];
    self.sc = sc;
    self.sc.LJBackGroundColor = [UIColor whiteColor];
    self.sc.selectColor = ThemeColor;
    self.sc.titleColor = [UIColor darkGrayColor];
    self.sc.scDelegate = self;
    [self.sc AddSeveralSegumentArray:self.dataArray[0]];
//    [self.sc addSeperatorLineWithColor:[UIColor darkGrayColor]];
    [self addSubview:sc];
}
- (void)addSeperatorLineWithColor:(UIColor *)color{
    [self.sc addSeperatorLineWithColor:color];
}
- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sc.frame), self.frame.size.width, self.frame.size.height - self.segmentHeight)];
    self.scrollView = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    //    scrollView.scrollEnabled = NO; //关闭滚动
    scrollView.directionalLockEnabled = YES;//横竖屏不同时滚动锁定
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.contentInset = UIEdgeInsetsZero;
    scrollView.contentSize = CGSizeMake(self.frame.size.width * [self.dataArray[1] count], 0);
    [self addSubview:scrollView];
}
- (void)setupChildVC{
    NSArray *vcArray = self.dataArray[1];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * vcArray.count, 0);
    for (int i=0; i<vcArray.count; i++) {
        UIViewController *vc = [[NSClassFromString(vcArray[i]) alloc] init];
        vc.view.frame = CGRectMake(i*self.frame.size.width, 0,self.scrollView.bounds.size.width,self.scrollView.bounds.size.height);
        [self.scrollView addSubview:vc.view];
        [self.vc addChildViewController:vc];
    }
}
#pragma mark WDZSegmentedControlDelegate
-(void)segumentSelectionChange:(NSInteger)selection{
    CGFloat offsetX = selection * self.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
    if (self.onChangeBlock) {
        UIViewController *fromVC = self.vc.childViewControllers[self.sc.selectSeugment];
        UIViewController *toVC = self.vc.childViewControllers[selection];
        self.onChangeBlock(selection,fromVC,toVC);
    }
}
#pragma mark scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    [self.sc selectTheSegument:page isDoDelegate:YES];
}
@end
