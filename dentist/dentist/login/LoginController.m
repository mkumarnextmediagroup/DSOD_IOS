//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "LoginController.h"
#import "Common.h"


@interface LoginController ()

@end

@implementation LoginController {
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
	[backView makeLayout:^(MASConstraintMaker *m) {
		m.width.mas_equalTo(23);
		m.height.mas_equalTo(23);
		m.left.mas_equalTo(self.view.mas_left).offset(16);
		m.top.mas_equalTo(self.view.mas_top).offset(30);
	}];

	emailEdit = self.view.addEdit;
	emailEdit.delegate = self;
	emailEdit.hint = localStr(@"email_address");
	[emailEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:-23];

	UILabel *lb = self.view.addLabel;
	lb.text = localStr(@"login");
	lb.font = [Fonts regular:37];
//	[lb wordSpace:2];
	[lb textColorWhite];
	[lb layoutFillXOffsetCenterY:46 offset:-80];


	pwdEdit = self.view.addEdit;
	pwdEdit.delegate = self;
	pwdEdit.hint = localStr(@"pwd");
	[pwdEdit stylePassword];
//	[pwdEdit styleError];
	[pwdEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:23];

	checkButton = self.view.addCheckbox;
	checkButton.selected = YES;
	[[[[[checkButton layoutMaker] sizeEq:24 h:24] leftParent:EDGE] below:pwdEdit offset:16] install];


	UILabel *touchLabel = self.view.addLabel;
	touchLabel.text = localStr(@"enable_touch");
	[touchLabel textColorWhite];
	touchLabel.font = [Fonts light:15];
	[[[[[touchLabel layoutMaker] sizeFit] toRightOf:checkButton offset:8] centerYOf:checkButton offset:0] install];

	UILabel *forgotLabel = self.view.addLabel;
	[forgotLabel textAlignRight];
	forgotLabel.text = localStr(@"forgot");
	[forgotLabel textColorWhite];
	forgotLabel.font = [Fonts light:12];

	[[[[[forgotLabel layoutMaker] sizeFit] rightOf:pwdEdit] centerYOf:touchLabel offset:0] install];


	UIButton *loginButton = self.view.addButton;
	[loginButton title:localStr(@"login")];
	[loginButton styleSecondary];


	UIButton *linkedinButton = self.view.addButton;
	[linkedinButton title:localStr(@"login_using_linkedin")];
	[linkedinButton styleBlue];
	UIImageView *inView = linkedinButton.addImageView;
	inView.imageName = @"in";
	[inView scaleFit];
	[[[[inView.layoutMaker sizeEq:20 h:20] leftParent:10] centerYParent:0] install];
	UIView *lineView = linkedinButton.addView;
	lineView.backgroundColor = rgb255(0x2F, 0x9c, 0xD5);
	[[[[[lineView.layoutMaker widthEq:1] topParent:0] bottomParent:0] leftParent:40] install];


	UILabel *regLabel = self.view.addLabel;
	[regLabel textAlignCenter];
	regLabel.font = [Fonts regular:14];
	regLabel.textColor = UIColor.whiteColor;
	regLabel.text = localStr(@"create_account");
	[regLabel underLineSingle];


	StackLayout *sl = [StackLayout new];
	[sl push:regLabel height:20 marginBottom:33];
	[sl push:linkedinButton height:BTN_HEIGHT marginBottom:22];
	[sl push:loginButton height:BTN_HEIGHT marginBottom:8];
	[sl install];


	[regLabel onClickView:self action:@selector(clickGoReg:)];
	[backView onClick:self action:@selector(clickGoBack:)];
	[loginButton onClick:self action:@selector(clickLogin:)];
	[linkedinButton onClick:self action:@selector(clickLinkedin:)];
	[forgotLabel onClickView:self action:@selector(clickForgot:)];
}


- (void)clickGoBack:(id)sender {
	[self dismiss];
}

- (void)clickGoReg:(id)sender {
	NSLog(@"click reg ");
	NSLog(@"%@", sender);
}

- (void)clickLogin:(id)sender {
	NSLog(@"clickLogin");
}

- (void)clickLinkedin:(id)sender {
	NSLog(@"clickLinkedin ");
}

- (void)clickForgot:(id)sender {
	NSLog(@"clickForgot");
}
@end