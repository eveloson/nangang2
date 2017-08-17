//
//  AddReplyViewController.m
//  nangang2.0
//
//  Created by wubin on 2017/8/17.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "AddReplyViewController.h"

@interface AddReplyViewController ()

@end

@implementation AddReplyViewController

- (instancetype)init{
    XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"回复"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    form.assignFirstResponderOnShow = YES;
    // Section0
    section = [XLFormSectionDescriptor formSection];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"CommentMsg" rowType:XLFormRowDescriptorTypeTextView];
    row.cellConfigAtConfigure[@"separatorView"] = [UIView new];
    row.height = 180;
    row.required = YES;
    row.requireMsg = @"内容不能为空！";
    [row.cellConfigAtConfigure setObject:@"请填写评论" forKey:@"textView.placeholder"];
    [section addFormRow:row];
    [form addFormSection:section];
    
    return [super initWithForm:form];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = RGB(240, 240, 240);
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    bottomView.backgroundColor = RGB(79, 192, 233);
    UIButton *submit = [UIButton new];
    [submit setTitle:@"完   成" forState:UIControlStateNormal];
    submit.titleLabel.textColor = [UIColor whiteColor];
    submit.layer.cornerRadius = 5;
    [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchDown];
    [bottomView addSubview:submit];
    [self.view addSubview:bottomView];
    [submit makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomView);
        make.width.height.equalTo(bottomView);
    }];
    [self.view addSubview:bottomView];
    // Do any additional setup after loading the view.
}
- (void)submit{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    NSMutableDictionary *param = [[self formValues] mutableCopy];
    param[@"isReply"] = @0;
    param[@"UserId"] = kUserID;
    param[@"UserName"] = kUserName;
    param[@"ParentId"] = self.comment.Id;
    [WDZAFNetworking get:[NSString stringWithFormat:@"%@%@",ServerName,@"TabCommentHandler.ashx?Action=addComment"] parameters:param success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            [self.vc setupComments];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"发送失败，请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    } loadingMsg:@"正在提交ing" errorMsg:@"网络连接错误，请重试"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
@end
