//
//  WDZsegumentViewController.m
//

#import "WDZSegmentedControl.h"
@interface WDZSegmentedControl ()<WDZSegmentedControlDelegate>
{
    UIView* buttonDown;
    CGPoint refCenter;
    CGFloat witdFloat;
}
@end

@implementation WDZSegmentedControl

- (void)addSeperatorLineWithColor:(UIColor *)color;{
    [self.ButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != self.ButtonArray.count-1) {
            UIButton *btn = (UIButton *)obj;
            CGRect frame = btn.frame;
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-1, 5, 1, frame.size.height-10)];
            line.backgroundColor = color;
            [btn addSubview:line];
        }
    }];
}
-(void)AddSeveralSegumentArray:(NSArray *)SegumentArray
{
    NSInteger seugemtNumber=SegumentArray.count;
    witdFloat=(self.bounds.size.width)/seugemtNumber;
    for (int i=0; i<SegumentArray.count; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(i*witdFloat, 0, witdFloat, self.bounds.size.height-2)];
        [button setTitle:SegumentArray[i] forState:UIControlStateNormal];
        //        NSLog(@"这里defont%@",[button.titleLabel.font familyName]);
        [button.titleLabel setFont:self.titleFont];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectColor forState:UIControlStateSelected];
        [button setTag:i];
        [button addTarget:self action:@selector(changeTheSegument:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            //            NSString* title = SegumentArray[i];
            //            CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:self.titleFont}];
            //            buttonDown=[[UIView alloc]initWithFrame:CGRectMake((witdFloat-titleSize.width)/2, self.bounds.size.height-2, titleSize.width, 2)];
            buttonDown = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, witdFloat, 2)];
            [buttonDown setBackgroundColor:self.selectColor];
            [self addSubview:buttonDown];
        }
        [self addSubview:button];
        [self.ButtonArray addObject:button];
    }
    [[self.ButtonArray firstObject] setSelected:YES];
}
-(void)AddManySegumentArray:(NSArray *)SegumentArray
{
    CGFloat lastBtnMaxX = 0;
    for (int i=0; i<SegumentArray.count; i++) {
        NSString *title = SegumentArray[i];
        CGSize titleSize = [title boundingRectWithSize:CGSizeMake(999, 0) options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.titleFont} context:nil].size;
        titleSize.width += 20;
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(lastBtnMaxX, 0, titleSize.width, self.bounds.size.height-2)];
        lastBtnMaxX += titleSize.width;
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:self.titleFont];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectColor forState:UIControlStateSelected];
        [button setTag:i];
        [button addTarget:self action:@selector(changeTheSegument:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            buttonDown = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, titleSize.width, 2)];
            [buttonDown setBackgroundColor:self.selectColor];
            [self addSubview:buttonDown];
        }
        if (i==1) {
            refCenter = button.center;
        }
        if (i == SegumentArray.count-1) {
            self.contentSize = CGSizeMake(lastBtnMaxX, 0);
        }
        [self addSubview:button];
        [self.ButtonArray addObject:button];
    }
    
    [[self.ButtonArray firstObject] setSelected:YES];
}
-(void)changeTheSegument:(UIButton*)button
{
    [self selectTheSegument:button.tag isDoDelegate:YES];
    
}
-(void)selectTheSegument:(NSInteger)segument isDoDelegate:(BOOL)flag
{
    if (self.selectSeugment!=segument) {
        UIButton *btn = self.ButtonArray[segument];
        [self.ButtonArray[self.selectSeugment] setSelected:NO];
        [self.ButtonArray[segument] setSelected:YES];
        if (self.contentSize.width > self.frame.size.width && segument >= 1 && segument != self.ButtonArray.count-1 ) {
            CGFloat offsetX = btn.center.x - refCenter.x;
                                [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }
        [UIView animateWithDuration:0.1 animations:^{
            [buttonDown setFrame:CGRectMake(btn.frame.origin.x,self.bounds.size.height-2, btn.frame.size.width, 2)];
        }];
        self.selectSeugment=segument;
        if (flag) {
            [self.scDelegate segumentSelectionChange:self.selectSeugment];
        }
    }
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    self.contentInset = UIEdgeInsetsZero;
    self.ButtonArray=[NSMutableArray array];
    self.selectSeugment=0;
    self.titleFont=[UIFont fontWithName:@".Helvetica Neue Interface" size:14.0f];
    self.LJBackGroundColor = [UIColor colorWithRed:253.0f/255 green:239.0f/255 blue:230.0f/255 alpha:1.0f];
    self.titleColor = RGB(151, 173, 192);
    self.selectColor = RGB(16, 175, 241);
    [self setBackgroundColor:self.LJBackGroundColor];
    return self;
}
- (void)setLJBackGroundColor:(UIColor *)LJBackGroundColor{
    _LJBackGroundColor = LJBackGroundColor;
    self.backgroundColor = LJBackGroundColor;
}
@end
