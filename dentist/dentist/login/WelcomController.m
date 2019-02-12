//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "WelcomController.h"
#import "LoginController.h"
#import "StudentController.h"
#import "Proto.h"
#import "ListPage.h"
#import "TestPage.h"


@interface WelcomController ()

@end

@implementation WelcomController


- (void)viewDidLoad {
	[super viewDidLoad];

	UIImage *image = [UIImage imageNamed:@"bg_1.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];

	[imageView layoutFill];

	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
	[self.view addSubview:logoView];
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54];


	UILabel *welText = [UILabel new];
	welText.text = localStr(@"welcome");
	welText.font = [Fonts heavy:44];
	[welText wordSpace:-1];
	welText.textColor = UIColor.whiteColor;
	welText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:welText];


	UILabel *sayText = [UILabel new];
	sayText.text = localStr(@"sayhello");
	sayText.font = [Fonts medium:19];
	[sayText wordSpace:-0.2f];
	sayText.textColor = UIColor.whiteColor;
	sayText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:sayText];

	UILabel *bodyText = [UILabel new];
	bodyText.numberOfLines = 0;
	bodyText.text = localStr(@"getmeet");
	bodyText.font = [Fonts regular:15];
	bodyText.textColor = UIColor.whiteColor;
	bodyText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:bodyText];


	UIButton *startButton = [UIButton new];
	[startButton title:localStr(@"getstart")];
	[startButton styleWhite];
	[self.view addSubview:startButton];


	UIButton *loginButton = [UIButton new];
	[loginButton title:localStr(@"login")];
	[loginButton stylePrimary];
	[self.view addSubview:loginButton];

	StackLayout *sl = [StackLayout new];
	[sl push:loginButton height:BTN_HEIGHT marginBottom:65];
	[sl push:startButton height:BTN_HEIGHT marginBottom:8];
	[sl push:bodyText height:60 marginBottom:14];
	[sl push:sayText height:30 marginBottom:12];
	[sl push:welText height:36 marginBottom:2];

	[sl install];


	[loginButton onClick:self action:@selector(clickLogin:)];
	[startButton onClick:self action:@selector(clickStudent:)];


	UIButton *testBtn = self.view.addButton;
	[testBtn title:localStr(@"测试")];
	[testBtn stylePrimary];
	[[[[[[testBtn layoutMaker] topParent:160] centerXParent:0] widthEq:330] heightEq:BTN_HEIGHT] install];

	[testBtn onClick:self action:@selector(clickTest:)];
	testBtn.hidden = YES;

}

/**
  go to the registration page from student
 */
- (void)clickStudent:(id)sender {
	[self openPage:[StudentController new]];
}

/**
 click login button, go to the registration page from student
 */
- (void)clickLogin:(id)sender {
	LoginController *c = [LoginController new];
	[self openPage:c];
}

- (void)clickTest:(id)sender {
	UIViewController *c = [TestPage new];
	[self pushPage:c];
}

@end
