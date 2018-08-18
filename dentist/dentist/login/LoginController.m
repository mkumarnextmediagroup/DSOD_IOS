//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "LoginController.h"
#import "Common.h"
#import "StackLayout.h"
#import "UIView+customed.h"


@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
	[super viewDidLoad];

	UIImage *image = [UIImage imageNamed:@"bg_3.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];
	[imageView layoutFill];

	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_white"]];
	[self.view addSubview:logoView];
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54];


	UITextField *emailEdit = [UITextField new];
	emailEdit.styleNormal;
	emailEdit.delegate = self ;
	emailEdit.placeholder = localStr(@"email_address");
	[self.view addSubview:emailEdit];
	[emailEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:-23];

	UITextField *pwdEdit = [UITextField new];
	pwdEdit.styleNormal;
	pwdEdit.delegate = self ;
	pwdEdit.placeholder = localStr(@"email_address");
	[self.view addSubview:pwdEdit];
	[pwdEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:23];


	UIButton *loginButton = [UIButton new];
	[loginButton title:localStr(@"login")];
	loginButton.styleSecondary;
	[self.view addSubview:loginButton];


	UIButton *linkedinButton = [UIButton new];
	[linkedinButton title:localStr(@"login_using_linkedin")];
	linkedinButton.stylePrimary;
	[self.view addSubview:linkedinButton];


	UILabel *regLb = [UILabel new];
	regLb.textAlignment = NSTextAlignmentCenter;
	regLb.text = localStr(@"create_account");
	regLb.font = [Fonts regular:14];
	regLb.textColor = UIColor.whiteColor;
	regLb.backgroundColor = UIColor.clearColor;
	[self.view addSubview:regLb];

	StackLayout *sl = [StackLayout new];
	[sl push:regLb height:20 marginBottom:33];
	[sl push:linkedinButton height:BTN_HEIGHT marginBottom:22];
	[sl push:loginButton height:BTN_HEIGHT marginBottom:8];
	[sl install];

}


- (void)clickB:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];

}


@end