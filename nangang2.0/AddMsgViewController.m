//
//  AddMsgViewController.m
//  nangang2.0
//
//  Created by wubin on 2017/8/8.
//  Copyright © 2017年 Zhou. All rights reserved.
//
#define kFooterH 250
#import "AddMsgViewController.h"
#import "LPDQuoteImagesView.h"
#import "ZhouBianShiViewController.h"
@interface AddMsgViewController ()<LPDQuoteImagesViewDelegate>
@property (nonatomic, weak) LPDQuoteImagesView *imagesView;
@end

@implementation AddMsgViewController
- (instancetype)init{
    XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"发布动态"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    form.assignFirstResponderOnShow = YES;
    // Section0
    section = [XLFormSectionDescriptor formSection];
    // 标题
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"title" rowType:XLFormRowDescriptorTypeText title:@"标题"];
//    [row.cellConfigAtConfigure setValue:@"(选填)" forKey:@"textField.placeholder"];
//    row.cellConfigAtConfigure[@"separatorView"] = [UIView new];
    //    For right padding :
    //    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    //    [row.cellConfig setObject:paddingView forKey:@"textField.rightView"];
    //    [row.cellConfig setObject:@(UITextFieldViewModeAlways) forKey:@"textField.rightViewMode"];
//    [row.cellConfigAtConfigure setValue:@(NSTextAlignmentLeft) forKey:@"textField.textAlignment"];
//    row.cellConfig[@"backgroundColor"] = [UIColor clearColor];
//    [section addFormRow:row];
    //内容
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"content" rowType:XLFormRowDescriptorTypeTextView];
    row.cellConfigAtConfigure[@"separatorView"] = [UIView new];
    row.height = 180;
    row.required = YES;
    row.requireMsg = @"内容不能为空！";
    [row.cellConfigAtConfigure setObject:@"填写有意思的内容，让大家高兴一下" forKey:@"textView.placeholder"];
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
    NSMutableDictionary *para = [[self httpParameters] mutableCopy];
    para[@"AddId"] = kUserID;
    para[@"Adder"] = kUserName;
    [WDZAFNetworking post:[NSString stringWithFormat:@"%@%@",ServerName,@"tb_talkHandler.ashx?Action=addTalk"] images:self.imagesView.selectedPhotos parameters:para success:^(id  _Nonnull json) {
        if ([json[@"result"] isEqualToString:@"success"]) {
            [self.vc refreshData];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"发送失败，请重试！"];
        }
        
    } failure:nil loadingMsg:@"正在上传ing" errorMsg:@"网络连接错误，请重试"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LPDQuoteImagesView *view = [[LPDQuoteImagesView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kFooterH) withCountPerRowInView:3 cellMargin:20];
    view.collectionView.scrollEnabled = NO;
    view.navcDelegate = self;
    view.maxSelectedCount = 6;
    self.imagesView = view;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFooterH;
}

@end
