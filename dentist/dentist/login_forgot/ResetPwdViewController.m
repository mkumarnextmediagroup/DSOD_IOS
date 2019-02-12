//
//  ResetPwdViewController.m
//  dentist
//
//  Created by Jacksun on 2018/8/22.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "ContactViewController.h"
#import "Async.h"
#import "Proto.h"
#import "AppDelegate.h"

@interface ResetPwdViewController () {
	UITextField *rePwdEdit;
	UITextField *pwdEdit;
	UITextField *codeEdit;
    UITextView  *noticelb;
	BOOL isContinue;
}
@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	UIImage *backImg = [UIImage imageNamed:@"close.png"];
	[self setTopTitle:localStr(@"resetPwd") bgColor:[UIColor whiteColor] imageName:backImg];

	self.view.backgroundColor = [UIColor whiteColor];

	UIImageView *logoView = self.view.addImageView;
	logoView.imageName = @"logo";
	[logoView layoutCenterXOffsetTop:260 height:54 offset:104];

	StackLayout *sl = [StackLayout new];

	UIButton *contactButton = self.view.contactButton;
	[sl push:contactButton height:BTN_HEIGHT marginBottom:12+TABLEBAR_SAFE_BOTTOM_MARGIN];

	UIButton *resetButton = self.view.resetButton;
	[resetButton title:localStr(@"resetPwdLower")];
	[sl push:resetButton height:BTN_HEIGHT marginBottom:5];

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
    [sl push:noticelb height:45 marginBottom:30];
    
    [b onClick:self action:@selector(deletePwdReqView:)];
//    UITextView *noticeLab = self.view.noticeLabel;
//    noticeLab.text = localStr(@"pwdstandard");
//    noticeLab.font = [Fonts light:10];
//    [sl push:noticeLab height:45 marginBottom:30];

    //password requirements
	UILabel *reqLabel = self.view.addLabel;
	reqLabel.text = localStr(@"pwd_req");
	reqLabel.font = [Fonts light:12];
	[reqLabel textColorPrimary];
	UIImageView *infoImgView = reqLabel.addImageView;
	infoImgView.imageName = @"info";
	[infoImgView scaleFill];
	[[[[[infoImgView layoutMaker] sizeEq:15 h:15] leftParent:0] centerYParent:0] install];
	[sl push:reqLabel height:[reqLabel heightThatFit] marginBottom:15];

    [reqLabel onClickView:self action:@selector(clickReqLabel:)];
    
	rePwdEdit = self.view.addEditRoundedGray;
	rePwdEdit.delegate = self;
	rePwdEdit.hint = localStr(@"conpwd");
	[rePwdEdit returnNext];
	[rePwdEdit returnDone];
	[rePwdEdit keyboardDefault];
	[sl push:rePwdEdit height:36 marginBottom:10];

	pwdEdit = self.view.addEditRoundedGray;
	pwdEdit.delegate = self;
	pwdEdit.hint = localStr(@"newpwd");
	[pwdEdit returnNext];
	[pwdEdit keyboardEmail];
	[sl push:pwdEdit height:36 marginBottom:10];

	codeEdit = self.view.addEditRoundedGray;
	codeEdit.delegate = self;
	codeEdit.hint = localStr(@"temppwd");
	[codeEdit returnNext];
	[codeEdit keyboardDefault];
	[sl push:codeEdit height:36 marginBottom:10];

	UILabel *lbReg = self.view.addLabel;
	lbReg.text = localStr(@"hereyou");
	lbReg.font = [Fonts regular:17];
	lbReg.numberOfLines = 0;
	lbReg.textColor = [UIColor blackColor];
//    CGSize sz = [lbReg sizeThatFits:CGSizeZero];
	[sl push:lbReg height:45 marginBottom:20];


	[sl install];

	[contactButton onClick:self action:@selector(contactBtnClick)];
	[resetButton onClick:self action:@selector(resetBtnClick)];

	// Do any additional setup after loading the view.
}

/**
 hide the password tip view
 */
- (void)deletePwdReqView:(UIButton *)btn {
    btn.superview.hidden = YES;
}

/**
 show the password error tip view
 */
- (void)clickReqLabel:(UILabel *)sender {
    
    noticelb.hidden = NO;
    
}

#pragma mark -----UITextFieldDelegate

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
	if (![[rePwdEdit.text trimed] isEqualToString:[pwdEdit.text trimed]]) {
		isContinue = NO;
		[rePwdEdit themeError];
		return;
	} else {
		isContinue = YES;
		[rePwdEdit themeNormal];
	}

}

/**
 click the reset button,that will reset the new password
 */
- (void)resetBtnClick {
	[self onTextFieldDone:nil];
	if (!isContinue) {
		return;
	}
	NSString *code = [codeEdit.text trimed];
	NSString *pwd = [pwdEdit.text trimed];

	[self showIndicator];
	backTask(^() {
		HttpResult *r = [Proto resetPwd:self.email pwd:pwd code:code];
		foreTask(^() {
			[self hideIndicator];
			if (r.OK) {
				[self onResetOK];
			} else {
				[self alertOK:nil msg:r.msg okText:nil onOK:nil];
			}
		});

	});
}

/**
 if the password is right ,that will go back to the welcome page to login
 */
- (void)onResetOK {
	[self alertOK:nil msg:localStr(@"resetOK") okText:nil onOK:^() {
		[[AppDelegate instance] switchToWelcomePage];
	}];
}

/**
 go to the contact page
 */
- (void)contactBtnClick {
	ContactViewController *contact = [ContactViewController new];
	[self openPage:contact];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
