//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "LoginController.h"
#import "Common.h"
#import "StackLayout.h"
#import "UIView+customed.h"
#import "UILabel+customed.h"


@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
	[super viewDidLoad];

	UIImageView *imageView = self.view.addImageView;
	imageView.imageName = @"bg_3.png";
	[imageView layoutFill];

	UIImageView *logoView = self.view.addImageView;
	logoView.imageName = @"logo_white";
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54];


	UITextField *emailEdit = self.view.addEdit;
	emailEdit.delegate = self;
	emailEdit.placeholder = localStr(@"email_address");
	[emailEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:-23];

	UITextField *pwdEdit = self.view.addEdit;
	pwdEdit.delegate = self;
	pwdEdit.placeholder = localStr(@"email_address");
	[pwdEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:23];


	UIButton *loginButton = self.view.addButton;
	[loginButton title:localStr(@"login")];
	loginButton.styleSecondary;


	UIButton *linkedinButton = self.view.addButton;
	[linkedinButton title:localStr(@"login_using_linkedin")];
	linkedinButton.stylePrimary;


	UILabel *regLabel = self.view.addLabel;
	regLabel.textAlignment = NSTextAlignmentCenter;
	regLabel.font = [Fonts regular:14];
	regLabel.textColor = UIColor.whiteColor;
	regLabel.text = localStr(@"create_account");
	[regLabel underLineSingle];


	StackLayout *sl = [StackLayout new];
	[sl push:regLabel height:20 marginBottom:33];
	[sl push:linkedinButton height:BTN_HEIGHT marginBottom:22];
	[sl push:loginButton height:BTN_HEIGHT marginBottom:8];
	[sl install];


	[regLabel onClick:self action:@selector(goReg:)];

}

//- (void)goReg:(UITapGestureRecognizer *)recognizer {
- (void)goReg:(id)sender {
	NSLog(@"click reg ");
	NSLog(@"%@", sender);
}

- (void)clickB:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];

}


@end