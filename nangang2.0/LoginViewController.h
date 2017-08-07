//
//  LoginViewController.h
//  nangang2.0
//
//  Created by 周家新 on 17/7/24.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;

@property (strong, nonatomic) IBOutlet UIButton *btnzd;


- (IBAction)btnzAction:(id)sender;
- (IBAction)btndlAction:(id)sender;

- (IBAction)btnzcAction:(id)sender;



@end
