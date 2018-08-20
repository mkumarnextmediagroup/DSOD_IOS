//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "RegController.h"
#import "LoginController.h"
#import "NSString+myextend.h"


@interface RegController ()

@end

@implementation RegController {
	UITextField *nameEdit;
	UITextField *emailEdit;
	UITextField *pwdEdit;
	UIButton *checkButton;
	UIButton *regButton;
}

- (id)init {
	self = [super init];
	self.student = false;
	return self;
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

	if (!self.student) {
		UIButton *linkedinButton = self.view.addButton;
		[linkedinButton title:localStr(@"reg_linkedin")];
		[linkedinButton styleBlue];
		UIImageView *inView = linkedinButton.addImageView;
		inView.imageName = @"in";
		[inView scaleFit];
		[[[[inView.layoutMaker sizeEq:20 h:20] leftParent:10] centerYParent:0] install ];
		UIView *lineView = linkedinButton.addView;
		lineView.backgroundColor = rgb255(0x2F, 0x9c, 0xD5);
		[sl push:linkedinButton height:BTN_HEIGHT marginBottom:22];

		[linkedinButton onClick:self action:@selector(clickLinkedin:)];
	}

	regButton = self.view.addButton;
	[regButton title:localStr(@"reg")];
	[regButton styleWhite];
	regButton.enabled = NO;
	[sl push:regButton height:BTN_HEIGHT marginBottom:10];


	UIView *termPanel = self.view.addView;
	[sl push:termPanel height:18 marginBottom:5];

	UILabel *andLabel = termPanel.addLabel;
	andLabel.font = [Fonts regular:12];
	andLabel.text = localStr(@"and");
	[[[[[andLabel layoutMaker] sizeFit] centerXParent:8] topParent:0] install];

	UILabel *termLabel = termPanel.addLabel;
	termLabel.font = [Fonts regular:12];
	termLabel.text = localStr(@"terms");
	[termLabel underLineSingle];
	[[[[[termLabel layoutMaker] sizeFit] topParent:0] toLeftOf:andLabel offset:0] install];
	[termLabel onClickView:self action:@selector(clickTerms:)];

	UILabel *policyLabel = termPanel.addLabel;
	policyLabel.font = [Fonts regular:12];
	policyLabel.text = localStr(@"policy");
	[policyLabel underLineSingle];
	[[[[[policyLabel layoutMaker] sizeFit] topParent:0] toRightOf:andLabel offset:0] install];
	[policyLabel onClickView:self action:@selector(clickPolicy:)];

	UILabel *dotLabel = termPanel.addLabel;
	dotLabel.font = [Fonts regular:12];
	dotLabel.text = @".";
	[[[[[dotLabel layoutMaker] sizeFit] topParent:0] toRightOf:policyLabel offset:0] install];


	UILabel *agreeLabel = self.view.addLabel;
	agreeLabel.font = [Fonts regular:12];
	agreeLabel.numberOfLines = 2;
	[agreeLabel textAlignCenter];
	agreeLabel.text = localStr(@"agree");
	[sl push:agreeLabel height:agreeLabel.heightThatFit marginBottom:0];


	UIView *checkPanel = self.view.addView;
	checkButton = checkPanel.addCheckbox;
	checkButton.selected = YES;
	[[[[[checkButton layoutMaker] sizeEq:24 h:24] leftParent:0] centerYParent:0] install];
	UILabel *touchLabel = checkPanel.addLabel;
	touchLabel.text = localStr(@"enable_touch");
	[touchLabel textColorWhite];
	touchLabel.font = [Fonts light:15];
	[[[[[touchLabel layoutMaker] sizeFit] toRightOf:checkButton offset:10] centerYParent:0] install];

	[sl push:checkPanel height:30 marginBottom:20];

	UILabel *reqLabel = self.view.addLabel;
	reqLabel.text = localStr(@"pwd_req");
	reqLabel.font = [Fonts light:12];
	[reqLabel textColorWhite];
	UIImageView *infoImgView = reqLabel.addImageView;
	infoImgView.imageName = @"info";
	[infoImgView scaleFill];
	[[[[[infoImgView layoutMaker] sizeEq:15 h:15] leftParent:0] centerYParent:0] install];
	[sl push:reqLabel height:[reqLabel heightThatFit] marginBottom:22];


	pwdEdit = self.view.addEdit;
	pwdEdit.delegate = self;
	pwdEdit.hint = localStr(@"pwd");
	[pwdEdit stylePassword];
	[pwdEdit returnDone];
	[pwdEdit keyboardDefault];
	[sl push:pwdEdit height:36 marginBottom:10];

	emailEdit = self.view.addEdit;
	emailEdit.delegate = self;
	emailEdit.hint = localStr(@"email_address");
	[emailEdit returnNext];
	[emailEdit keyboardEmail];
	[sl push:emailEdit height:36 marginBottom:10];

	nameEdit = self.view.addEdit;
	nameEdit.delegate = self;
	nameEdit.hint = localStr(@"full_name");
	[nameEdit returnNext];
	[nameEdit keyboardDefault];
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
	[loginLabel onClickView:self action:@selector(clickLogin:)];
}


- (void)onTextFieldDone:(UITextField *)textField {

	BOOL err = NO;
	if ([nameEdit.text trimed].length < 1) {
		[nameEdit themeError];
		err = YES;
	} else {
		[nameEdit themeNormal];
	}
	if ([emailEdit.text trimed].length < 5 || !emailEdit.text.matchEmail) {
		[emailEdit themeError];
		err = YES;
	} else {
		[emailEdit themeNormal];
	}
	if ([pwdEdit.text trimed].length < 2) {
		[pwdEdit themeError];
		err = YES;
	} else {
		[pwdEdit themeNormal];
	}
	regButton.enabled = !err;
}


- (void)clickGoBack:(id)sender {
	[self dismiss];
}

- (void)clickTerms:(id)sender {
	NSLog(@"clickTerms");
}

- (void)clickPolicy:(id)sender {
	NSLog(@"clickTerms");
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