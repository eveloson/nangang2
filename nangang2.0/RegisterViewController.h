//
//  RegisterViewController.h
//  nangang2.0
//
//  Created by 周家新 on 17/7/24.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *sjhTextField;

@property (strong, nonatomic) IBOutlet UITextField *mmTextField;
@property (strong, nonatomic) IBOutlet UITextField *qrmmTextField;

@property (strong, nonatomic) IBOutlet UIButton *btnxuanze1;

- (IBAction)btnxuanzeAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnxuanze2;

- (IBAction)btnxuanze2Action:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *x2TextField;
@property (strong, nonatomic) IBOutlet UITextField *x3TextField;

- (IBAction)btnzcAction:(id)sender;
- (IBAction)btnFanHuiAction:(id)sender;

@end
