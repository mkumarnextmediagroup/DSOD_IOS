//
//  ResetPwdViewController.m
//  dentist
//
//  Created by Jacksun on 2018/8/22.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "ContactViewController.h"

@interface ResetPwdViewController ()
{
    UITextField *rePwdEdit;
    UITextField *pwdEdit;
    UITextField *nameEdit;
    BOOL        isContinue;
}
@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backImg = [UIImage imageNamed:@"close.png"];
    [self setTopTitle:localStr(@"resetPwd") imageName:backImg];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logoView = self.view.addImageView;
    logoView.imageName = @"logo";
    [logoView layoutCenterXOffsetTop:260 height:54 offset:104];
    
    StackLayout *sl = [StackLayout new];
    
    UIButton *contactButton = self.view.contactButton;
    [sl push:contactButton height:BTN_HEIGHT marginBottom:12];
    
    UIButton *regButton = self.view.resetButton;
    [regButton title:localStr(@"resetPwdLower")];
    [sl push:regButton height:BTN_HEIGHT marginBottom:5];
    
    UITextView *noticeLab = self.view.noticeLabel;
    noticeLab.text = localStr(@"pwdstandard");
    noticeLab.font = [Fonts light:10];
    [sl push:noticeLab height:45 marginBottom:30];
    
    UILabel *reqLabel = self.view.addLabel;
    reqLabel.text = localStr(@"pwd_req");
    reqLabel.font = [Fonts light:12];
    [reqLabel textColorPrimary];
    UIImageView *infoImgView = reqLabel.addImageView;
    infoImgView.imageName = @"info";
    [infoImgView scaleFill];
    [[[[[infoImgView layoutMaker] sizeEq:15 h:15] leftParent:0] centerYParent:0] install];
    [sl push:reqLabel height:[reqLabel heightThatFit] marginBottom:15];
    
    rePwdEdit = self.view.resetEdit;
    rePwdEdit.delegate = self;
    rePwdEdit.hint = localStr(@"conpwd");
    [rePwdEdit returnNext];
    [rePwdEdit returnDone];
    [rePwdEdit keyboardDefault];
    [sl push:rePwdEdit height:36 marginBottom:10];
    
    pwdEdit = self.view.resetEdit;
    pwdEdit.delegate = self;
    pwdEdit.hint = localStr(@"newpwd");
    [pwdEdit returnNext];
    [pwdEdit keyboardEmail];
    [sl push:pwdEdit height:36 marginBottom:10];
    
    nameEdit = self.view.resetEdit;
    nameEdit.delegate = self;
    nameEdit.hint = localStr(@"temppwd");
    [nameEdit returnNext];
    [nameEdit keyboardDefault];
    [sl push:nameEdit height:36 marginBottom:10];
    
    UILabel *lbReg = self.view.addLabel;
    lbReg.text = localStr(@"hereyou");
    lbReg.font = [Fonts regular:17];
    lbReg.numberOfLines = 0;
    lbReg.textColor = [UIColor blackColor];
//    CGSize sz = [lbReg sizeThatFits:CGSizeZero];
    [sl push:lbReg height:45 marginBottom:20];
    
    
    [sl install];
    
    [contactButton onClick:self action:@selector(contactBtnClick)];
    [regButton onClick:self action:@selector(regBtnClick)];
    
    // Do any additional setup after loading the view.
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([nameEdit.text trimed].length == 0) {
        isContinue = NO;
        [nameEdit resetError];
        return;
    }else
    {
        isContinue = YES;
        [pwdEdit resetNormal];
    }
    if (!pwdEdit.text.matchPassword) {
        isContinue = NO;
        [pwdEdit resetError];
        return;
    } else {
        isContinue = YES;
        [pwdEdit resetNormal];
    }
    if (![[rePwdEdit.text trimed] isEqualToString:[pwdEdit.text trimed]]) {
        isContinue = NO;
        [rePwdEdit resetError];
        return;
    }else
    {
        isContinue = YES;
        [rePwdEdit resetNormal];
    }
    
}

- (void)regBtnClick
{
    [self onTextFieldDone:nil];
    if (isContinue) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:localStr(@"Reset Success!") delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

- (void)contactBtnClick
{
    ContactViewController *contact = [ContactViewController new];
    [self openPage:contact];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
