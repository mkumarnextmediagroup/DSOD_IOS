//
//  ChangePwdViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/1/10.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "Common.h"
#import "Proto.h"
@interface ChangePwdViewController ()
{
    UITextField *pwdEdit;
    UITextField *codeEdit;
    UITextView  *noticelb;
    BOOL isContinue;
}
@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UINavigationItem *item = [self navigationItem];
    item.title = @"CHANGE PASSWORD";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
    
    UITapGestureRecognizer *keywordtap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keywordtapCLick)];
    [self.view addGestureRecognizer:keywordtap];
    
    UILabel *lbReg   = self.view.addLabel;
    lbReg.text = localStr(@"hereyou");
    lbReg.font = [Fonts regular:17];
    lbReg.numberOfLines = 0;
    lbReg.textColor = [UIColor blackColor];
    [[[[[lbReg.layoutMaker leftParent:EDGE] rightParent:-EDGE] topParent:EDGE] heightEq:45] install];
    
    codeEdit = self.view.addEditRoundedGray;
    codeEdit.delegate = self;
    codeEdit.hint = localStr(@"oldpwd");
    [codeEdit returnNext];
    codeEdit.secureTextEntry=YES;
    [pwdEdit keyboardEmail];
    [[[[[codeEdit.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:lbReg offset:EDGE] heightEq:36] install];
    
    pwdEdit = self.view.addEditRoundedGray;
    pwdEdit.delegate = self;
    pwdEdit.hint = localStr(@"newpwd");
    pwdEdit.secureTextEntry=YES;
    [pwdEdit returnNext];
    [pwdEdit keyboardEmail];
    [[[[[pwdEdit.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:codeEdit offset:10] heightEq:36] install];
    
    //password requirements
    UILabel *reqLabel = self.view.addLabel;
    reqLabel.text = localStr(@"pwd_req");
    reqLabel.font = [Fonts light:12];
    [reqLabel textColorPrimary];
    UIImageView *infoImgView = reqLabel.addImageView;
    infoImgView.imageName = @"info";
    [infoImgView scaleFill];
    [[[[[infoImgView layoutMaker] sizeEq:15 h:15] leftParent:0] centerYParent:0] install];
    [[[[[reqLabel.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:pwdEdit offset:15] heightEq:[reqLabel heightThatFit]] install];
    [reqLabel onClickView:self action:@selector(clickReqLabel:)];
    
    noticelb = [UITextView new];
    noticelb.backgroundColor = Colors.secondary;
    noticelb.textColor = UIColor.whiteColor;
    noticelb.tag = 11;
    noticelb.editable = NO;
    noticelb.textContainerInset = UIEdgeInsetsMake(10, 0, 0, 15);
    noticelb.font = [Fonts regular:10];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = makeRect(SCREENWIDTH - 88, 0, 60, BTN_HEIGHT);
    [b setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [noticelb addSubview:b];
    noticelb.text = localStr(@"pwdstandard");
    [self.view addSubview:noticelb];
    [[[[[noticelb.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:reqLabel offset:EDGE] heightEq:45] install];
    
    [b onClick:self action:@selector(deletePwdReqView:)];
    
    UIButton *resetButton = self.view.resetButton;
    [resetButton title:@"Confirm"];
    [[[[[resetButton.layoutMaker leftParent:EDGE] rightParent:-EDGE] below:noticelb offset:60] heightEq:BTN_HEIGHT] install];
    [resetButton onClick:self action:@selector(resetBtnClick)];
    
    
    // Do any additional setup after loading the view.
}

-(void)keywordtapCLick
{
    [self.view endEditing:YES];
}

- (void)deletePwdReqView:(UIButton *)btn {
    btn.superview.hidden = YES;
}

- (void)clickReqLabel:(UILabel *)sender {
    
    noticelb.hidden = NO;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([codeEdit.text trimed].length == 0) {
        isContinue = NO;
        [codeEdit themeError];
        return;
    } else {
        isContinue = YES;
        [pwdEdit themeNormal];
    }
    if (!pwdEdit.text.matchPassword) {
        isContinue = NO;
        [pwdEdit themeError];
        return;
    } else {
        isContinue = YES;
        [pwdEdit themeNormal];
    }
    
}

- (void)resetBtnClick {
    [self onTextFieldDone:nil];
    if ([codeEdit.text trimed].length == 0) {
        isContinue = NO;
        [codeEdit themeError];
        return;
    } else {
        isContinue = YES;
        [pwdEdit themeNormal];
    }
    if (!pwdEdit.text.matchPassword) {
        isContinue = NO;
        [pwdEdit themeError];
        return;
    } else {
        isContinue = YES;
        [pwdEdit themeNormal];
    }
    if (!isContinue) {
        return;
    }
    NSString *oldpwd = [codeEdit.text trimed];
    NSString *pwd = [pwdEdit.text trimed];
    [self showIndicator];
    [Proto updatePwd:getLastAccount() pwd:pwd oldpwd:oldpwd completed:^(HttpResult *result) {
        foreTask(^{
            [self hideIndicator];
            if (result.OK) {
                [self alertOK:nil msg:localStr(@"resetOK") okText:nil onOK:^() {
                    [self dismiss];
                }];
            }else {
                [self alertOK:nil msg:result.msg okText:nil onOK:nil];
            }
        });
    }];
}

@end
