//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "WelcomController.h"
#import "Common.h"
#import "Masonry.h"
#import "LoginController.h"
#import "UIControl+customed.h"
#import "UIView+customed.h"
#import "StudentController.h"


@interface WelcomController ()

@end

@implementation WelcomController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIImage *image = [UIImage imageNamed:@"bg_1.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];

	[imageView layoutFill];

	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_white"]];
	[self.view addSubview:logoView];

	[logoView layoutCenterXOffsetTop:260 height:54 offset:54];


	UITextView *welText = [UITextView new];
	welText.text = localStr(@"welcome");
	welText.font = [Fonts medium:42];
	welText.textColor = UIColor.whiteColor;
	welText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:welText];
	[welText layoutFillXOffsetBottom:60 offset:260];


	UITextView *sayText = [UITextView new];
	sayText.text = localStr(@"sayhello");
	sayText.font = Fonts.heading2;
	sayText.textColor = UIColor.whiteColor;
	sayText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:sayText];
	[sayText layoutFillXOffsetBottom:40 offset:250];

	UITextView *bodyText = [UITextView new];
	bodyText.text = localStr(@"getmeet");
	bodyText.font = [Fonts regular:14];
	bodyText.textColor = UIColor.whiteColor;
	bodyText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:bodyText];
	[bodyText layoutFillXOffsetBottom:70 offset:174];


	UIButton *startButton = [UIButton new];
	[startButton title:localStr(@"getstart")];
	startButton.styleWhite;
	[self.view addSubview:startButton];
	[startButton layoutFillXOffsetBottom:BTN_HEIGHT offset:113];


	UIButton *loginButton = [UIButton new];
	[loginButton title:localStr(@"login")];
	loginButton.stylePrimary;
	[self.view addSubview:loginButton];
	[loginButton layoutFillXOffsetBottom:BTN_HEIGHT offset:65];


	[loginButton onClick:self action:@selector(clickLogin:)];
	[startButton onClick:self action:@selector(clickStudent:)];

}

- (void)clickStudent:(id)sender {
	[self openPage:[StudentController new]];
}

- (void)clickLogin:(id)sender {
	NSLog(@"click");
	LoginController *c = [LoginController new];
	[self openPage:c];
}


@end