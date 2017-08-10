//
//  ReplyViewController.m
//  nangang2.0
//
//  Created by wubin on 2017/8/9.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "ReplyViewController.h"

@interface ReplyViewController ()

@end

@implementation ReplyViewController
- (instancetype)init{
    XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"发布动态"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    form.assignFirstResponderOnShow = YES;
    // Section0
    section = [XLFormSectionDescriptor formSection];
    //内容
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"content" rowType:XLFormRowDescriptorTypeTextView];
    row.cellConfigAtConfigure[@"separatorView"] = [UIView new];
    row.height = 180;
    row.required = YES;
    row.requireMsg = @"回复内容不能为空！";
    [row.cellConfigAtConfigure setObject:@"在这里输入回复内容" forKey:@"textView.placeholder"];
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
    [submit setTitle:@"提   交" forState:UIControlStateNormal];
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
}
- (void)submit{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
@end
