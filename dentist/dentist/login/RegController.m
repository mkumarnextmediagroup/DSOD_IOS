//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "RegController.h"
#import "LoginController.h"


@interface RegController ()

@end

@implementation RegController {
	UITextField *nameEdit;
	UITextField *emailEdit;
	UITextField *pwdEdit;
	UIButton *checkButton;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UIImageView *imageView = self.view.addImageView;
	imageView.imageName = @"bg_3.png";
	[imageView layoutFill];

	UIImageView *logoView = self.view.addImageView;
	logoView.imageName = @"logo_white";
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54];

	UIImageView *backView = self.view.addImageView;
	backView.imageName = @"back.png";
	[backView scaleFit];
	[[[[backView.layoutMaker sizeEq:23 h:23] leftParent:16] topParent:30] install];


	//arrange controls from bottom to top
	StackLayout *sl = [StackLayout new];

	UIView *loginPanel = self.view.addView;
	loginPanel.backgroundColor = UIColor.clearColor;
	UILabel *alreadyLabel = loginPanel.addLabel;
	alreadyLabel.text = localStr(@"already_user");
	alreadyLabel.font = [Fonts regular:15];
	[alreadyLabel textColorWhite];
	[alreadyLabel textAlignRight];
	[[[[[alreadyLabel layoutMaker] sizeFit] centerXParent:-30] centerYParent:0] install];
	UILabel *loginLabel = loginPanel.addLabel;
	loginLabel.text = localStr(@"login");
	loginLabel.font = [Fonts regular:15];
	[loginLabel textColorWhite];
	[loginLabel underLineSingle];
	[[[[[loginLabel layoutMaker] sizeFit] toRightOf:alreadyLabel offset:4] centerYParent:0] install];

	[sl push:loginPanel height:20 marginBottom:33];

	UIButton *linkedinButton = self.view.addButton;
	[linkedinButton title:localStr(@"reg_linkedin")];
	linkedinButton.styleBlue;
	UIImageView *inView = linkedinButton.addImageView;
	inView.imageName = @"in";
	[inView scaleFit];
	[[[inView.layoutMaker sizeEq:20 h:20] leftParent:10] centerYParent:0].install;
	UIView *lineView = linkedinButton.addView;
	lineView.backgroundColor = rgb255(0x2F, 0x9c, 0xD5);

	[sl push:linkedinButton height:BTN_HEIGHT marginBottom:22];

	UIButton *regButton = self.view.addButton;
	[regButton title:localStr(@"reg")];
	regButton.stylePrimary;

	[sl push:regButton height:BTN_HEIGHT marginBottom:10];

	UIView *checkPanel = self.view.addView;
	checkButton = checkPanel.addCheckbox;
	checkButton.selected = YES;
	[[[[[checkButton layoutMaker] sizeEq:24 h:24] leftParent:0] centerYParent:0] install];
	UILabel *touchLabel = checkPanel.addLabel;
	touchLabel.text = localStr(@"enable_touch");
	[touchLabel textColorWhite];
	touchLabel.font = [Fonts light:15];
	[[[[[touchLabel layoutMaker] sizeFit] toRightOf:checkButton offset:10] centerYParent:0] install];

	[sl push:checkPanel height:30 marginBottom:80];

	UILabel *reqLabel = self.view.addLabel;
	reqLabel.text = localStr(@"pwd_req");
	reqLabel.font = [Fonts light:12];
	[reqLabel textColorWhite];
	[sl push:reqLabel height:[reqLabel heightThatFit] marginBottom:25];


	pwdEdit = self.view.addEdit;
	pwdEdit.delegate = self;
	pwdEdit.hint = localStr(@"pwd");
	[sl push:pwdEdit height:36 marginBottom:10];

	emailEdit = self.view.addEdit;
	emailEdit.delegate = self;
	emailEdit.hint = localStr(@"email_address");
	[sl push:emailEdit height:36 marginBottom:10];

	nameEdit = self.view.addEdit;
	nameEdit.delegate = self;
	nameEdit.hint = localStr(@"full_name");

	[sl push:nameEdit height:36 marginBottom:10];


	UILabel *lbReg = self.view.addLabel;
	lbReg.text = localStr(@"reg");
	lbReg.font = [Fonts regular:37];
	[lbReg textColorWhite];
	CGSize sz = [lbReg sizeThatFits:CGSizeZero];
	[sl push:lbReg height:sz.height marginBottom:20];


	[sl install];


	[backView onClick:self action:@selector(clickGoBack:)];
	[regButton onClick:self action:@selector(clickReg:)];
	[linkedinButton onClick:self action:@selector(clickLinkedin:)];
	[loginLabel onClick:self action:@selector(clickLogin:)];
}


- (void)clickGoBack:(id)sender {
	[self dismiss];
}


- (void)clickReg:(id)sender {
	NSLog(@"clickLogin");
}

- (void)clickLinkedin:(id)sender {
	NSLog(@"clickLinkedin ");
}

- (void)clickLogin:(id)sender {
	LoginController *c = [LoginController new];
	[self openPage:c];
}
@end