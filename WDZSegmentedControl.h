//
//  WDZsegumentViewController.h
//

#import <UIKit/UIKit.h>
@protocol WDZSegmentedControlDelegate< NSObject>
@optional
-(void)segumentSelectionChange:(NSInteger)selection;
@end
@interface WDZSegmentedControl : UIScrollView
@property(nonatomic,weak)id <WDZSegmentedControlDelegate>scDelegate;
@property(nonatomic,strong)NSMutableArray* ButtonArray;
@property(nonatomic,assign)NSInteger selectSeugment; 
@property(strong,nonatomic)UIColor* LJBackGroundColor;
@property(strong,nonatomic)UIColor* titleColor;
@property(strong,nonatomic)UIColor* selectColor;
@property(strong,nonatomic)UIFont* titleFont;
//不超过屏幕宽度的button
-(void)AddSeveralSegumentArray:(NSArray *)SegumentArray;
//超过屏幕滚动的button
-(void)AddManySegumentArray:(NSArray *)SegumentArray;
- (void)addSeperatorLineWithColor:(UIColor *)color;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)selectTheSegument:(NSInteger)segument isDoDelegate:(BOOL)flag;
@end

