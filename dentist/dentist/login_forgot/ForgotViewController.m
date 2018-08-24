//
//  ForgotViewController.m
//  dentist
//
//  Created by Jacksun on 2018/8/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ForgotViewController.h"
#import "Common.h"
#import "StackLayout.h"
#import "UIView+customed.h"
#import "UILabel+customed.h"
#import "UIControl+customed.h"
#import "ResetPwdViewController.h"

@interface ForgotViewController ()<UIAlertViewDelegate>
{
    UITextField *emailEdit;
}
@end

@implementation ForgotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logoView = self.view.addImageView;
    logoView.imageName = @"logo";
    [logoView layoutCenterXOffsetTop:260 height:54 offset:54];
    
    UILabel *panic = [UILabel new];
    panic.text = localStr(@"Don't panic");
    panic.font = [Fonts medium:38];
    panic.textColor = UIColor.blackColor;
    panic.backgroundColor = UIColor.clearColor;
    [self.view addSubview:panic];
    
    UILabel *textLab = [UILabel new];
    textLab.numberOfLines = 0 ;
    textLab.text = localStr(@"just");
    textLab.font = [Fonts medium:17];
    textLab.textColor = UIColor.blackColor;
    textLab.backgroundColor = UIColor.clearColor;
    [self.view addSubview:textLab];
    
    emailEdit = self.view.addEdit;
    emailEdit.delegate = self;
    emailEdit.hint = localStr(@"email_address");
    [emailEdit layoutFillXOffsetBottom:EDIT_HEIGHT offset:125];

    UIButton *sendButton = [UIButton new];
    [sendButton title:localStr(@"send")];
    [sendButton stylePrimary];
    [self.view addSubview:sendButton];
    
    NSString * aStr = localStr(@"nevermind");
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,10)];
    [str addAttribute:NSForegroundColorAttributeName value:Colors.primary range:NSMakeRange(10,aStr.length - 10)];
    
    UIButton * backBtn = [UIButton new];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backBtn setTitleColor:rgb255(155, 155, 155) forState:UIControlStateNormal];
    [backBtn setAttributedTitle:str forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    StackLayout *sl = [StackLayout new];
    [sl push:backBtn height:BTN_HEIGHT marginBottom:30];
    [sl push:sendButton height:BTN_HEIGHT marginBottom:8];
    [sl push:emailEdit height:EDIT_HEIGHT marginBottom:14];
    [sl push:textLab height:60 marginBottom:12];
    [sl push:panic height:36 marginBottom:2];
    [sl install];
    
    
    [backBtn onClick:self action:@selector(clickGoBack:)];
    [sendButton onClick:self action:@selector(sendPwdClick)];
    // Do any additional setup after loading the view.
}

- (void)clickGoBack:(id)sender {
    [self dismiss];
}

- (void)sendPwdClick
{
    if ([emailEdit.text trimed].length < 5 || !emailEdit.text.matchEmail) {
        [emailEdit themeError];
    } else {
        [emailEdit themeNormal];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:localStr(@"newPwdSend") delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];

    }
}

- (void)onTextFieldDone:(UITextField *)textField {
    
    if ([emailEdit.text trimed].length < 5 || !emailEdit.text.matchEmail) {
        [emailEdit themeError];
    } else {
        [emailEdit themeNormal];
    }
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//click the OK btn
        ResetPwdViewController *resetPwd = [ResetPwdViewController new];
        [self openPage:resetPwd];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
