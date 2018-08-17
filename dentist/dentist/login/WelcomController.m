//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "WelcomController.h"
#import "Common.h"
#import "Masonry.h"
#import "LoginController.h"


@interface WelcomController ()

@end

@implementation WelcomController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIImage *image = [UIImage imageNamed:@"bg_1.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];

	[imageView mas_makeConstraints:^(MASConstraintMaker *m) {
		m.width.equalTo(self.view.mas_width);
		m.height.equalTo(self.view.mas_height);
		m.centerX.equalTo(self.view.mas_centerX);
		m.centerY.equalTo(self.view.mas_centerY);
	}];


	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
	[self.view addSubview:logoView];
	[logoView mas_makeConstraints:^(MASConstraintMaker *m) {
		m.width.equalTo(@260);
		m.height.equalTo(@54);
		m.top.equalTo(self.view.mas_top).offset(54);
		m.centerX.equalTo(self.view.mas_centerX);
	}];

	UITextView *welText = [UITextView new];
	welText.text = @"Welcome! ";
	welText.font = [Fonts medium:42];
	welText.textColor = UIColor.whiteColor;
	welText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:welText];
	[welText mas_makeConstraints:^(MASConstraintMaker *m) {
		m.width.equalTo(@208);
		m.height.equalTo(@60);
		m.left.equalTo(self.view.mas_left).offset(EDGE);
		m.top.equalTo(self.view.mas_top).offset(360);
	}];

	UITextView *sayText = [UITextView new];
	sayText.text = @"Say hello to a new way to connect!";
	sayText.font = Fonts.heading2;
	sayText.textColor = UIColor.whiteColor;
	sayText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:sayText];
	[sayText mas_makeConstraints:^(MASConstraintMaker *m) {
		m.width.equalTo(@330);
		m.height.equalTo(@40);
		m.left.equalTo(self.view.mas_left).offset(EDGE);
		m.top.equalTo(self.view.mas_top).offset(390);
	}];

	UITextView *bodyText = [UITextView new];
	bodyText.text = @"Get to meet thousands of other health-care professionals and be one of the first few to change the way we think about dentistry.";
	bodyText.font = [Fonts regular:14];
	bodyText.textColor = UIColor.whiteColor;
	bodyText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:bodyText];
	[bodyText mas_makeConstraints:^(MASConstraintMaker *m) {
		m.width.equalTo(@330);
		m.height.equalTo(@70);
		m.left.equalTo(self.view.mas_left).offset(EDGE);
		m.top.equalTo(self.view.mas_top).offset(440);
	}];

	UIButton *startButton = [UIButton new];
	[startButton title:@"Get Started"];
	startButton.styleWhite;
	[self.view addSubview:startButton];
	[startButton mas_makeConstraints:^(MASConstraintMaker *m) {
		m.width.equalTo(@BTN_WIDTH);
		m.height.equalTo(@BTN_HEIGHT);
		m.bottom.equalTo(self.view.mas_bottom).offset(-113);
		m.centerX.equalTo(self.view.mas_centerX);
	}];


	UIButton *loginButton = [UIButton new];
	[loginButton title:@"Log In"];
	loginButton.stylePrimary;
	[self.view addSubview:loginButton];
	[loginButton mas_makeConstraints:^(MASConstraintMaker *m) {
		m.width.equalTo(@BTN_WIDTH);
		m.height.equalTo(@BTN_HEIGHT);
		m.bottom.equalTo(self.view.mas_bottom).offset(-65);
		m.centerX.equalTo(self.view.mas_centerX);
	}];


	[loginButton addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)clickLogin:(id)sender {
	NSLog(@"click");
	LoginController *c = [LoginController new];
	[self presentViewController:c animated:YES completion:nil];
}


@end