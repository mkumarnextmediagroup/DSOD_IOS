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
#import "Async.h"
#import "Proto.h"

@interface ForgotViewController () {
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
	panic.font = [Fonts heavy:37];
	panic.textColor = UIColor.blackColor;
	panic.backgroundColor = UIColor.clearColor;
	[self.view addSubview:panic];

	UILabel *textLab = [UILabel new];
	textLab.numberOfLines = 0;
	textLab.text = localStr(@"just");
	textLab.font = [Fonts regular:17];
	textLab.textColor = UIColor.blackColor;
	textLab.backgroundColor = UIColor.clearColor;
	[self.view addSubview:textLab];

	emailEdit = self.view.addEditRoundedGray;
	emailEdit.delegate = self;
	emailEdit.hint = localStr(@"email_address");
	[emailEdit keyboardEmail];

	UIButton *sendButton = [UIButton new];
	[sendButton title:localStr(@"send")];
	[sendButton stylePrimary];
	[self.view addSubview:sendButton];

	UIView *backPanel = self.view.addView;
	UILabel *mindLabel = backPanel.addLabel;
	mindLabel.text = localStr(@"mind");
	mindLabel.textColor = rgb255(40, 40, 40);
	mindLabel.font = [Fonts regular:15];
	[mindLabel wordSpace:-0.2f];
	[[[[mindLabel.layoutMaker sizeFit] centerYParent:0] centerXParent:-mindLabel.widthThatFit - 28] install];
	UILabel *backLabel = backPanel.addLabel;
	backLabel.text = localStr(@"takeback");
	backLabel.font = [Fonts semiBold:15];
	backLabel.textColor = Colors.primary;
	[backLabel wordSpace:-0.2f];
	[[[[backLabel.layoutMaker sizeFit] centerYParent:0] toRightOf:mindLabel offset:0] install];

	StackLayout *sl = [StackLayout new];
	[sl push:backPanel height:BTN_HEIGHT marginBottom:30];
	[sl push:sendButton height:BTN_HEIGHT marginBottom:12];
	[sl push:emailEdit height:EDIT_HEIGHT marginBottom:24];
	[sl push:textLab height:60 marginBottom:12];
	[sl push:panic height:36 marginBottom:2];
	[sl install];


	[backLabel onClickView:self action:@selector(clickGoBack:)];
	[sendButton onClick:self action:@selector(sendPwdClick)];
	// Do any additional setup after loading the view.
}

- (void)clickGoBack:(id)sender {
	[self dismiss];
}

- (void)sendPwdClick {
	NSString *email = [emailEdit.text trimed];
	if (email.length < 5 || !email.matchEmail) {
		[emailEdit themeError];
		return;
	}
	[emailEdit themeNormal];

	[self sendCode:email];


}

- (void)sendCode:(NSString *)email {
	backTask(^() {
		HttpResult *r = [Proto sendEmailCode:email];
		foreTask(^() {
			if (r.OK) {
				[self onSendCodeOK:email];
			} else {
				[self alertOK:@"Error" msg:r.msg okText:nil onOK:nil];
			}
		});
	});
}

- (void)onSendCodeOK:(NSString *)email {
	[self alertOK:nil msg:localStr(@"newPwdSend") okText:nil onOK:^() {
		ResetPwdViewController *resetPwd = [ResetPwdViewController new];
		resetPwd.email = email;
		[self openPage:resetPwd];
	}];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {

	if ([emailEdit.text trimed].length < 5 || !emailEdit.text.matchEmail) {
		[emailEdit themeError];
	} else {
		[emailEdit themeNormal];
	}

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
