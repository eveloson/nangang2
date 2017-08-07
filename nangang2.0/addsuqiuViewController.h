//
//  addsuqiuViewController.h
//  nangang2.0
//
//  Created by 周家新 on 17/8/3.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addsuqiuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


@property (strong, nonatomic) IBOutlet UILabel *dianhuaLabel;
@property (strong, nonatomic) IBOutlet UILabel *dizhiLabel;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *btnTJ;
- (IBAction)btnTJaction:(id)sender;

@end
